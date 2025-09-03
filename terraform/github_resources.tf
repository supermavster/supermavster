# Example resource to demonstrate the workflow
# This creates a repository label for the current repository

resource "github_issue_label" "terraform_managed" {
  repository  = split("/", var.repository_name)[1] # Extract repo name from "owner/repo"
  name        = "terraform-managed"
  color       = "0052cc"
  description = "Resources managed by Terraform"
}