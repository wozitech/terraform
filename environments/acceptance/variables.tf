variable "region" {
  default = "eu-west-2"
  description = "The AWS region"
  type = "string"
}

variable "env" {
    default = "acceptance"
}

# TODO: make subnets a list/map (dictionary)
# https://www.terraform.io/intro/getting-started/variables.html
variable "subnet-2a" {
    description = "The first subnet into which to launch an instance"
    default = "subnet-b5d070ce"         # eu-west-2a
}
variable "subnet-2b" {
    description = "The second subnet into which to launch an instance"
    default = "subnet-1090685d"         # eu-west-2b
}
variable "subnet-2c" {
    description = "The third subnet into which to launch an instance"
    default = "subnet-17925d7e"         # eu-west-2c
}