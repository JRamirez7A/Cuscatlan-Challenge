#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#
/* data "aws_default_vpc" "default" {

} */


resource "aws_vpc" "cuscatlan" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "Name"= "terraform-eks-cuscatlan-node",
    "kubernetes.io/cluster/${var.cluster-name}"= "shared",
  }
}

resource "aws_subnet" "cuscatlan" {
  count = 4

  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.cuscatlan.id

  tags = {
    "Name" = "terraform-eks-cuscatlan-node",
    "kubernetes.io/cluster/${var.cluster-name}"= "shared",
  }
}

resource "aws_internet_gateway" "cuscatlan" {
  vpc_id = aws_vpc.cuscatlan.id

  tags = {
    Name = "terraform-eks-cuscatlan"
  }
}

resource "aws_route_table" "cuscatlan" {
  vpc_id = aws_vpc.cuscatlan.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cuscatlan.id
  }
}

resource "aws_route_table_association" "cuscatlan" {
  count = 2

  subnet_id      = aws_subnet.cuscatlan.*.id[count.index]
  route_table_id = aws_route_table.cuscatlan.id
}
