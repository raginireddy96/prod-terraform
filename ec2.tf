# ec2 for notifications-api servers
resource "aws_instance" "notifications-api" {
  count = 2
  availability_zone = "us-east-2b"
  subnet_id = data.aws_subnet.int_signeasy_sb2.id 
  ami           = "ami-00f59492ce0cd352e"
  instance_type = "t2.medium"
  vpc_security_group_ids = [aws_security_group.signeasy_prod_int_sg.id]
  key_name = "terraform-prod"
  root_block_device {
    volume_type = "gp2"
    volume_size = "80"
    delete_on_termination = "true"
  }
  tags = {
    Name = "notifications-api-${count.index +1}"
    ELB = "YES"
  }
}

# ec2 for  file-operation servers
resource "aws_instance" "file-operation" {
  count = 2
  availability_zone = "us-east-2b"
  subnet_id = data.aws_subnet.int_signeasy_sb2.id 
  ami           = "ami-089f3a8bfc50c7ab4"
  instance_type = "t2.xlarge"
  vpc_security_group_ids = [aws_security_group.signeasy_prod_int_sg.id]
  key_name = "terraform-prod"
  root_block_device {
    volume_type = "gp2"
    volume_size = "120"
    delete_on_termination = "true"
  }
  tags = {
    Name = "file-operation-${count.index +1}"
    ELB = "YES"
    Group = "file-operation-production"
  }
}

# ec2 for  filesystem  servers
resource "aws_instance" "filesystem" {
  count = 8
  availability_zone = "us-east-2b"
  subnet_id = data.aws_subnet.int_signeasy_sb2.id 
  ami           = "ami-0023bda8750a09d26"
  instance_type = "t2.medium"
  vpc_security_group_ids = [aws_security_group.signeasy_prod_int_sg.id]
  key_name = "terraform-prod"
  root_block_device {
    volume_type = "gp2"
    volume_size = "80"
    delete_on_termination = "true"
  }
  tags = {
    Name = "filesystem-${count.index +1}"
    ELB = "YES"
    Group = "preference-and-filesystem-production"
  }
}

# ec2 for  request-signatures  servers
resource "aws_instance" "request-signatures" {
  count = 8
  availability_zone = "us-east-2b"
  subnet_id = data.aws_subnet.int_signeasy_sb2.id 
  ami           = "ami-058d6e067e6cf9739"
  instance_type = "t2.medium"
  vpc_security_group_ids = [aws_security_group.signeasy_prod_int_sg.id]
  key_name = "terraform-prod"
  root_block_device {
    volume_type = "gp2"
    volume_size = "80"
    delete_on_termination = "true"
  }
  tags = {
    Name = "request-signatures-${count.index +1}"
  }
}

# ec2 for  aux-api  servers
resource "aws_instance" "aux-api" {
  count = 2
  availability_zone = "us-east-2a"
  subnet_id = data.aws_subnet.int_signeasy_sb1.id 
  ami           = "ami-0888a277a0cf9d19c"
  instance_type = "t2.medium"
  vpc_security_group_ids = [aws_security_group.signeasy_prod_int_sg.id]
  key_name = "terraform-prod"
  root_block_device {
    volume_type = "gp2"
    volume_size = "30"
    delete_on_termination = "true"
  }
  tags = {
    Name = "aux-api-${count.index +1}"
    ELB = "YES"
  }
}

# ec2 for aux-worker servers
resource "aws_instance" "aux-worker" {
  count = 2
  availability_zone = "us-east-2a"
  subnet_id = data.aws_subnet.int_signeasy_sb1.id 
  ami           = "ami-01e30e4c7ca40fe61"
  instance_type = "t2.medium"
  vpc_security_group_ids = [aws_security_group.signeasy_prod_int_sg.id]
  key_name = "terraform-prod"
  root_block_device {
    volume_type = "gp2"
    volume_size = "30"
    delete_on_termination = "true"
  }
  tags = {
    Name = "aux-worker-${count.index +1}"
    ELB = "YES"
  }
}

