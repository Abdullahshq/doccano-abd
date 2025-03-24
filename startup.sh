#!/bin/bash

# Navigate to backend directory
cd backend

# Set environment variables
export DJANGO_SETTINGS_MODULE=config.settings.azure

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

# Run Gunicorn
gunicorn --bind=0.0.0.0:8000 config.wsgi:application

# Start Celery worker in background (if needed)
# celery -A config worker --loglevel=info & 