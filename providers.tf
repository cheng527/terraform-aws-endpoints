terraform {
  required_version = ">= v1.0.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.1.0"
    }
  }
}
