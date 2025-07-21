resource "aws_security_group" "this" {
  name        = var.security_group_name
  description = "Allow traffic from ALB to EC2 instances"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_security_group_rule" "allow_http_from_alb" {
  count                    = var.allow_http ? 1 : 0
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.this.id
  source_security_group_id = var.alb_security_group_id
  description              = "Allow HTTP traffic from ALB"
}

resource "aws_security_group_rule" "allow_https_from_alb" {
  count                    = var.allow_https ? 1 : 0
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.this.id
  source_security_group_id = var.alb_security_group_id
  description              = "Allow HTTPS traffic from ALB"
}

# Conditional SSH ingress rule
resource "aws_security_group_rule" "allow_ssh" {
  count             = var.allow_ssh ? 1 : 0
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.ssh_cidr_block]
  security_group_id = aws_security_group.this.id
  description       = "Allow SSH access"
}
