variable "ec2_name" {
  type        = string
  description = "The name of the EC2 instance"
}

variable "ec2_ami" {
  type        = string
  description = "The AMI to use for the EC2 instance"
}

variable "ec2_instance_type" {
  type        = string
  description = "The type of EC2 instance to launch"
}

variable "ec2_tags" {
  type        = map(string)
  default     = {}
  description = "Tags for the EC2 distribution"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID to launch the EC2 instance in"
}

variable "vpc_public_subnets" {
  type        = list(string)
  description = "The security group IDs to attach to the EC2 instance"
}

variable "elb_id" {
  type        = string
  description = "The ID of the ELB to attach the EC2 instance to"
}
