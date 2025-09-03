variable "github_token" {
  description = "GitHub token for API access"
  type        = string
  sensitive   = true
}

variable "repository_name" {
  description = "Name of the GitHub repository"
  type        = string
  default     = "supermavster"
}

variable "environment" {
  description = "Environment name (development, production)"
  type        = string
  default     = "development"
}

variable "region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}