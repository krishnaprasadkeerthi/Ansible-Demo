provider "aws" {
  region = var.region
}
resource "aws_instance" "sample-instance" {
  count           = var.instances_count
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = ["${var.security_groups}"]
  key_name        = var.key
  tags = {
    Name = "First Terraform Instance - ${count.index}"
  }
}