# ec2 for aux-callbacks-worker servers
resource "aws_instance" "aux-callbacks-worker" {
  count = 2
  availability_zone = "us-east-2a"
  subnet_id = data.aws_subnet.int_signeasy_sb1.id 
  ami           = "ami-05cc365f2ee10e502"
  instance_type = "t2.medium"
  vpc_security_group_ids = [aws_security_group.signeasy_prod_int_sg.id]
  key_name = "terraform-prod"
  root_block_device {
    volume_type = "gp2"
    volume_size = "30"
    delete_on_termination = "true"
  }
  tags = {
    Name = "aux-callbacks-worker-${count.index +1}"
    ELB = "YES"
  }
}
# ec2 for aux-hubspot-worker servers
resource "aws_instance" "aux-hubspot-worker" {
  count = 1
  availability_zone = "us-east-2a"
  subnet_id = data.aws_subnet.int_signeasy_sb1.id 
  ami           = "ami-02b2360cd4e8b433c"
  instance_type = "t2.medium"
  vpc_security_group_ids = [aws_security_group.signeasy_prod_int_sg.id]
  key_name = "terraform-prod"
  root_block_device {
    volume_type = "gp2"
    volume_size = "30"
    delete_on_termination = "true"
  }
  tags = {
    Name = "aux-hubspot-worker-${count.index +1}"
  }
}
# ec2 for eagle servers
resource "aws_instance" "eagle" {
  count = 6
  availability_zone = "us-east-2b"
  subnet_id = data.aws_subnet.int_signeasy_sb2.id 
  ami           = "ami-05bad8fd3d896a558"
  instance_type = "t2.medium"
  vpc_security_group_ids = [aws_security_group.signeasy_prod_int_sg.id]
  key_name = "terraform-prod"
  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
    delete_on_termination = "true"
  }
  tags = {
    Name = "eagle-${count.index +1}"
    ELB = "YES"
  }
}
# ec2 for archiving-api servers
resource "aws_instance" "archiving-api" {
  count = 2
  availability_zone = "us-east-2a"
  subnet_id = data.aws_subnet.int_signeasy_sb1.id 
  ami           = "ami-0cf3a74513d4884c5"
  instance_type = "t2.medium"
  vpc_security_group_ids = [aws_security_group.signeasy_prod_int_sg.id]
  key_name = "terraform-prod"
  root_block_device {
    volume_type = "gp2"
    volume_size = "50"
    delete_on_termination = "true"
  }
  tags = {
    Name = "archiving-api-${count.index +1}"
    ELB = "YES"
  }
}

# ec2 for archiving-worker servers
resource "aws_instance" "archiving-worker" {
  count = 2
  availability_zone = "us-east-2b"
  subnet_id = data.aws_subnet.int_signeasy_sb2.id 
  ami           = "ami-07152e995bee1ae2d"
  instance_type = "t2.medium"
  vpc_security_group_ids = [aws_security_group.signeasy_prod_int_sg.id]
  key_name = "terraform-prod"
  root_block_device {
    volume_type = "gp2"
    volume_size = "50"
    delete_on_termination = "true"
  }
  tags = {
    Name = "archiving-worker-${count.index +1}"
    ELB = "YES"
  }
}
# ec2 for rq-v4 servers
resource "aws_instance" "rq-v4" {
  count = 4
  availability_zone = "us-east-2a"
  subnet_id = data.aws_subnet.int_signeasy_sb1.id 
  ami           = "ami-0dfe90e637dd033c2"
  instance_type = "t2.medium"
  iam_instance_profile = "EC2-CodeDeploy"
  vpc_security_group_ids = [aws_security_group.signeasy_prod_int_sg.id]
  key_name = "terraform-prod"
  root_block_device {
    volume_type = "gp2"
    volume_size = "80"
    delete_on_termination = "true"
  }
  tags = {
    Name = "rq-v4-${count.index +1}"
  }
}
# ec2 for plans-api servers
resource "aws_instance" "plans-api" {
  count = 1
  availability_zone = "us-east-2b"
  subnet_id = data.aws_subnet.int_signeasy_sb2.id 
  ami           = "ami-0d438b26295733103"
  instance_type = "t2.medium"
  vpc_security_group_ids = [aws_security_group.signeasy_prod_int_sg.id]
  key_name = "terraform-prod"
  root_block_device {
    volume_type = "gp2"
    volume_size = "50"
    delete_on_termination = "true"
  }
  tags = {
    Name = "plans-api-${count.index +1}"
    ELB = "YES"
  }
}

