variable "elb_name" {
  type        = string
  description = "The name of the Application Load Balancer"
}

variable "elb_tags" {
  type        = map(string)
  default     = {}
  description = "Tags for the ELB distribution"
}

variable "vpc_id" {
  type        = string
  description = "The VPC ID"
}

variable "vpc_public_subnets" {
  type        = list(string)
  description = "The security group IDs to attach to the ELB instance"
}
