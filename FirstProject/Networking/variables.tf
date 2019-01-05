# Networking/variables.tf
variable "vpc_cidr" {
    default = "18.0.0.0/16"
}

variable "pubsubnet_cidr" {
    default = ["18.0.0.0/24", "18.0.1.0/24"]
}

variable "pvtsubnet_cidr" {
    default = ["18.0.2.0/24", "18.0.3.0/24"]
}

variable "sshpubsubaccessip" {
    default = "0.0.0.0/0"
}

variable "httppubsubaccessip" {
    default = "0.0.0.0/0"
}
