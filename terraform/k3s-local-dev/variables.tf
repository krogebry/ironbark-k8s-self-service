
variable "clientId" {
  sensitive = true
}

variable "clientSecret" {
  sensitive = true
}

data "kubernetes_namespace_v1" "kube-system" {
  metadata {
    name = "kube-system"
  }
}
