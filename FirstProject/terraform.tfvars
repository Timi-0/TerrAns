#AWS Variables
aws_region = "us-east-1"
access_key = "##############"
secret_key = "##############"

#Networking Variables
vpc_cidr = "18.0.0.0/16"
pubsubnet_cidr = [
    "18.0.0.0/24",
    "18.0.1.0/24"
    ]
pvtsubnet_cidr = [
    "18.0.2.0/24",
    "18.0.3.0/24"
    ]
sshpubsubaccessip = "0.0.0.0/0"
httppubsubaccessip = "0.0.0.0/0"

#Servers Variables
webserver_instance_count = 1
appserver_instance_count = 1
instance_type = t2.micro
keyname = NewStart