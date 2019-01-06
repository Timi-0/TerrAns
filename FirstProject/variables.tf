variable "aws_region" {}
variable "secret_key" {}
variable "access_key" {}
# Networking Variables
variable "vpc_cidr" {}
variable "pubsubnet_cidr" {
    type = "list"
}
variable "pvtsubnet_cidr" {
    type = "list"
}
variable "sshpubsubaccessip" {}
variable "httppubsubaccessip" {}

# Servers Variables
variable "webserver_instance_count" {}

variable "appserver_instance_count" {}

variable "instance_type" {}

variable "keyname" {}

variable "webserversg" {}

variable "appserversg" {}

variable "pvtsubnet" {
    type = "list"
}
variable "pubsubnet" {
    type = "list"
}
