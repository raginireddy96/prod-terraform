variable "AWS-Region" {
    default = "us-east-2"
}

variable "azs" {
    type = list
    default = ["us-east-2a","us-east-2b","us-east-2c"]
}    


variable "eks-pub-subnet-cidr" {
    type = list
    default = ["172.31.30.0/24","172.31.31.0/24","172.31.33.0/24","172.31.34.0/24","172.31.35.0/24"]
}

variable "eks-int-subnet-cidr" {
    type = list
    default = ["172.31.20.0/24","172.31.21.0/24","172.31.22.0/24","172.31.23.0/24","172.31.24.0/24","172.31.25.0/24"]
}