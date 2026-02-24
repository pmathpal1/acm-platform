terraform {
  backend "s3" {
    bucket         = "pankaj-terraform-state-001"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
