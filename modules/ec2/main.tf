resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "Allow HTTP traffic from ALB"
  vpc_id      = var.vpc_id

  ingress {
    description    = "Allow HTTP traffic from ALB"
    from_port      = 80
    to_port        = 80
    protocol       = "tcp"
    security_groups = [var.alb_security_group_id] # Reference ALB SG
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami           = var.ami_id # Amazon Linux 2
  instance_type = var.instance_type
  subnet_id     = var.private_subnet_id
  security_groups   = [aws_security_group.ec2_sg.id] # Attach SG
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name
  user_data = <<-EOF
              #!/bin/bash

              # Set the time zone
              ln -sf /usr/share/zoneinfo/${var.time_zone} /etc/localtime
              echo "ZONE=${var.time_zone}" > /etc/sysconfig/clock
              echo "ZONE=${var.time_zone}" >> /etc/environment

              yum update -y
              yum install -y httpd aws-cli
              systemctl start httpd
              systemctl enable httpd
              curl -o /var/www/html/index.html ${var.s3_url}
              
  EOF

  tags = {
    Name = "httpd-server"
  }
}

resource "aws_iam_instance_profile" "ssm_profile" {
  name = "ec2-ssm-profile"
  role = aws_iam_role.ssm_role.name
}

resource "aws_iam_role" "ssm_role" {
  name               = "ec2-ssm-role"
  assume_role_policy = <<-EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Action": "sts:AssumeRole",
          "Principal": { "Service": "ec2.amazonaws.com" },
          "Effect": "Allow"
        }
      ]
    }
  EOF
}

resource "aws_iam_role_policy_attachment" "ssm_policy" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

