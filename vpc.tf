# EKS Public subnets
resource "aws_subnet" "eks-pub-sub" {
    count = length(var.eks-pub-subnet-cidr)
    vpc_id = data.aws_vpc.signeasy.id
    availability_zone = element(var.azs, count.index)
    cidr_block = element(var.eks-pub-subnet-cidr, count.index)
      tags = {
          Name = "eks-pub-sub-${count.index +1}"
      }
  
}
# Route table association with EKS public subnets
resource "aws_route_table_association" "pub-route-table-association" {
  count = length(var.eks-pub-subnet-cidr)
  subnet_id = element(aws_subnet.eks-pub-sub.*.id, count.index)
  route_table_id = data.aws_route_table.pub-route-table.id
}
# EKS Private subnets
resource "aws_subnet" "eks-int-sub" {
    count = length(var.eks-int-subnet-cidr)
    vpc_id = data.aws_vpc.signeasy.id
    availability_zone = element(var.azs, count.index)
    cidr_block = element(var.eks-int-subnet-cidr, count.index)
      tags = {
          Name = "eks-int-sub-${count.index +1}"
      }
  
}
# Route table association with EKS private subnets
resource "aws_route_table_association" "int-route-table-association" {
  count = length(var.eks-int-subnet-cidr)
  subnet_id = element(aws_subnet.eks-int-sub.*.id, count.index)
  route_table_id = data.aws_route_table.int-route.id
}
