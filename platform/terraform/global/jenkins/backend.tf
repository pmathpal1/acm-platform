terraform {
  backend "s3" {
    bucket         = "pankaj-terraform-state-001"
    key            = "global/jenkins/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}


#dop_v1_56dbc5ca4d8a117fa7c85be7444f3899b2af5c5e647fb4976f60a340cbeb6c91cd .././


