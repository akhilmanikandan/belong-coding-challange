

module "vpc" {
  source          = "./modules/vpc"
  cidr_block      = var.vpc_cidr_block
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  vpc_name        = var.vpc_name
}

module "ec2" {
  source               = "./modules/ec2"
  private_subnet_id    = module.vpc.private_subnet_ids[0]
  instance_type        = var.instance_type
  ami_id               = var.ami_id
  vpc_id               = module.vpc.vpc_id
  alb_security_group_id = module.alb.security_group_id
  s3_url               = var.s3_url
  time_zone            = var.time_zone
}

module "alb" {
  source              = "./modules/alb"
  public_subnet_ids   = module.vpc.public_subnet_ids
  vpc_id              = module.vpc.vpc_id
  target_instance_id  = module.ec2.instance_id
}
