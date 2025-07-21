output "password" {
  value = random_string.uddin-db-password.result
}
output "username" {
  value = var.username
}
output "rds_security_group_id" {
  value       = aws_security_group.rds_postgres_sg.id
  description = "The ID of the RDS security group"
}
