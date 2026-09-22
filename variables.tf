variable "environment" {
  description = "Environment code for this PoC run. Kept separate from ci/dev/qa/prod so it can't collide with the real environments."
  type        = string
  default     = "poc"
}

variable "enable_delete_protection" {
  description = "Keep false for a PoC so `terraform destroy` can clean up the project."
  type        = bool
  default     = false
}

# --- custom role actions -----------------------------------------------------------------
# UNCONFIRMED: the provider docs show only "cloud.account.get" as an example action string.
# Replace these with the real actions once you've confirmed them (Temporal Cloud docs, your
# pre-release notes, or Temporal support). The PoC will apply with the placeholder, but the
# roles won't grant the access their names imply until these are correct.
variable "audit_log_reader_actions" {
  type    = set(string)
  default = ["cloud.account.get"] # TODO: replace with the real audit-log read action(s)
}

variable "user_access_reader_actions" {
  type    = set(string)
  default = ["cloud.account.get"] # TODO: replace with the real user/access read action(s)
}

variable "project_admin_actions" {
  type    = set(string)
  default = ["cloud.account.get"] # TODO: replace with the real project admin action(s)
}

# --- SCIM groups --------------------------------------------------------------------------
# Each is optional (null = skip). Set it to the group's idp_id (its name in your IdP, usually
# visible in Temporal Cloud under Users & Roles > SCIM groups) to test that part of the design.
# Leave null if you don't have real SCIM groups synced yet -- the rest of the PoC still runs.
variable "billing_admin_group_idp_id" {
  type    = string
  default = null
}

variable "audit_reader_group_idp_id" {
  type    = string
  default = null
}

variable "project_admin_group_idp_id" {
  type    = string
  default = null
}

# NOTE: "Temporal Account Owner" is intentionally not modelled here. account_access = "owner"
# cannot be created, updated or deleted by Terraform without Temporal support -- it's
# import-only. See docs/STATE-BACKEND.md in temporal-account-provisioning.
