# Aws Credentials

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

# Deploy Servers Resources

module "Servers" {
  source = "./Servers"
  webserver_instance_count = "${var.webserver_instance_count}"
  appserver_instance_count = "${var.appserver_instance_count}"
  instance_type = "${var.instance_type}"
  keyname = "${var.keyname}"
  webserversg = "${module.networking.webserversecuritygroup}"
  appserversg = "${module.networking.appserversecuritygroup}"
  pvtsubnet = "${module.networking.public_subnets}"
  pubsubnet = "${module.networking.private_subnets}"
}