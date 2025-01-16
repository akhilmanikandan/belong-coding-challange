terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-akhil"
    key            = "terraform/vpc-alb-ec2/terraform.tfstate"
    region         = "ap-southeast-2"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}
