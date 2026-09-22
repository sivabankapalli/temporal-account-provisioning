# Look up each SCIM group by its IdP name instead of pasting a raw Temporal Cloud group ID.
data "temporalcloud_scim_group" "billing_admin" {
  count  = var.billing_admin_group_idp_id == null ? 0 : 1
  idp_id = var.billing_admin_group_idp_id
}

data "temporalcloud_scim_group" "audit_reader" {
  count  = var.audit_reader_group_idp_id == null ? 0 : 1
  idp_id = var.audit_reader_group_idp_id
}

data "temporalcloud_scim_group" "project_admin" {
  count  = var.project_admin_group_idp_id == null ? 0 : 1
  idp_id = var.project_admin_group_idp_id
}
