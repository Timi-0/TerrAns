variable "aws_region" {}
variable "secret_key" {}
variable "access_key" {}
variable "vpc_cidr" {}
variable "pubsubnet_cidr" {
    type = "list"
}
variable "pvtsubnet_cidr" {
    type = "list"
}
variable "sshpubsubaccessip" {}
variable "httppubsubaccessip" {}