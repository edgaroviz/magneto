terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.58.0"

    }
  }

  backend "s3" {
    bucket = "united-state-file"
    key    = "argo_cd.tfstate"
    region = "eu-west-1"
  }
}

provider "aws" {
  region  = "eu-west-1"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
}