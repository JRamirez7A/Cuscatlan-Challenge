#
# EKS Cluster Resources
#  * IAM Role to allow EKS service to manage other AWS services
#  * EC2 Security Group to allow networking traffic with EKS cluster
#  * EKS Cluster
#

resource "aws_iam_role" "cuscatlan-dev-cluster" { #! Role tu create all resourse of eKS
  name = "terraform-eks-cuscatlan-dev-cluster"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "cuscatlan-dev-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cuscatlan-dev-cluster.name
}

resource "aws_iam_role_policy_attachment" "cuscatlan-dev-cluster-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.cuscatlan-dev-cluster.name
}

resource "aws_security_group" "cuscatlan-dev-cluster" {
  name        = "terraform-eks-cuscatlan-dev-cluster"
  description = "Cluster communication with worker nodes"
  vpc_id      = aws_vpc.cuscatlan.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  } 

  tags = {
    Name                                        = "terraform-eks-cuscatlan-dev"
    "kubernetes.io/cluster/${var.cluster-name}" = "owned"
  }
}

resource "aws_security_group_rule" "cuscatlan-dev-cluster-ingress-workstation-https" {
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.cuscatlan-dev-cluster.id
  to_port           = 80
  type              = "ingress"
}

resource "aws_security_group_rule" "cuscatlan-dev2-cluster-ingress-workstation-https" {
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow workstation to communicate with the cluster API Server"
  from_port         = 9000
  protocol          = "tcp"
  security_group_id = aws_security_group.cuscatlan-dev-cluster.id
  to_port           = 9000
  type              = "ingress"
}

resource "aws_eks_cluster" "cuscatlan-dev" {
  name     = "${var.cluster-name}-dev"
  role_arn = aws_iam_role.cuscatlan-dev-cluster.arn

  vpc_config {
    security_group_ids = [aws_security_group.cuscatlan-dev-cluster.id]
    subnet_ids         = aws_subnet.cuscatlan[*].id
  }

  depends_on = [
    aws_iam_role_policy_attachment.cuscatlan-dev-cluster-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.cuscatlan-dev-cluster-AmazonEKSVPCResourceController,
  ]
}
