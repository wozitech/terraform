# WOZiTech VPC module
Create a new VPC, having a public and a private subnet (each /24).

# Inputs
* `vpc_name` - the name of the VPC; defauls to wozitech_[env]
* `cpv_cidr` - the address range of this VPC; defaults to 10.0.0.0/16 for env=production, 172.16.0.0/16 for acceptance, 192.168.100.0/24 for test and 192.168.0.1/24 for dev
* `av_zones` - a list of the AV zones to create a public; defaults to the three eu-west-2 AVs
# 