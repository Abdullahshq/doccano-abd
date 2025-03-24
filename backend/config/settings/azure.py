import os

from .production import *  # noqa: F403

# Azure-specific settings
ALLOWED_HOSTS = [os.environ.get("WEBSITE_HOSTNAME", "*")]
DEBUG = False

# Azure PostgreSQL settings
DATABASE_URL = os.environ.get("DATABASE_URL")

# Handle Azure Storage
STATICFILES_STORAGE = "whitenoise.storage.CompressedStaticFilesStorage"
STATIC_ROOT = os.path.join(BASE_DIR, "staticfiles")  # noqa: F405

# Security settings
CSRF_COOKIE_SECURE = True
SESSION_COOKIE_SECURE = True
CSRF_TRUSTED_ORIGINS = [f"https://{os.environ.get('WEBSITE_HOSTNAME', '*')}"] 