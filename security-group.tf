# Security group for webapp
resource "aws_security_group" "signeasy_webapp_sg" {
  name        = "signeasy_webapp_sg"
  description = "sg_webapp"
  vpc_id      = data.aws_vpc.signeasy.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [data.aws_vpc.signeasy.cidr_block]
  }
  ingress {
    from_port   = 1338
    to_port     = 1338
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["106.51.68.8/32"]
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "signeasy_webapp_sg"
  }
}

# Security group for signeasy_elb_prod_sg_http
resource "aws_security_group" "signeasy_elb_prod_sg_http" {
  name        = "signeasy_elb_prod_sg_http"
  description = "signeasy_elb_prod_sg_http"
  vpc_id      = data.aws_vpc.signeasy.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [data.aws_vpc.signeasy.cidr_block]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }
  

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "signeasy_elb_prod_sg_http"
  }
}
# Security group for signeasy_team_ext_sg
resource "aws_security_group" "signeasy_team_ext_sg" {
  name        = "signeasy_team_ext_sg"
  description = "signeasy_team_ext_sg"
  vpc_id      = data.aws_vpc.signeasy.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [data.aws_vpc.signeasy.cidr_block]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["92.98.204.178/32"]
  }
  ingress {
    from_port   = 2222
    to_port     = 2222
    protocol    = "tcp"
    cidr_blocks = ["3.216.217.14/32"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }
  #ingress {
   # from_port   = 0
   # to_port     = 65535
   # protocol    = "tcp"
   # security_groups = [aws_security_group.signeasy_prod_int_sg.id]
  #}
  

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "signeasy_team_ext_sg"
  }
}

# Security group for signeasy_prod_int_sg
resource "aws_security_group" "signeasy_prod_int_sg" {
  name        = "signeasy_prod_int_sg"
  description = "signeasy_prod_int_sg"
  vpc_id      = data.aws_vpc.signeasy.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [data.aws_vpc.signeasy.cidr_block]
  }
  #ingress {
   # from_port   = 0
   # to_port     = 0
   # protocol    = "-1"
   # security_groups = [aws_security_group.kwery.id]
  #}
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["172.31.1.139/32"]
  }
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.signeasy.cidr_block]
  }
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    self = "true"
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    self = "true"
  }
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    security_groups = [aws_security_group.signeasy_team_ext_sg.id]
  }
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "udp"
    self = "true"
  }
  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    self = "true"
  }
  

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "signeasy_prod_int_sg"
  }
}

# Security group for webapp
resource "aws_security_group" "kwery" {
  name        = "kwery"
  description = "kwery"
  vpc_id      = data.aws_vpc.signeasy.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [data.aws_vpc.signeasy.cidr_block]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["106.51.68.8/32"]
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    ipv6_cidr_blocks = ["::/0"]
    
  }
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    security_groups = [aws_security_group.signeasy_prod_int_sg.id]
    
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }
  

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kwery"
  }
}

# Security group for eks-jumphost
resource "aws_security_group" "eks-jumphost-sg" {
  name        = "eks-jumphost-sg"
  description = "eks-jumphost-sg"
  vpc_id      = data.aws_vpc.signeasy.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [data.aws_vpc.signeasy.cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-jumphost-sg"
  }
}
# Security group for eks-ohio-dr cluster
resource "aws_security_group" "eks-ohio-dr-sg" {
  name        = "eks-ohio-dr-sg"
  description = "eks-ohio-dr-sg"
  vpc_id      = data.aws_vpc.signeasy.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    security_groups = [aws_security_group.eks-jumphost-sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-ohio-dr-sg"
  }
}
# Security group for eks-ohio-dr cluster
resource "aws_security_group" "eks-ohio-dr-sg2" {
  name        = "eks-ohio-dr-sg2"
  description = "eks-ohio-dr-sg2"
  vpc_id      = data.aws_vpc.signeasy.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self = "true"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-ohio-dr-sg2"
  }
}