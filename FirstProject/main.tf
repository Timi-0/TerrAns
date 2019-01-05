provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region = "${var.aws_region}"
}

module "Storage" {
  source = "./Storage"
  vpc_cidr_block = "${var.vpc_cidr_block}"
  vpc_name = "${var.vpc_name}"}
}
