provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}

# resource "helm_release" "argo-cd" {
#   depends_on = [ null_resource.kubeconfig, helm_release.nginx-ingress ]
#
#   name  = "argocd"
#   repository = "https://argoproj.github.io/argo-helm"
#   chart = "argo-cd"
#
#   set = [
#     {
#       name  = "server.ingress.enabled"
#       value = "true"
#     },
#     {
#       name  = "server.ingress.ingressClassName"
#       value = "nginx"
#     },
#     {
#       name  = "global.domain"
#       value = "argocd-${var.env}.sandeepkumar0088.online"
#     },
#     {
#       name  = "configs.params.server\\.insecure"
#       value = "true"
#     }
#   ]
# }

resource "helm_release" "prometheus-stack" {
  depends_on  = [ null_resource.kubeconfig, helm_release.nginx-ingress ]

  name        = "promstack"
  repository  = "https://prometheus-community.github.io/helm-charts"
  chart       = "kube-prometheus-stack"
  values      = [file("prom-stack-values.yml")]

  set = [
    {
      name  = "grafana.enabled"
      value = "false"
    },
    {
      name  = "prometheus.ingress.enabled"
      value = "true"
    },
    {
      name  = "prometheus.ingress.ingressClassName"
      value = "nginx"
    }
  ]
  set_list = [
    {
      name  = "prometheus.ingress.hosts"
      value = ["prometheus-${var.env}.sandeepkumar0088.online"]
    }
  ]

}

resource "helm_release" "nginx-ingress" {
  depends_on = [ null_resource.kubeconfig ]

  name  = "ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart = "ingress-nginx"
  set = [
    {
      name  = "controller.metrics.enabled"
      value = "true"
    },
    {
      name  = "controller.podAnnotations.prometheus\\.io/port"
      value = "10254"
    },
    {
      name  = "controller.podAnnotations.prometheus\\.io/scrape"
      value = "true"
    }
  ]
}

# resource "helm_release" "external-dns" {
#   depends_on = [ null_resource.kubeconfig ]
#
#   name  = "external-dns"
#   repository = "https://kubernetes-sigs.github.io/external-dns"
#   chart = "external-dns"
#
# }

resource "helm_release" "filebeat" {
  depends_on = [ null_resource.kubeconfig ]

  name  = "filebeat"
  repository = "https://helm.elastic.co"
  chart = "filebeat"
  namespace = "kube-system"

  values = [file("filebeat.yml")]

}