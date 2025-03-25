"""Django settings for app project.

This file imports the appropriate settings based on the environment.
For more information on this file, see
https://docs.djangoproject.com/en/3.2/topics/settings/
"""

import os

env = os.environ.get("APP_ENV", "production")

if env == "production":
    from .settings.production import *  # noqa: F403
elif env == "development":
    from .settings.development import *  # noqa: F403
elif env == "azure":
    from .settings.azure import *  # noqa: F403
else:
    from .settings.production import *  # noqa: F403