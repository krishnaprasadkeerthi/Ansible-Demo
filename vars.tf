variable "region" {
  description = "Name of the Region"
  default     = "ap-south-1"
}

variable "ami" {
  description = "Amazon Machine Image Value"
  default     = "ami-06984ea821ac0a879"
}

variable "instance_type" {
  description = "Amazon Instance Type T2.micro"
  default     = "t2.micro"
}

variable "instances_count" {
  description = "No of Instances"
#  default     = "2"
}

variable "security_groups" {
  description = "Name of the security group"
  default     = "launch-wizard-7"
}

variable "key" {
  description = "Name of the pem key file"
  default     = "kavya"
}
