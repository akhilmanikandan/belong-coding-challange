variable "aws_region" {
  description = "The AMI ID for the EC2 instance."
  type        = string
  default     = "ap-southeast-2"
}


variable "ami_id" {
  description = "The AMI ID for the EC2 instance."
  type        = string
  default     = "ami-0a8f40a451672ea1d"
}

variable "time_zone" {
  description = "The time zone to set for the EC2 instance."
  type        = string
  default     = "Australia/Sydney"
}

variable "s3_url" {
  description = "The URL of the HTML file stored in S3."
  type        = string
  default     = "https://belong-coding-challenge.s3.ap-southeast-2.amazonaws.com/belong-test.html"
}

variable "instance_type" {
  description = "The EC2 instance type to use."
  type        = string
  default     = "t2.micro"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "The CIDR blocks for the public subnets."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "The CIDR blocks for the private subnets."
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "vpc_name" {
  description = "The name of the VPC."
  type        = string
  default     = "my-vpc"
}
