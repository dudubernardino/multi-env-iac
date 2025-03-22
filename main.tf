module "vpc" {
  source = "./modules/vpc"

  vpc_name = "${var.vpc_name}-${terraform.workspace}"
  vpc_cidr = var.vpc_cidr

  vpc_azs             = var.vpc_azs
  vpc_private_subnets = var.vpc_private_subnets
  vpc_public_subnets  = var.vpc_public_subnets

  vpc_enable_nat_gateway = var.vpc_enable_nat_gateway
  vpc_enable_vpn_gateway = var.vpc_enable_vpn_gateway

  vpc_tags = {
    Iac  = "true"
    Name = "vpc-${terraform.workspace}"
  }
}

module "elb" {
  source = "./modules/elb"

  elb_name = "${var.elb_name}-${terraform.workspace}"

  vpc_id             = module.vpc.vpc_id
  vpc_public_subnets = module.vpc.vpc_public_subnets

  elb_tags = {
    Iac  = "true"
    Name = "elb-${terraform.workspace}"
  }

  depends_on = [module.vpc]
}

module "ec2" {
  source = "./modules/ec2"

  ec2_name          = "${var.ec2_name}-${terraform.workspace}"
  ec2_ami           = var.ec2_ami
  ec2_instance_type = var.ec2_instance_type

  vpc_id             = module.vpc.vpc_id
  vpc_public_subnets = module.vpc.vpc_public_subnets

  elb_id = module.elb.elb_id

  ec2_tags = {
    Iac  = "true"
    Name = "ec2-${terraform.workspace}"
  }

  depends_on = [module.vpc, module.elb]
}

