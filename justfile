version := `cat VERSION`

build-frontend:
    docker buildx build -f docker/frontend/Dockerfile -t docker.tailff458.ts.net:{{ version }} .

push-frontend:
    docker \
      buildx \
      build \
      --push \
      -f docker/frontend/Dockerfile \
      -t docker.tailff458.ts.net/ironbark/app/frontend:{{ version }} \
      .
      
run-frontend:
    docker \
      run \
      -v ~/.kube/config:/root/.kube/config \
      -p 3001:3001 \
      docker.tailff458.ts.net/ironbark/app/frontend:{{ version }}

run-helm-frontend:
    cd charts/frontend; helm upgrade --install frontend .  --set image.tag={{ version }}

list-namespaces:
    #!/usr/bin/env python3
    from kubernetes import config , client
    from kubernetes.client import Configuration
    from kubernetes.client.api import core_v1_api
    from kubernetes.client.rest import ApiException
    from kubernetes.stream import stream

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
