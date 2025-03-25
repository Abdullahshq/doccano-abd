import os

from .production import *  # noqa: F403

# Azure-specific settings
ALLOWED_HOSTS = [os.environ.get("WEBSITE_HOSTNAME", "*"), "*.azurewebsites.net", "localhost", "127.0.0.1"]
DEBUG = os.environ.get("DEBUG", "False").lower() == "true"

# Azure PostgreSQL settings
DATABASE_URL = os.environ.get("DATABASE_URL")

# Handle Azure Storage
STATICFILES_STORAGE = "whitenoise.storage.CompressedStaticFilesStorage"
STATIC_ROOT = os.path.join(BASE_DIR, "staticfiles")  # noqa: F405

# Security settings
CSRF_COOKIE_SECURE = True
SESSION_COOKIE_SECURE = True
CSRF_TRUSTED_ORIGINS = [
    f"https://{os.environ.get('WEBSITE_HOSTNAME', '*')}",
    f"https://*.azurewebsites.net"
]

# Logging configuration for Azure
LOGGING = {
    "version": 1,
    "disable_existing_loggers": False,
    "formatters": {
        "verbose": {
            "format": "[%(asctime)s] [%(process)d] [%(levelname)s] [%(name)s::%(funcName)s::%(lineno)d] %(message)s",
            "datefmt": "%Y-%m-%d %H:%M:%S %z",
        },
    },
    "handlers": {
        "console": {
            "level": "INFO",
            "class": "logging.StreamHandler",
            "formatter": "verbose",
        },
    },
    "root": {
        "handlers": ["console"],
        "level": "INFO",
    },
    "loggers": {
        "django": {
            "handlers": ["console"],
            "level": "INFO",
            "propagate": False,
        },
        "django.server": {
            "handlers": ["console"],
            "level": "INFO",
            "propagate": False,
        },
    },
}