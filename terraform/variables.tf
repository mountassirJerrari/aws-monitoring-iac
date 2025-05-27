
variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
}


variable "ssh_key_name" {
  description = "The desired name for the EC2 key pair as it will appear in AWS."
  type        = string
  default     = "project-monitoring-key"
}

variable "ssh_private_key_filename" {
  description = "The filename for the generated private SSH key. This file will be saved locally in the terraform/ directory."
  type        = string
  default     = "project-monitoring-key.pem"
}


variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  description = "The CIDR block for the public subnet."
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "The Availability Zone to deploy the subnet into. e.g. us-east-1a, us-east-1b"
  type        = string
  default     = "us-east-1a"
}

variable "ssh_access_cidr" {
  description = "CIDR block allowed for SSH access. For learning, using 0.0.0.0/0. NOT FOR PRODUCTION without other controls."
  type        = string
  default     = "0.0.0.0/0"
}

variable "instance_type_monitoring" {
  description = "EC2 instance type for the monitoring server."
  type        = string
  default     = "t2.micro"
}

variable "instance_type_app" {
  description = "EC2 instance type for the application servers."
  type        = string
  default     = "t2.micro"
}
