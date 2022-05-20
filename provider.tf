provider "aws" {
  region = "us-west-1"
}

provider "aws" {
  alias  = "acm_provider"
  region = "us-east-1"
}