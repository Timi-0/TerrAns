# Servers/variables.tf
variable "webserver_instance_count" {
    default = 1
}

variable "appserver_instance_count" {
    default = 1
}

variable "instance_type" {
    default = t2.micro
}

variable "keyname" {
    default = "NewStart"
}

variable "webserversg" {}

variable "appserversg" {}

variable "pvtsubnet" {
    type = "list"
}
variable "pubsubnet" {
    type = "list"
}