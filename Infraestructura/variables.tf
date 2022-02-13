variable "aws_region" {
  default     = "us-east-1"
  description = "Regions of aws"
}

variable "cluster-name" {
  default     = "terraform-eks-cuscatlan"
  description = "Cluster's Name"
}

output "cluster-name" {
  value = var.cluster-name
}


variable "environment" {
  default     = "development"
  description = "Environment development"
}

variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "cidr for vpc"
}

variable "public_subnets_cidr" {
  description = "count of public subnet"
  default     = 1
}

