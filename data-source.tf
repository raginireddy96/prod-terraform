data "aws_vpc" "signeasy" {
  filter {
    name = "tag:Name"
    values = ["signeasy"]
  }
}

data "aws_subnet" "public_signeasy_sb1" {
  filter {
    name = "tag:Name"
    values = ["public_signeasy_sb1"]
  }
}

data "aws_subnet" "public_signeasy_sb2" {
  filter {
    name = "tag:Name"
    values = ["public_signeasy_sb2"]
  }
}

data "aws_subnet" "int_signeasy_sb1" {
  filter {
    name = "tag:Name"
    values = ["int_signeasy_sb1"]
  }
}

data "aws_subnet" "int_signeasy_sb2" {
  filter {
    name = "tag:Name"
    values = ["int_signeasy_sb2"]
  }
}
data "aws_route_table" "pub-route-table" {
  filter {
    name = "tag:Name"
    values = ["pub-route-table"]
  }
}
data "aws_route_table" "int-route" {
  filter {
    name = "tag:Name"
    values = ["int-route"]
  }
}