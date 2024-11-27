terraform {
  backend "s3" {
    bucket = "quickfood-backend-tf"
    key = "quickfood/terraform.tfstate"
    region = "us-east-1"
  }
}