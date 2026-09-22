# Design diagram: "Service Accounts" box.
module "csirt_audit_log_reader" {
  source = "git::__MODULES_PATH__//modules/service-account?ref=v0.2.0"

  name                        = "sa-platform-csirt-audit-log-reader-${var.environment}"
  description                 = "CSIRT audit log reader."
  account_access_custom_roles = [module.audit_log_reader_role.id]
}

module "iga_user_access_reader" {
  source = "git::__MODULES_PATH__//modules/service-account?ref=v0.2.0"

  name                        = "sa-platform-iga-user-access-reader-${var.environment}"
  description                 = "IGA user access reader."
  account_access_custom_roles = [module.user_access_reader_role.id]
}
