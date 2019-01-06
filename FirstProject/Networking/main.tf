# Networking.main.tf

# Let terraform query for the availability zones
data "aws_availability_zones" "myavailabilityzones" {}

# Create the vpc
resource "aws_vpc" "myvpc" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    enable_dns_support = true
    tags {
        Name = "testingvpc"
    }
}

# Create the Internet Gateway
resource "aws_internet_gateway" "myigw" {
    vpc_id = "${aws_vpc.myvpc.id}"
    tags {
        Name = "testingIGW"   # Set as variable later
    }
}

# Create Public Route Table
resource "aws_route_table" "mypublicrt" {
    vpc_id = "${aws_vpc.myvpc.id}"
    route {
        cidr_block = "0.0.0.0/0"  # Set as cidr block variable later
        gateway_id = "${aws_internet_gateway.myigw.id}"
    }
    tags {
        Name = "testingPublicRT" # Set as varibale later
    }
}

# Create Private Route Table
resource "aws_route_table" "myprivatert" {
    vpc_id = "${aws_vpc.myvpc.id}"
    tags {
        Name = "testingPrivateRT"  # Set as variable later
    }
}

# Create Public Subnet(s)
resource "aws_subnet" "mypublicsubnet" {
    count = 2
    vpc_id = "${aws_vpc.myvpc.id}"
    cidr_block = "${var.pubsubnet_cidr[count.index]}"
    map_public_ip_on_launch = true
    availability_zone = "${data.aws_availability_zones.myavailabilityzones.names[count.index]}"
    tags {
        Name = "PubSubnet${count.index + 1}"
    }
}

# Create Private Subnet(s)
resource "aws_subnet" "myprivatesubnet" {
    count = 2
    vpc_id = "${aws_vpc.myvpc.id}"
    cidr_block = "${var.pvtsubnet_cidr[count.index]}"
    map_public_ip_on_launch = false
    availability_zone = "${data.aws_availability_zones.myavailabilityzones.names[count.index]}"
    tags {
        Name = "PvtSubnet${count.index + 1}"
    }
}

# Associate Public subnets to the public route table
resource "aws_route_table_association" "mypubsubassociation" {
    count = "${aws_subnet.mypublicsubnet.count}"
    subnet_id = "${aws_subnet.mypublicsubnet.*.id[count.index]}"
    route_table_id = "${aws_route_table.mypublicrt.id}"
}

# Associate Private subnets to the private route table
resource "aws_route_table_association" "myprivatert" {
    count = "${aws_subnet.myprivatesubnet.count}"
    subnet_id = "${aws_subnet.myprivatesubnet.*.id[count.index]}"
    route_table_id = "${aws_route_table.myprivatert.id}"
}

# Create the Public Security Group
resource "aws_security_group" "mywebserversg" {
    name = "mywebserversg"
    description = "Grants ports access to the webserver"
    vpc_id = "${aws_vpc.myvpc.id}"

    # SSH port rule
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.sshpubsubaccessip}"]
    }

    # HTTP port rule
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["${var.httppubsubaccessip}"]
    }

    #Create the egress rule
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

}

# Create the Public Security Group for appserver
resource "aws_security_group" "myappserversg" {
    name = "myappserversg"
    description = "Grants ports access to the appserver"
    vpc_id = "${aws_vpc.myvpc.id}"

    # SSH port rule
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.sshpubsubaccessip}"]
    }

    # HTTP port rule
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["${var.httppubsubaccessip}"]
    }

    #Create the egress rule
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

}
