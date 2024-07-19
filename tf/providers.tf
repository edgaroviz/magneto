provider "aws" {
  region = "eu-west-1"
}

terraform {
  required_version = "1.9.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.58"
    }
  }

  backend "s3" {
    bucket = "united-state-file-hazut"
    key    = "eks-cluster.tfstate"
    region = "eu-west-1"
  }
}