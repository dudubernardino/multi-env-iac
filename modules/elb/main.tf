resource "aws_security_group" "elb_sg" {
  name        = "${var.elb_name}-sg"
  description = "Allow inbound traffic on port 80 and 443"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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

module "elb" {
  source = "terraform-aws-modules/elb/aws"

  name = "${var.elb_name}-${terraform.workspace}"

  subnets         = var.vpc_public_subnets
  security_groups = [aws_security_group.elb_sg.id]
  internal        = false

  listener = [
    {
      instance_port     = 80
      instance_protocol = "HTTP"
      lb_port           = 80
      lb_protocol       = "HTTP"
    },
  ]

  health_check = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  tags = var.elb_tags

  depends_on = [aws_security_group.elb_sg]
}


