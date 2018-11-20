provider "aws" {
  # access_key = "ACCESS_KEY_HERE"
  # secret_key = "SECRET_KEY_HERE"
  region     = "${var.region}"
  profile    = "acceptance-terraform"
}

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

resource "aws_instance" "accept-web-1" {
  ami           = "${data.aws_ami.amzn.id}"
  instance_type = "t2.micro"
  source_dest_check = true
  count = 1
  subnet_id = "${var.subnet-2b}"
  iam_instance_profile = "ec2-full-access"
  tenancy = "shared"
  key_name = "wozitech-1"
}
