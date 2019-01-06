# Servers/main.tf

#Query aws for available and updated amis referenced in the filters for webserver
data "aws_ami" "webservermyami" {
    most_recent = true
    filter {
        name = "owner-alias"    #Set as variable for later
        values = ["amazon"]      #Set as variable for later
    }
    filter {
        name = "name"
        values = ["amzn-ami-hvm*-x86_64-gp2"]   #Set as variable for later
    }
}

#Query aws for available and updated amis referenced in the filters for appserver
data "aws_ami" "appservermyami" {
    most_recent = true
    filter {
        name = "owner-alias"    #Set as variable for later
        values = ["amazon"]      #Set as variable for later
    }
    filter {
        name = "name"
        values = ["amzn-ami-hvm*-x86_64-gp2"]   #Set as variable for later
    }
}

#Template file
data "template_file" "myuserdata" {
    count = "${var.webserver_instance_count}"
    template = "${file("${path.module}/userdata.tpl")}"
}
#Create an ec2-instance
resource "aws_instance" "mywebserver" {
    count = "${var.webserver_instance_count}"
    instance_type = "${var.instance_type}"
    ami = "${data.aws_ami.webservermyami.id}"
    tags {
        Name = "Webserver${count.index + 1}"
    }
    key_name = "${var.keyname}"
    vpc_security_group_ids = ["${var.webserversg}"]
    subnet_id = "${element(var.pubsubnet, count.index)}" #can also be referenced like ${element(var.privatesubnet[count.index])}
    user_data = "${data.template_file.myuserdata.*.rendered[count.index]}"
}

resource "aws_instance" "myappserver" {
    count = "${var.appserver_instance_count}"
    instance_type = "${var.instance_type}"
    ami = "${data.aws_ami.appservermyami.id}"
    tags {
        Name = "Appserver${count.index + 1}"
    }
    key_name = "${var.keyname}"
    vpc_security_group_ids = ["${var.appserversg}"]
    subnet_id = "${element(var.pvtsubnet, count.index)}" #can also be referenced like ${element(var.privatesubnet[count.index])}
}
