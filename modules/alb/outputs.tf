output "alb_security_group_id" {
  description = "The security group ID for the ALB"
  value       = aws_security_group.alb_sg.id
}

output "dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.this.dns_name  # Make sure "aws_lb.this" matches your ALB resource name in this module
}
