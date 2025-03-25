#!/bin/bash

# Set environment variables
export DJANGO_SETTINGS_MODULE=config.settings.azure

# Change to the directory containing manage.py
cd "$(dirname "$0")/backend"

# Run migrations
python manage.py migrate

# Create superuser if not exists
python -c "
import os
from django.contrib.auth.models import User
username = os.environ.get('ADMIN_USERNAME', 'admin')
password = os.environ.get('ADMIN_PASSWORD')
email = os.environ.get('ADMIN_EMAIL', 'admin@example.com')
if not User.objects.filter(username=username).exists() and password:
    User.objects.create_superuser(username, email, password)
    print('Superuser created successfully')
else:
    print('Superuser already exists or no password provided')
"

# Run Gunicorn with increased timeout
gunicorn --bind=0.0.0.0:8000 --timeout=120 config.wsgi_azure:application

# Start Celery worker in background (if needed)
# celery -A config worker --loglevel=info &