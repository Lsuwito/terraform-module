resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = format("%s-igw", var.vpc_name)
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_eip" "nat_gateway" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.public[0].id
  tags = {
    Name = format("%s-nat-gw", var.vpc_name)
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "private" {
  count                = length(var.private_subnet_cidr_blocks)
  vpc_id               = aws_vpc.main.id
  cidr_block           = var.private_subnet_cidr_blocks[count.index]
  availability_zone_id = data.aws_availability_zones.available.zone_ids[count.index]
  tags = {
    Name = format("%s-private-subnet-%s", var.vpc_name, count.index)
  }
}

resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidr_blocks)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr_blocks[count.index]
  availability_zone_id    = data.aws_availability_zones.available.zone_ids[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = format("%s-public-subnet-%s", var.vpc_name, count.index)
  }
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

resource "aws_security_group" "bastion" {
  count  = length(var.allow_ssh_to_instance_from) > 0 ? 1 : 0
  name   = "bastion-sg"
  vpc_id = aws_vpc.main.id
  ingress {
    description = "SSH from specific IP addresses"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allow_ssh_to_instance_from
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
