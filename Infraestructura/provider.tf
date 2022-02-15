terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = "us-east-1"
} 

data "aws_availability_zones" "available" {}

provider "http" {}
