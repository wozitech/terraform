variable "env" {
}
variable "vpc_name" {
}

variable "num_of_avs" {
    description = "The number of AVs to create"
    default = 1
}

variable "cidr" {
    type = "map"
    default = {
        dev             = "192.168.0.0/24"
        test            = "192.168.100.0/24"
        acceptance      = "172.16.0.0/16"
        production      = "10.0.0.0/16"
    }
}
variable "subnets" {
    type = "map"
    default = {
        dev.eu-west-2a.public           = "192.168.0.0/27"
        dev.eu-west-2a.private          = "192.168.0.32/27"
        dev.eu-west-2b.public           = "192.168.0.64/27"
        dev.eu-west-2b.private          = "192.168.0.96/27"
        dev.eu-west-2c.public           = "192.168.0.128/27"
        dev.eu-west-2c.private          = "192.168.0.160/27"
        test.eu-west-2a.public          = "192.168.100.0/27"
        test.eu-west-2a.private         = "192.168.100.32/27"
        test.eu-west-2b.public          = "192.168.100.64/27"
        test.eu-west-2b.private         = "192.168.100.96/27"
        test.eu-west-2c.public          = "192.168.100.128/27"
        test.eu-west-2c.private         = "192.168.100.160/27"
        acceptance.eu-west-2a.public    = "172.16.0.0/24"
        acceptance.eu-west-2a.private   = "172.16.1.0/24"
        acceptance.eu-west-2b.public    = "172.16.10.0/24"
        acceptance.eu-west-2b.private   = "172.16.11.0/24"
        acceptance.eu-west-2c.public    = "172.16.20.0/24"
        acceptance.eu-west-2c.private   = "172.16.21.0/24"
        production.eu-west-2a.public    = "10.0.0.0/24"
        production.eu-west-2a.private   = "10.0.1.0/24"
        production.eu-west-2b.public    = "10.0.100.0/24"
        production.eu-west-2b.private   = "10.0.110.0/24"
        production.eu-west-2c.public    = "10.0.200.0/24"
        production.eu-west-2c.private   = "10.0.210.0/24"
    }
}
variable "av_zones" {
    type = "list"
    default = [
        "eu-west-2a",
        "eu-west-2b",
        "eu-west-2c"
    ]
}
