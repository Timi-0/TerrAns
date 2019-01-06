# Servers/variables.tf
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