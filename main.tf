terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.14.0"
    }
  }

  required_version = ">= 0.14.9"

  backend "s3" {
       bucket = "leighiamvirrey.com-terraform-statefile"
       key    = "terraform.tfstate"
       region = "us-west-1"
       encrypt = true
  }
}