terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "2.17.0"
    }
  }
}
provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "helm_release" "argo-cd" {
  depends_on = [ null_resource.kubeconfig ]

  chart = "argo-cd"
  name  = "argocd"
  repository = "https://argoproj.github.io/argo-helm"

  set = [
    {
      name= "server.service.type"
      value= "LoadBalancer"
    }
  ]
}