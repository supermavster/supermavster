output "repository_info" {
  description = "Repository information"
  value = {
    name        = var.repository_name
    environment = var.environment
    region      = var.region
  }
}

output "terraform_version" {
  description = "Terraform version used"
  value       = "1.5.0"
}