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
