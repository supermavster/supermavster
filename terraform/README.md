# Terraform GitHub Actions Workflow

This repository includes a complete GitHub Actions workflow for managing infrastructure with Terraform, with automatic environment file generation and proper token handling.

## Features

- ✅ **Automatic Environment File Generation**: Creates `.env.local` from `.env.template` using GitHub's built-in token
- ✅ **Secure Token Handling**: Uses `GITHUB_TOKEN` secret with proper cleanup
- ✅ **Terraform Best Practices**: Includes formatting, validation, planning, and conditional apply
- ✅ **Pull Request Integration**: Automatically comments on PRs with Terraform plan results
- ✅ **Security First**: Sensitive files are excluded from git and cleaned up after use

## How It Works

### 1. Environment File Generation
Before running Terraform commands, the workflow:
1. Copies `.env.template` to `.env.local`
2. Replaces `your_github_token_here` with the actual `GITHUB_TOKEN`
3. Replaces `${GITHUB_TOKEN}` references with the token value

### 2. Terraform Operations
The workflow then:
1. Installs Terraform CLI (v1.5.0)
2. Runs `terraform fmt -check` for formatting validation
3. Initializes Terraform with `terraform init`
4. Validates configuration with `terraform validate`
5. Generates a plan with `terraform plan`
6. Comments the plan on pull requests
7. Applies changes automatically on main branch pushes

### 3. Cleanup
After completion:
- Removes `.env.local` file
- Removes `tfplan` file
- Ensures no sensitive data remains

## Workflow Triggers

The workflow runs on:
- **Push** to `main` or `develop` branches (when Terraform files change)
- **Pull Request** to `main` branch (when Terraform files change)
- **Manual trigger** via workflow_dispatch

## File Structure

```
.
├── .env.template              # Environment variables template
├── .github/workflows/
│   └── terraform.yml          # GitHub Actions workflow
├── .gitignore                 # Excludes sensitive files
└── terraform/
    ├── main.tf               # Provider configuration
    ├── variables.tf          # Variable definitions
    ├── outputs.tf            # Output definitions
    └── github_resources.tf   # Example GitHub resources
```

## Environment Variables

The `.env.template` file includes:

- `GITHUB_TOKEN`: GitHub API token (auto-populated)
- `TF_VAR_github_token`: Terraform variable for GitHub provider
- `TF_VAR_repository_name`: Repository name
- `TF_VAR_environment`: Environment (development/production)
- `TF_VAR_region`: AWS region (if needed)

## Security Notes

- `.env.local` is automatically excluded from git via `.gitignore`
- All Terraform state files and plans are excluded from git
- Sensitive files are cleaned up after workflow completion
- The workflow uses minimal required permissions

## Customization

To customize for your infrastructure:

1. **Add your Terraform code** to the `terraform/` directory
2. **Update variables** in `.env.template` as needed
3. **Modify the workflow** if you need different Terraform commands
4. **Add secrets** to your repository if you need additional tokens/keys

## Troubleshooting

If the workflow fails:

1. **Check `.env.template` exists**: The workflow expects this file in the repository root
2. **Verify Terraform syntax**: Run `terraform fmt` and `terraform validate` locally
3. **Check permissions**: Ensure the workflow has necessary permissions for your resources
4. **Review logs**: Check the GitHub Actions logs for specific error messages

## Example Usage

After setting up this workflow, any changes to Terraform files will:

1. Automatically trigger the workflow
2. Generate a plan showing proposed changes
3. Comment the plan on pull requests for review
4. Apply changes when merged to main branch

This ensures infrastructure changes are reviewed and applied consistently with proper CI/CD practices.