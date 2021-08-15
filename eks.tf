# EKS cluster
resource "aws_eks_cluster" "eks-ohio-dr" {
  name     = "eks-ohio-dr"
  role_arn = "arn:aws:iam::445819549122:role/eks-role-eks-production-02"
  version = "1.15"

  vpc_config {
    subnet_ids = [aws_subnet.eks-int-sub[0].id, aws_subnet.eks-int-sub[1].id, aws_subnet.eks-int-sub[2].id, aws_subnet.eks-int-sub[3].id, aws_subnet.eks-int-sub[4].id, aws_subnet.eks-int-sub[5].id, aws_subnet.eks-pub-sub[0].id, aws_subnet.eks-pub-sub[1].id, aws_subnet.eks-pub-sub[2].id, aws_subnet.eks-pub-sub[3].id, aws_subnet.eks-pub-sub[4].id]
    security_group_ids = [aws_security_group.eks-ohio-dr-sg.id, aws_security_group.eks-ohio-dr-sg2.id]

  }
  kubernetes_network_config {
    service_ipv4_cidr = "10.100.0.0/16"
  }
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  tags = {
    Name = "eks-ohio-dr"

  }
}

#EKS Node group
resource "aws_eks_node_group" "eks-ohio-dr-node-group" {
  cluster_name    = aws_eks_cluster.eks-ohio-dr.name
  node_group_name = "eks-ohio-dr-node-group"
  node_role_arn   = "arn:aws:iam::445819549122:role/iam-eks-production-02"
  subnet_ids      = [aws_subnet.eks-int-sub[0].id, aws_subnet.eks-int-sub[1].id, aws_subnet.eks-int-sub[2].id, aws_subnet.eks-int-sub[3].id, aws_subnet.eks-int-sub[4].id, aws_subnet.eks-int-sub[5].id]
  capacity_type = "ON_DEMAND"
  instance_types = ["c5.xlarge"]
  ami_type = "AL2_x86_64"
  disk_size = 100
  remote_access {
    ec2_ssh_key = "terraform-prod"
    source_security_group_ids = [aws_security_group.signeasy_team_ext_sg.id ]
  }
  labels = {
    "node-group" = "eks-production-02-node-group"
    "instance-type" = "c5-xlarge"
  }

  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 2
  }
  tags = {
    Name = "eks-ohio-dr-node-group"

  }

  
}