#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#
# Your subnet ID is:
#
#
# Your security group ID is:
#
#
# Your Identity is:
#
#     training-jb-worm
#

variable "aws_access_key" {
  type    = "string"
}

variable "aws_secret_key" {
  type    = "string"
}

variable "counter" {
  type    = "string"
  default = "1"
}

#module "example" {
#
#	source = "./example-module"
#}

provider "aws" {
  access_key = "${var.aws_access_key}"

  secret_key = "${var.aws_secret_key}"
  region     = "us-west-2"
}

resource "aws_instance" "web" {
 # ami           = "ami-1a14807a"
  instance_type = "t2.micro"
  subnet_id     = "subnet-179e1f5e"
  count         = "${var.counter}"

  vpc_security_group_ids = ["sg-6313eb18"]

  tags {
    Identity  = "training-jb-worm"
    Identity2 = "training-jb-snake"
    Identity3 = "training-jb-snail"
  }

  tags {
    Name = "${format("web-%03d", count.index + 1)}"
  }
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}
