variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "ami" {
  description = "EC2 AMI"
  default     = "ami-0866a3c8686eaeeba"
}

variable "key_name" {
  description = "EC2 key pair name"
  default     = "terraform-keypair"
}