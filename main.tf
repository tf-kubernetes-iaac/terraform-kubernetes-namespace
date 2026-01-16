# Default Service Account defination for the namespace.
# Must be created and used only once.
resource "kubernetes_default_service_account_v1" "custom_default_sa" {
  count = var.create_custom_default_service_account ? 1 : 0
  metadata {
    namespace = kubernetes_namespace_v1.this.metadata[0].name
    labels        = var.labels
    annotations   = var.annotations
  }
  automount_service_account_token = var.automount_service_account_token

  dynamic "image_pull_secret" {
    for_each = var.image_pull_secrets 
    content {
      name = image_pull_secret.value
    }
  }
  dynamic "secret" {
    for_each = var.mountable_secrets
    content {
      name = secret.value
    }
  }
}

resource "kubernetes_secret_v1" "default_sa_token" {
    count = var.create_token ? 1 : 0

    metadata {
      name = "${kubernetes_default_service_account_v1.custom_default_sa[0].metadata[0].name}-token"
      namespace = kubernetes_namespace_v1.this.metadata[0].name

      annotations = {
        "kubernetes.io/service-account.name" = kubernetes_default_service_account_v1.custom_default_sa[0].metadata[0].name
      }
    }

    type = "kubernetes.io/service-account-token"
  
}

resource "kubernetes_namespace_v1" "this" {
  metadata {
    name          = var.generate_name ? null : var.name
    generate_name = var.generate_name ? "${var.name_prefix}-" : null
    labels        = var.labels
    annotations   = var.annotations
  }
  timeouts {
    delete = var.delete_timeouts
  }
}
