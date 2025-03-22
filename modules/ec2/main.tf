resource "aws_security_group" "ec2_sg" {
  name        = "${var.ec2_name}-sg"
  description = "Allow inbound traffic on port 22 and 80"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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

module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = var.ec2_name

  ami           = var.ec2_ami
  instance_type = var.ec2_instance_type
  monitoring    = true

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  subnet_id              = var.vpc_public_subnets[0]

  tags = var.ec2_tags

  depends_on = [aws_security_group.ec2_sg]
}

resource "aws_elb_attachment" "ec2_attach" {
  elb      = var.elb_id
  instance = module.ec2_instance.id
}
