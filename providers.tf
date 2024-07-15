terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.58.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

locals {
  tags = {
    Name = var.name
    environment = var.environment
    ManagedBy = "Terraform"
    subnet = {
        environment = local.tags.environment
        ManagedBy = local.tags.ManagedBy
    }
  }
}

terraform {
  backend "s3" {
    bucket  = "test-tf-tfstate"
    key     = "test-tf.tfstate"
    encrypt = "true"
    region  = "us-east-1"
  }
}