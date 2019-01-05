provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.aws_region}"
}

# Deploy Networking Resources

module "Networking" {
  source = "./Networking"
  vpc_cidr = "${var.vpc_cidr}"
  pubsubnet_cidr = "${var.pubsubnet_cidr}"
  pvtsubnet_cidr = "${var.pvtsubnet_cidr}"
  sshpubsubaccessip = "${var.sshpubsubaccessip}"
  httppubsubaccessip = "${var.httppubsubaccessip}"
}