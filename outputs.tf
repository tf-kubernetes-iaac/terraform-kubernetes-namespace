output "namespace_name" {
  description = "The final name of the Kubernetes namespace."
  value       = kubernetes_namespace_v1.this.metadata[0].name
}

output "namespace_uid" {
  description = "The UID of the Kubernetes namespace."
  value       = kubernetes_namespace_v1.this.metadata[0].uid
}

output "namespace_annotations" {
  description = "Annotations applied to the namespace."
  value       = kubernetes_namespace_v1.this.metadata[0].annotations
}

output "namespace_labels" {
  description = "Labels applied to the namespace."
  value       = kubernetes_namespace_v1.this.metadata[0].labels
}

output "namespace_generation_method" {
  description = "Indicates whether the namespace name was generated or explicitly provided."
  value       = var.generate_name ? "generated" : "explicit"
}
