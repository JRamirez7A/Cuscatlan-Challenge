#
# EKS Worker Nodes Resources
#  * IAM role allowing Kubernetes actions to access other AWS services
#  * EKS Node Group to launch worker nodes
#

resource "aws_iam_role" "cuscatlan-node" {
  name = "terraform-eks-cuscatlan-node"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "cuscatlan-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.cuscatlan-node.name
}

resource "aws_iam_role_policy_attachment" "cuscatlan-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.cuscatlan-node.name
}

resource "aws_iam_role_policy_attachment" "cuscatlan-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.cuscatlan-node.name
}

resource "aws_eks_node_group" "cuscatlan" {
  cluster_name    = aws_eks_cluster.cuscatlan.name
  node_group_name = "cuscatlan"
  node_role_arn   = aws_iam_role.cuscatlan-node.arn
  subnet_ids      = aws_subnet.cuscatlan[*].id
  instance_types  = ["t3.medium"]
  disk_size       = 20

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.cuscatlan-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.cuscatlan-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.cuscatlan-node-AmazonEC2ContainerRegistryReadOnly,
  ]
}
