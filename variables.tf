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
