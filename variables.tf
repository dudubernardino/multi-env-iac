###############################
####### Project Config ########
###############################

variable "profile" {
  type        = string
  description = "AWS profile"
}

variable "region" {
  type        = string
  description = "AWS region"
}

variable "tfstate_bucket" {
  type        = string
  default     = "emb-tfstate-bucket"
  description = "The name of the S3 bucket to store Terraform state"
}

####################
####### VPC ########
####################

variable "vpc_name" {
  type        = string
  description = "The name of the VPC"
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC"
}

variable "vpc_azs" {
  type        = list(string)
  description = "The availability zones for the VPC"
}

variable "vpc_private_subnets" {
  type        = list(string)
  description = "The private subnets for the VPC"
}

variable "vpc_public_subnets" {
  type        = list(string)
  description = "The public subnets for the VPC"
}

variable "vpc_enable_nat_gateway" {
  type        = bool
  description = "Enable NAT Gateway for the VPC"
}

variable "vpc_enable_vpn_gateway" {
  type        = bool
  description = "Enable VPN Gateway for the VPC"
}

####################
####### elb ########
####################

variable "elb_name" {
  type        = string
  description = "The name of the ELB"
}

####################
####### EC2 ########
####################

variable "ec2_name" {
  type        = string
  description = "The AMI to use for the EC2 instance"
}

variable "ec2_ami" {
  type        = string
  description = "The AMI to use for the EC2 instance"
}

variable "ec2_instance_type" {
  type        = string
  description = "The type of EC2 instance to launch"
}
