variable "name" {
  type        = string
  description = "Name of the namespace. Leave empty if generate_name is true."
  default     = ""
}

variable "annotations" {
  type        = map(string)
  description = "Annotations for the namespace."
  default     = {}
}

variable "labels" {
  type        = map(string)
  description = "Labels for the namespace."
  default     = {}
}

variable "generate_name" {
  type        = bool
  description = "Generate namespace name if name is not provided."
  default     = false

  validation {
    condition = (
      (var.name != "" && var.generate_name == false) ||
      (var.name == "" && var.generate_name == true)
    )
    error_message = "Either provide 'name' OR set 'generate_name = true', but not both."
  }
}

variable "name_prefix" {
  type        = string
  description = "Prefix used when generate_name is true."
  default     = ""

  validation {
    condition = (
      var.generate_name == false || (var.generate_name == true && length(var.name_prefix) > 0)
    )
    error_message = "name_prefix must be non-empty when generate_name is true."
  }
}

variable "delete_timeouts"{
    type        = string
    description = "Define the delete timeouts for the namespace. Default : 5 Minutes"
    default     = "5m"
}

variable "create_custom_default_service_account" {
  type = bool
  description = "Create custom default service account for the targeted namespace."
  default = false
}

// Variables for custom default service account resource
variable "automount_service_account_token" {
    type = bool
    description = "Set Auto Mounting for token inside Pods"
    default = false
}

variable "image_pull_secrets" {
    description = "List of secrets that is used for pulling image"
    type = list(string)
    default = []
}

variable "mountable_secrets" {
    description = "List of Mountable secrets to be used by pods"
    type = list(string)
    default = []
}

variable "create_token" {
    description = "Create a service-account-token secret (required for K8s >=1.24)"
    type = bool
    default = false
}