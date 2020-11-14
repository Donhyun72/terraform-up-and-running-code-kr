provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_launch_configuration" "example" {
  image_id        = "ami-0c20b8b385217763f"
  instance_type   = "t2.micro"
  # security_groups = ["${aws_security_group.instance.id}"]
  security_groups = [aws_security_group.instance.id]
  # user_data       = "${data.template_file.user_data.rendered}"
  user_data       = data.template_file.user_data.rendered

  lifecycle {
    create_before_destroy = true
  }
}

data "template_file" "user_data" {
  # template = "${file("user-data.sh")}"
  template = file("user-data.sh")

  # vars {
  vars = {
    # server_port = "${var.server_port}"
    server_port = var.server_port
    # db_address  = "${data.terraform_remote_state.db.address}"
    # db_address  = data.terraform_remote_state.db.address
    db_address  = data.terraform_remote_state.db
    # db_port     = "${data.terraform_remote_state.db.port}"
    # db_port     = data.terraform_remote_state.db.port
    db_port     = data.terraform_remote_state.db
  }
}

resource "aws_autoscaling_group" "example" {
  # launch_configuration = "${aws_launch_configuration.example.id}"
  launch_configuration = aws_launch_configuration.example.id
  # availability_zones   = ["${data.aws_availability_zones.all.names}"]
  availability_zones   = data.aws_availability_zones.all.names

  #@ load_balancers    = ["${aws_elb.example.name}"]
  load_balancers    = [aws_elb.example.name]
  health_check_type = "ELB"

  min_size = 2
  max_size = 10

  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    # from_port   = "${var.server_port}"
    from_port   = var.server_port
    # to_port     = "${var.server_port}"
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_availability_zones" "all" {}

resource "aws_elb" "example" {
  name               = "terraform-asg-example"
  # availability_zones = ["${data.aws_availability_zones.all.names}"]
  availability_zones = data.aws_availability_zones.all.names
  # security_groups    = ["${aws_security_group.elb.id}"]
  security_groups    = [aws_security_group.elb.id]

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    # instance_port     = "${var.server_port}"
    instance_port     = var.server_port
    instance_protocol = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:${var.server_port}/"
  }
}

resource "aws_security_group" "elb" {
  name = "terraform-example-elb"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "terraform_remote_state" "db" {
  backend = "s3"

  # config {
  config = {
    # bucket = "${var.db_remote_state_bucket}"
    bucket = var.db_remote_state_bucket
    # key    = "${var.db_remote_state_key}"
    key    = var.db_remote_state_key
    region = "ap-southeast-1"
  }
}
