output "secret_manager_id" {
  description = "AWS SecretManager Secret ID  service"
  value       = aws_secretsmanager_secret.aws_secretsmanager_secret.id
}

output "secret_manager_arn" {
  description = "AWS SecretManager Secret ID  service"
  value       = aws_secretsmanager_secret.aws_secretsmanager_secret.arn
}

output "secret_manager_name" {
  description = "AWS SecretManager Secret ID  service"
  value       = aws_secretsmanager_secret.aws_secretsmanager_secret.name
}