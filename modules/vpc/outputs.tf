output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the VPC"
}

output "vpc_public_subnets" {
  value       = module.vpc.public_subnets
  description = "The public subnets of the VPC"
}
