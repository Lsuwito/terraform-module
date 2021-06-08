resource "aws_instance" "main" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  user_data              = var.user_data
  vpc_security_group_ids = var.security_group_ids
}
