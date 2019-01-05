# Networking/variables.tf
variable "vpc_cidr" {}

variable "pubsubnet_cidr" {
    type = "list"
}

variable "pvtsubnet_cidr" {
    type = "list"
}

variable "sshpubsubaccessip" {}

variable "httppubsubaccessip" {}
