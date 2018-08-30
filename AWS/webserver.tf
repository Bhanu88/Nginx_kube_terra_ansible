resource "aws_instance" "Master" {
  ami                    = "${lookup(var.amis, var.region)}"
  availability_zone      = "us-east-1a"
  instance_type          = "t2.medium"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.web.id}"]

  subnet_id                   = "${aws_subnet.public-subnet-in-us-east-1.id}"
  associate_public_ip_address = true
  source_dest_check           = false
  user_data                   = "${file("userdata.sh")}"

  tags {
    Name = "KubeMaster"
  }
}

resource "aws_instance" "Worker" {
  ami                    = "${lookup(var.amis, var.region)}"
  availability_zone      = "us-east-1a"
  instance_type          = "t2.medium"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.web.id}"]

  subnet_id                   = "${aws_subnet.public-subnet-in-us-east-1.id}"
  associate_public_ip_address = true
  source_dest_check           = false
  user_data                   = "${file("userdata.sh")}"

  tags {
    Name = "KubeWorker"
  }
}
