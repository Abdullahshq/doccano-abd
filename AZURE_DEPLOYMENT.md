# Deploying Doccano to Azure Web App

This guide will help you deploy Doccano to Azure Web App with a PostgreSQL database using GitHub Actions.

## Prerequisites

1. An Azure account with an active subscription
2. A GitHub account
3. The Doccano codebase in your GitHub repository

## Step 1: Create Azure Resources

### Create an Azure PostgreSQL Database

1. Sign in to the [Azure Portal](https://portal.azure.com)
2. Create a new Azure Database for PostgreSQL server (Flexible server recommended)
3. Take note of the server name, admin username, password, and database name

### Create an Azure Web App

1. In the Azure Portal, create a new Web App
2. Select a name for your app (this will be part of the URL)
3. For Publish, select "Code"
4. For Runtime stack, select "Python 3.10" or later
5. Select an appropriate region and plan (at least Basic plan recommended)
6. Create the Web App

## Step 2: Configure GitHub Secrets

In your GitHub repository, go to Settings > Secrets and add the following secrets:

1. `AZURE_WEBAPP_NAME`: The name of your Azure Web App
2. `AZURE_WEBAPP_PUBLISH_PROFILE`: Download this from the Web App Overview > Get publish profile, and paste the entire XML content
3. `DATABASE_URL`: Connection string in the format `postgres://username:password@server-name.postgres.database.azure.com:5432/database-name`
4. `SECRET_KEY`: A random secret key for Django
5. `ADMIN_USERNAME`: Admin username for Doccano (optional)
6. `ADMIN_PASSWORD`: Admin password for Doccano (optional)
7. `ADMIN_EMAIL`: Admin email for Doccano (optional)

## Step 3: Configure Azure Web App Settings

In the Azure Portal, go to your Web App > Configuration > Application settings and add:

1. `SCM_DO_BUILD_DURING_DEPLOYMENT`: Set to `true`
2. `WEBSITE_WEBDEPLOY_USE_SCM`: Set to `false`
3. `DJANGO_SETTINGS_MODULE`: Set to `config.settings.azure`
4. `DATABASE_URL`: Your PostgreSQL connection string
5. `SECRET_KEY`: Your Django secret key
6. `ADMIN_USERNAME`: Admin username (same as in GitHub secrets)
7. `ADMIN_PASSWORD`: Admin password (same as in GitHub secrets)
8. `ADMIN_EMAIL`: Admin email (same as in GitHub secrets)

## Step 4: Deploy with GitHub Actions

1. Push your changes to the main branch
2. GitHub Actions will automatically deploy to Azure Web App
3. You can also manually trigger deployment from the Actions tab

## Step 5: Access Your Application

Once deployed, you can access your application at `https://your-app-name.azurewebsites.net`

## Troubleshooting

If you encounter issues:

1. Check the GitHub Actions logs for errors
2. Check the Azure Web App logs under "App Service logs" or use "Log stream"
3. If needed, you can SSH into the Web App instance using the Azure Portal's Console feature

## Maintenance

To update your application:

1. Push changes to your main branch
2. GitHub Actions will automatically deploy the updates

## Additional Configuration

For advanced configuration and customization:

1. Modify `backend/config/settings/azure.py` for Azure-specific settings
2. Update `.github/workflows/azure-deploy.yml` for customizing the deployment process 