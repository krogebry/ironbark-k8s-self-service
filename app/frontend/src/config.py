import os

API_URL = os.environ.get('API_URL')
if "LOCAL_DEV" in os.environ:
    LOCAL_DEV = os.environ['LOCAL_DEV']
else:
    LOCAL_DEV = "0"
