resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "main" {
  count      = length(var.subnet_cidr_blocks)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr_blocks[count.index]
  tags = {
    Name = format("%s-subnet-%s", var.vpc_name, count.index)
  }
}
