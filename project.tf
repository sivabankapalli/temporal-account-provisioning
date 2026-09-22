module "project" {
  source = "git::__MODULES_PATH__//modules/project?ref=v0.2.0"

  display_name             = "project-${var.environment}"
  description              = "Laptop PoC project for ${var.environment}."
  enable_delete_protection = var.enable_delete_protection
}
