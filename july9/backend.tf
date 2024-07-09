#moving statefile to s3 bucket

terraform {
  backend "s3" {
    bucket = "seegi"
    key = "terraform/terraform.tfstate"
    region = "ap-south-1"
  }
}