provider "aws" {
  # access_key = "ACCESS_KEY_HERE"
  # secret_key = "SECRET_KEY_HERE"
  region     = "${var.region}"
  profile    = "acceptance-terraform"
}

# to use an existing role (unmanged by terraform) use data not resource
data "aws_iam_role" "EC2-full-access" {
  name = "EC2-full-access"
}

# resource "aws_iam_instance_profile" "ec2_alt_profile" {
#   name = "${var.env}_ec2_alt_profile"
#   role = "${data.aws_iam_role.EC2-full-access.name}"
# }

data "aws_ami" "amzn" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-hvm*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_security_group" "ssh-only" {
  id = "sg-0813895852f33cc81"
}

# resource "aws_instance" "accept-web-1" {
#   ami           = "${data.aws_ami.amzn.id}"
#   instance_type = "t2.micro"
#   source_dest_check = true
#   count = 1
#   subnet_id = "${var.subnet-2b}"
#   iam_instance_profile = "${aws_iam_instance_profile.ec2_alt_profile.name}"
#   vpc_security_group_ids = [
#     "${data.aws_security_group.ssh-only.id}"
#   ]
#   #tenancy = "shared"
#   key_name = "wozitech-1"
#   tags {
#     Name = "accept-web-1"
#   }
  
#   connection {
#     user = "ec2-user"
#     private_key = "${file("${path.module}/priv.key")}"
#   }
#   provisioner "remote-exec" {
#     inline = [
#       "sudo yum -y update",
#       "sudo yum -y install nginx",
#       "sudo service nginx start"
#     ]
#   }
# }

module "my-vpc" {
  source = "../../modules/vpc"
  vpc_name = "wozitech_${var.env}"
  env = "${var.env}"
  num_of_avs = 2
  private_key_location = "${file("${path.module}/priv.key")}"
}