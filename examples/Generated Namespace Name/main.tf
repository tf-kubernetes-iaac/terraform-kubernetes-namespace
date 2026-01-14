module "namespace" {
  source  = "kaus33k/namespace/kubernetes"
  version = "1.0.0"

  generate_name = true
  name_prefix   = "dev"

  labels = {
    env = "dev"
  }
}
