
resource "helm_release" "docker-registry" {
  chart = "docker-registry"
  name  = "docker-registry"
  repository = "https://helm.twun.io"
  namespace = data.kubernetes_namespace_v1.kube-system.metadata[0].name

}

resource "kubernetes_ingress_v1" "ts-docker-registry" {
  metadata {
    name      = "tailscale-docker-registry"
    namespace = "kube-system"
    annotations = {
      "tailscale.com/hostname" = "docker"
    }
  }

  spec {
    default_backend {
      service {
        name = "docker-registry"
        port {
          number = 5000
        }
      }
    }
    ingress_class_name = "tailscale"
    tls {
      hosts = ["docker.tailff458.ts.net"]
    }
  }
}
