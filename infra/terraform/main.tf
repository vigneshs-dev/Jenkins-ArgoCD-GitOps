resource "aws_instance" "main" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.main.id]

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "main-instance"
  }
}