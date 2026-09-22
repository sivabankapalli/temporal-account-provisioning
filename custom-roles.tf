# Account-level custom roles (design diagram: "Custom Roles" box).
module "audit_log_reader_role" {
  source = "git::__MODULES_PATH__//modules/custom-role?ref=v0.2.0"

  name        = "cr-audit-log-reader"
  description = "Read audit logs (CSIRT)."
  permissions = [{
    actions       = var.audit_log_reader_actions
    resource_type = "accounts"
    allow_all     = true
  }]
}

module "user_access_reader_role" {
  source = "git::__MODULES_PATH__//modules/custom-role?ref=v0.2.0"

  name        = "cr-user-access-reader"
  description = "Read users, groups and their access (IGA)."
  permissions = [{
    actions       = var.user_access_reader_actions
    resource_type = "accounts"
    allow_all     = true
  }]
}
