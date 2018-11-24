# WOZiTech VPC module
Create a reference WOZiTech VPC, having a public and a private subnet, with a bastion server deployed into the public subnet with allow all SSH to it.

# Inputs
* `vpc_name` - the name of the VPC; defauls to wozitech_[env]
* `env` - the name of the environment, which is used to identify VPC CIDR block range, availability zones and subnets.
* `number_of_avs` - whether to create 1, 2 or 3 Availability Zones

# Limitations/TODO
* Assumes region is eu-west-2
* NAT Gateway - to allow outbound internet from private subnets
* Network ACL - to restrict traffic to/from given source (CIDR range)
* AWS Secret Manager - for creating user accounts on the bastion.
