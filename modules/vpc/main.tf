resource "aws_vpc" "this_vpc" {
    cidr_block = "${lookup(var.cidr, var.env)}"
    assign_generated_ipv6_cidr_block = false
    tags {
        Name = "wozitech_${var.env}_vpc"
    }
}

resource "aws_subnet" "public_subnets" {
    count = "${var.num_of_avs}"
    availability_zone = "${element(var.av_zones, count.index)}"
    cidr_block = "${lookup(var.subnets, "${var.env}.${element(var.av_zones, count.index)}.public")}"
    map_public_ip_on_launch = true
    vpc_id = "${aws_vpc.this_vpc.id}"
    tags {
        Name = "${var.vpc_name}-public-${element(var.av_zones, count.index)}"
    }
}

resource "aws_subnet" "private_subnets" {
    count = "${var.num_of_avs}"
    availability_zone = "${element(var.av_zones, count.index)}"
    cidr_block = "${lookup(var.subnets, "${var.env}.${element(var.av_zones, count.index)}.private")}"
    map_public_ip_on_launch = false
    vpc_id = "${aws_vpc.this_vpc.id}"
    tags {
        Name = "${var.vpc_name}-private-${element(var.av_zones, count.index)}"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = "${aws_vpc.this_vpc.id}"
    tags = {
        Name = "${var.vpc_name}-igw"
    }   
}

# public routing tables
resource "aws_route_table" "public_routes" {
  vpc_id = "${aws_vpc.this_vpc.id}"
  count = "${var.num_of_avs}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  route {
    ipv6_cidr_block        = "::/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }

  tags {
    Name = "${var.vpc_name}-route-public-${element(var.av_zones, count.index)}"
  }
}

resource "aws_route_table_association" "public_subnet_routes" {
  count = "${var.num_of_avs}"
  subnet_id      = "${element(aws_subnet.public_subnets.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.public_routes.*.id, count.index)}"
}