# Networking/outputs.tf

output "public_subnets" {
    value = "${aws_subnet.mypublicsubnet.*.id}"
	}

output "private_subnets" {
    value = "${aws_subnet.myprivatesubnet.*.id}"
	}
	
output "webserversecuritygroup" {
    value = "${aws_security_group.mywebserversg.id}"
	}

output "appserversecuritygroup" {
    value = "${aws_security_group.myappserversg.id}"
	}