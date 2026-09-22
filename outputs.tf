output "project_id" {
  value = module.project.id
}

output "audit_log_reader_role_id" {
  value = module.audit_log_reader_role.id
}

output "user_access_reader_role_id" {
  value = module.user_access_reader_role.id
}

output "service_account_ids" {
  value = {
    csirt_audit_log_reader   = module.csirt_audit_log_reader.id
    iga_user_access_reader   = module.iga_user_access_reader.id
  }
}

output "scim_rbac_applied" {
  description = "Which SCIM group RBAC pieces actually ran (others were skipped because no idp_id was supplied)."
  value = {
    billing_admin = length(module.billing_admin_access) > 0
    audit_reader  = length(module.audit_reader_access) > 0
    project_admin = length(module.project_admin) > 0
  }
}
