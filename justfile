
build version="0.1.0-dev":
    docker buildx build -t guzila:{{ version }} .

list-namespaces:
    #!/usr/bin/env python3
    from kubernetes import config , client
    from kubernetes.client import Configuration
    from kubernetes.client.api import core_v1_api
    from kubernetes.client.rest import ApiException
    from kubernetes.stream import stream
    import re

    pod_namespace = "dev_staging"
    pod_regex = "log_depl"
    try:
        config.load_kube_config()
        c = Configuration().get_default_copy()
    except AttributeError:
        c = Configuration()
        c.assert_hostname = False
    Configuration.set_default(c)
    v1 = core_v1_api.CoreV1Api()

    nameSpaceList = v1.list_namespace()
    for nameSpace in nameSpaceList.items:
        print(nameSpace.metadata.name)

