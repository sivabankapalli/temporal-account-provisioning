# Design diagram: "Project Admin Service Accounts" + "Project Admin SCIM User Group RBAC".
# WORKAROUND: modelled as an account-level custom role scoped to this one project, because
# group_access/service_account have no native project-level access yet. See modules repo
# docs/CONTRIBUTING.md and README.md for the upstream PRs to watch.
module "project_admin" {
  count  = length(data.temporalcloud_scim_group.project_admin) > 0 ? 1 : 0
  source = "git::__MODULES_PATH__//modules/project-access?ref=v0.2.0"

  environment           = var.environment
  project_id            = module.project.id
  project_admin_actions = var.project_admin_actions
  admin_group_id         = data.temporalcloud_scim_group.project_admin[0].id
}
