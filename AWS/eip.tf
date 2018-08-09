resource "aws_eip" "Master" {
  instance = "${aws_instance.Master.id}"
  vpc      = true
}

resource "aws_eip" "Worker" {
  instance = "${aws_instance.Worker.id}"
  vpc      = true
}
