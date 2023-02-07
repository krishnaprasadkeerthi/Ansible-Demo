provider "aws" {
  region = "ap-south-1"
}
resource "aws_instance" "slave" {
  count                  = "2"
  ami                    = "ami-06984ea821ac0a879"
  instance_type          = "t2.micro"
  key_name               = "kavya"
  availability_zone      = "ap-south-1a"
  vpc_security_group_ids = [aws_security_group.my-ec2-security.id]
  tags = {
     Name = "my-ec2-instance - ${count.index}"
  } 
  provisioner "local-exec" {
    command = "echo ${aws_instance.slave.public_ip} >> dev.ini"
  }
} 
 resource "aws_security_group" "my-ec2-security" {
  name = "my-ec2-security"   
  ingress {
    description = "Allow port 22 - inbound"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow port 8080 - inbound"
    from_port   = 8080
    to_port     = 8080 
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }   
  egress {
    description = "outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
