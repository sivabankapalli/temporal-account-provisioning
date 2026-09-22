# Design diagram: "SCIM User Group RBAC" box (Temporal Account Owner excluded -- see variables.tf).
module "billing_admin_access" {
  count  = length(data.temporalcloud_scim_group.billing_admin) > 0 ? 1 : 0
  source = "git::__MODULES_PATH__//modules/group-access?ref=v0.2.0"

  group_id       = data.temporalcloud_scim_group.billing_admin[0].id
  account_access = "financeadmin"
}

module "audit_reader_access" {
  count  = length(data.temporalcloud_scim_group.audit_reader) > 0 ? 1 : 0
  source = "git::__MODULES_PATH__//modules/group-access?ref=v0.2.0"

  group_id                    = data.temporalcloud_scim_group.audit_reader[0].id
  account_access              = "none"
  account_access_custom_roles = [module.audit_log_reader_role.id]
}
