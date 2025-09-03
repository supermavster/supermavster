#!/bin/bash

# Local Terraform Testing Script
# This script simulates the GitHub Actions workflow locally for testing

set -e

echo "🧪 Testing Terraform GitHub Actions Workflow Locally"
echo "=================================================="

# Check if we're in the right directory
if [ ! -f ".env.template" ]; then
    echo "❌ Error: .env.template not found. Run this script from the repository root."
    exit 1
fi

# Simulate environment file generation
echo "🔧 Step 1: Generating .env.local from template..."
cp .env.template .env.local

# You need to set your GitHub token for local testing
if [ -z "$GITHUB_TOKEN" ]; then
    echo "⚠️  Warning: GITHUB_TOKEN not set. Using placeholder for testing."
    GITHUB_TOKEN="your_test_token_here"
fi

# Replace placeholders
sed -i "s/your_github_token_here/$GITHUB_TOKEN/g" .env.local
sed -i "s/\${GITHUB_TOKEN}/$GITHUB_TOKEN/g" .env.local

echo "✅ Generated .env.local file"

# Navigate to terraform directory
cd terraform

echo ""
echo "🔧 Step 2: Terraform Format Check..."
terraform fmt -check -recursive || {
    echo "⚠️  Formatting issues found. Running terraform fmt to fix..."
    terraform fmt -recursive
    echo "✅ Formatting fixed"
}

echo ""
echo "🔧 Step 3: Terraform Init..."
terraform init

echo ""
echo "🔧 Step 4: Terraform Validate..."
terraform validate

echo ""
echo "🔧 Step 5: Terraform Plan..."
terraform plan \
    -var="github_token=$GITHUB_TOKEN" \
    -var="repository_name=supermavster/supermavster" \
    -var="environment=development" \
    -out=tfplan

echo ""
echo "🧹 Cleanup..."
cd ..
rm -f .env.local
rm -f terraform/tfplan

echo ""
echo "✅ Local testing completed successfully!"
echo "💡 The workflow should work correctly in GitHub Actions."