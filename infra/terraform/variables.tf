variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.medium"
}

variable "ami" {
  description = "EC2 AMI"
  default     = "ami-04b4f1a9cf54c11d0"
}

variable "key_name" {
  description = "EC2 key pair name"
  default     = "terraform-keypair"
}