# ec2 for ms-teams servers
resource "aws_instance" "ms-teams" {
  count = 2
  availability_zone = "us-east-2b"
  subnet_id = data.aws_subnet.int_signeasy_sb2.id 
  ami           = "ami-0a4d8355dcc412729"
  instance_type = "t2.medium"
  vpc_security_group_ids = [aws_security_group.signeasy_prod_int_sg.id]
  iam_instance_profile = "read-secrets"
  key_name = "terraform-prod"
  root_block_device {
    volume_type = "gp2"
    volume_size = "30"
    delete_on_termination = "true"
  }
  tags = {
    Name = "ms-teams-${count.index +1}"
  }
}

# ec2 for conversion-BCL8 servers
resource "aws_instance" "conversion-BCL8" {
  count = 3
  availability_zone = "us-east-2b"
  subnet_id = data.aws_subnet.int_signeasy_sb2.id 
  ami           = "ami-0bbb9f3a91ec87daf"
  instance_type = "m5.4xlarge"
  vpc_security_group_ids = [aws_security_group.signeasy_prod_int_sg.id]
  key_name = "terraform-prod"
  root_block_device {
    volume_type = "gp2"
    volume_size = "100"
    delete_on_termination = "true"
  }
  tags = {
    Name = "conversion-BCL8-${count.index +1}"
     ELB = "YES"
  }
}
# ec2 for Dashboard servers
resource "aws_instance" "dashboard" {
  count = 1
  availability_zone = "us-east-2a"
  subnet_id = data.aws_subnet.int_signeasy_sb1.id 
  ami           = "ami-0d41ba3fd125d4717"
  instance_type = "t2.medium"
  vpc_security_group_ids = [aws_security_group.signeasy_prod_int_sg.id]
  key_name = "terraform-prod"
  root_block_device {
    volume_type = "gp2"
    volume_size = "30"
    delete_on_termination = "true"
  }
  tags = {
    Name = "dashboard-${count.index +1}"
     ELB = "YES"
  }
}

# ec2 for permissions servers
resource "aws_instance" "permissions" {
  count = 1
  availability_zone = "us-east-2b"
  subnet_id = data.aws_subnet.int_signeasy_sb2.id 
  ami           = "ami-0748d9e946f9950d1"
  instance_type = "t2.medium"
  vpc_security_group_ids = [aws_security_group.signeasy_prod_int_sg.id]
  key_name = "terraform-prod"
  root_block_device {
    volume_type = "gp2"
    volume_size = "30"
    delete_on_termination = "true"
  }
  tags = {
    Name = "permissions-${count.index +1}"
    ELB = "YES"
  }
}
# ec2 for push servers
#resource "aws_instance" "push" {
 # count = 1
  #availability_zone = "us-east-2a"
  #subnet_id = data.aws_subnet.int_signeasy_sb1.id 
 # ami           = "ami-0f3f6cf6e12199e1e"
 # instance_type = "t2.micro"
 # vpc_security_group_ids = [aws_security_group.signeasy_prod_int_sg.id]
 # key_name = "terraform-prod"
 # root_block_device {
 #   volume_type = "gp2"
 #   volume_size = "40"
 #   delete_on_termination = "true"
 # }
 # tags = {
 #   Name = "push-${count.index +1}"
 #   ELB = "YES"
 # }
#}
# ec2 for template servers
resource "aws_instance" "template" {
  count = 4
  availability_zone = "us-east-2b"
  subnet_id = data.aws_subnet.int_signeasy_sb2.id 
  ami           = "ami-094742048f4506784"
  instance_type = "t2.medium"
  vpc_security_group_ids = [aws_security_group.signeasy_prod_int_sg.id]
  key_name = "terraform-prod"
  root_block_device {
    volume_type = "gp2"
    volume_size = "80"
    delete_on_termination = "true"
  }
  tags = {
    Name = "template-${count.index +1}"
    ELB = "YES"
    Group = "template-production"
  }
}

