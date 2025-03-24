#!/bin/bash

# Script to clean unnecessary files for Azure Web App deployment

# Remove Docker-related files as Azure Web App doesn't need them
rm -rf docker
rm .dockerignore
rm heroku.yml

# Remove cloud deployment scripts for other platforms
rm -rf cloud

# Keep only necessary GitHub workflows
mkdir -p .github/workflows_backup
mv .github/workflows/azure-deploy.yml .github/workflows_backup/
rm -rf .github/workflows
mkdir -p .github/workflows
mv .github/workflows_backup/azure-deploy.yml .github/workflows/
rm -rf .github/workflows_backup

# Make scripts executable
chmod +x startup.sh
chmod +x .azure_deployment_clean.sh

echo "Cleaned unnecessary files for Azure Web App deployment" 