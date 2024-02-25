resource "kubernetes_namespace_v1" "tailscale" {
  metadata {
    name = "tailscale-system"
  }
}

resource "helm_release" "tailscale-operator" {
  wait       = false
  name       = "tailscale-operator"
  chart      = "tailscale-operator"
  version    = "1.56.1"
  repository = "https://pkgs.tailscale.com/helmcharts"
  namespace  = kubernetes_namespace_v1.tailscale.metadata[0].name

  set {
    name  = "oauth.clientId"
    value = var.clientId
  }

  set {
    name  = "oauth.clientSecret"
    value = var.clientSecret
  }

  set {
    name  = "proxyConfig.firewallMode"
    value = "nftables"
  }
}
