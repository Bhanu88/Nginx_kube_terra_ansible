variable "region" {
  description = "AWS region for hosting our your network"
  default     = "us-east-1"
}

variable "key_path" {
  description = "Key path for SSHing into EC2"
  default     = "bhanupr.ppk"
}

variable "key_name" {
  description = "Key name for SSHing into EC2"
  default     = "bhanupr"
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
  default     = "10.0.1.0/24"
}

variable "amis" {
  description = "Base AMI to launch the instances"

  default = {
    us-east-1      = "ami-759bc50a"
    ap-southeast-2 = "ami-cfe4b2b0"
  }
}

output "Master" {
  value = "${aws_instance.Master.public_dns}"
}

output "Worker" {
  value = "${aws_instance.Worker.public_dns}"
}
