
aws_region       = "ap-southeast-2"
vpc_cidr_block   = "10.0.0.0/16"
public_subnets   = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]
vpc_name         = "my-vpc"
instance_type    = "t2.micro"
ami_id           = "ami-0a8f40a451672ea1d" # Replace with your specific AMI ID
