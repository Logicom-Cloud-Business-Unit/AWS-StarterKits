module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name                        = var.instance_name
  instance_type               = var.instance_type
  key_name                    = var.key_name
  ami                         = var.ami
  associate_public_ip_address = var.associate_public_ip_address
  vpc_security_group_ids      = var.vpc_security_group_ids
  subnet_id                   = var.subnet_id
  monitoring                  = var.monitoring

  # User data script to install and start NGINX
  user_data = var.user_data

  tags = var.tags
}
