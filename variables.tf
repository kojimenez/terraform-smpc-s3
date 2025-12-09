variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-southeast-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "main-server_instance_type" {
  description = "EC2 instance type for K3s nodes"
  type        = string
  default     = "t3a.micro"
}

variable "app-server_instance_type" {
  description = "EC2 instance type for Jenkins"
  type        = string
  default     = "t3a.micro"
}

variable "airflow_instance_type" {
  description = "EC2 instance type for Jenkins"
  type        = string
  default     = "t3a.micro"
}

variable "key_pair_name" {
  description = "SSH key pair name for EC2 instances"
  type        = string
}

variable "allowed_cidrs" {
  description = "allowed cidr blocks for EC2 SG"
  type = list(string)
}