# ec2 for  new-user-ms-accounts servers
resource "aws_instance" "new-user-ms-accounts" {
  count = 2
  availability_zone = "us-east-2b"
  subnet_id = data.aws_subnet.int_signeasy_sb2.id 
  ami           = "ami-08e605b362dc6e611"
  instance_type = "t2.small"
  vpc_security_group_ids = [aws_security_group.signeasy_prod_int_sg.id]
  key_name = "terraform-prod"
  root_block_device {
    volume_type = "gp2"
    volume_size = "10"
    delete_on_termination = "true"
  }
  tags = {
    Name = "new-user-ms-accounts-${count.index +1}"
    ELB = "YES"
  }
}

# ec2 for api-v3 servers
resource "aws_instance" "api-v3" {
  count = 2
  availability_zone = "us-east-2b"
  subnet_id = data.aws_subnet.int_signeasy_sb2.id 
  ami           = "ami-05776d327d27c06b4"
  instance_type = "t2.medium"
  vpc_security_group_ids = [aws_security_group.signeasy_prod_int_sg.id]
  key_name = "terraform-prod"
  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
    delete_on_termination = "true"
  }
  tags = {
    Name = "api-v3-${count.index +1}"
    ELB = "YES"
  }
}

# ec2 for api-ext servers
resource "aws_instance" "api-ext" {
  count = 2
  availability_zone = "us-east-2b"
  subnet_id = data.aws_subnet.int_signeasy_sb2.id 
  ami           = "ami-0ba5cc416f5459f98"
  instance_type = "t2.medium"
  vpc_security_group_ids = [aws_security_group.signeasy_prod_int_sg.id]
  key_name = "terraform-prod"
  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
    delete_on_termination = "true"
  }
  tags = {
    Name = "api-ext-${count.index +1}"
    ELB = "YES"
  }
}
# ec2 for api-demo servers
resource "aws_instance" "api-demo" {
  count = 1
  availability_zone = "us-east-2b"
  subnet_id = data.aws_subnet.int_signeasy_sb2.id 
  ami           = "ami-022dabd48cda31ebd"
  instance_type = "t2.small"
  vpc_security_group_ids = [aws_security_group.signeasy_prod_int_sg.id]
  key_name = "terraform-prod"
  root_block_device {
    volume_type = "gp2"
    volume_size = "40"
    delete_on_termination = "true"
  }
  tags = {
    Name = "api-demo-${count.index +1}"
  }
}
# ec2 for jumphost.getsigneasy.com servers
resource "aws_instance" "jumphost-getsigneasy-com" {
  availability_zone = "us-east-2a"
  subnet_id = data.aws_subnet.public_signeasy_sb1.id 
  ami           = "ami-01e7ca2ef94a0ae86"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.signeasy_team_ext_sg.id]
  associate_public_ip_address = "true"
  key_name = "terraform-prod"
  root_block_device {
    volume_type = "gp2"
    volume_size = "80"
    delete_on_termination = "true"
  }
  ebs_block_device {
    device_name = "/dev/sdf"
    volume_type = "gp2"
    volume_size = "15"
    delete_on_termination = "true"
  }
  tags = {
    Name = "jumphost-getsigneasy-com"
    ELB = "No"
  }
}
# elastic-ip for jumphost-getsigneasy-com
resource "aws_eip" "getsigneasy-jumphost-eip" {
  instance = aws_instance.jumphost-getsigneasy-com.id
  vpc      = true
}

# ec2 for eks-jumphost servers
resource "aws_instance" "eks-jumphost" {
  availability_zone = "us-east-2a"
  subnet_id = data.aws_subnet.public_signeasy_sb1.id 
  ami           = "ami-01e7ca2ef94a0ae86"
  instance_type = "t2.medium"
  vpc_security_group_ids = [aws_security_group.eks-jumphost-sg.id]
  associate_public_ip_address = "true"
  key_name = "terraform-prod"
  root_block_device {
    volume_type = "gp2"
    volume_size = "100"
    delete_on_termination = "true"
  }
  
  tags = {
    Name = "eks-jumphost"
    ELB = "No"
  }
}
# elastic-ip for eks-jumphost
resource "aws_eip" "eks-jumphost-eip" {
  instance = aws_instance.eks-jumphost.id
  vpc      = true
}
