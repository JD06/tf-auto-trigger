resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"

  tags = local.tags
}

resource "aws_subnet" "private_subnet" {
    for_each = var.private_subnets
    vpc_id = aws_vpc.this.id
    map_public_ip_on_launch = false
    cidr_block = cidrsubnet(aws_vpc.this.cidr_block, 4, each.value)

    tags = {
        Name = "${var.environment}-priv-${each.value}"
        environment = var.environment
        ManagedBy = "Terraform"
    }
}

resource "aws_subnet" "public_subnet" {
    for_each = var.public_subnets
    vpc_id = aws_vpc.this.id
    map_public_ip_on_launch = true
    cidr_block = cidrsubnet(aws_vpc.this.cidr_block, 4, each.value)

    tags = {
        Name = "${var.environment}-pub-${each.value}"
        environment = var.environment
        ManagedBy = "Terraform"
    }
}