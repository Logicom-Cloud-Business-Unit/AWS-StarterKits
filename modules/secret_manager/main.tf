resource "aws_secretsmanager_secret" "aws_secretsmanager_secret" {
  name = "${var.secret_name}"
  recovery_window_in_days = "${var.recovery_window_in_days}"

  tags = {
    Name                 = "sandbox-${var.infra_env}-${var.secret_name}"
    Application          = "AWS SecretManager"
    Application_Role     = "secrets management service"
    Environment          = var.infra_env
    ManagedBy            = "Terraform"   
    }
}