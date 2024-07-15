variable "project" {
  type = string
  default = "prj1"
}

variable "environment" {
  type = string
  default = "test"
}

variable "name" {
  type = string
  default = "prj"
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "private_subnets" {
  type = map(number)
  default = {
    "priv-subnet-a" = 1
    "priv-subnet-b" = 2
  }
}

variable "public_subnets" {
  type = map(number)
  default = {
    "pub-subnet-a" = 3
    "pub-subnet-b" = 4
  }
}