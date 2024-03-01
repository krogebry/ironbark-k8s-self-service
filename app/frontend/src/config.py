import os

if "LOCAL_DEV" in os.environ:
    LOCAL_DEV = os.environ['LOCAL_DEV']
else:
    LOCAL_DEV = "0"
