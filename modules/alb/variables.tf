variable "public_subnet_ids" {
  description = "List of public subnet IDs for the ALB"
  type        = list(string)
}

variable "vpc_id" {
  description = "The ID of the VPC where the ALB is deployed"
  type        = string
}



variable "target_instance_id" {
  description = "The target EC2 instance ID for the ALB"
  type        = string
}
