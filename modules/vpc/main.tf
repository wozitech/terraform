resource "aws_vpc" "this_vpc" {
    cidr_block = "${lookup(var.cidr, var.env)}"
    assign_generated_ipv6_cidr_block = false
    tags {
        Name = "wozitech_${var.env}_vpc"
    }
}

resource "aws_subnet" "public_subnets" {
    count = 3
    availability_zone = "${element(var.av_zones, count.index)}"
    cidr_block = "${lookup(var.subnets, "${var.env}.${element(var.av_zones, count.index)}.public")}"
    map_public_ip_on_launch = true
    vpc_id = "${aws_vpc.this_vpc.id}"
    tags {
        Name = "wozitech-public-${element(var.av_zones, count.index)}"
    }
}

resource "aws_subnet" "private_subnets" {
    count = 3
    availability_zone = "${element(var.av_zones, count.index)}"
    cidr_block = "${lookup(var.subnets, "${var.env}.${element(var.av_zones, count.index)}.private")}"
    map_public_ip_on_launch = false
    vpc_id = "${aws_vpc.this_vpc.id}"
    tags {
        Name = "wozitech-private-${element(var.av_zones, count.index)}"
    }
}