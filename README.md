# Laptop PoC: full design, local state, real Temporal Cloud account

Validates every box in the design diagram except the Account Owner group (import-only,
see `variables.tf`) and the "Retrieve global admin creds" arrow (that's GHES pipeline
plumbing, not something to PoC). Runs with a **local state file** and modules pulled from
a **local git clone** of `temporal-tf-modules`, against your **real** Temporal Cloud account.

There is no offline or mocked Temporal Cloud: every `apply` here makes real API calls with
an Account Admin key. Use a trial/sandbox account if you have one, not production.

## 1. Point at your modules repo

Clone or copy `temporal-tf-modules` (the sibling PoC folder from this same conversation,
already tagged `v0.1.0` and `v0.2.0`) somewhere on your laptop, then replace the
`__MODULES_PATH__` placeholder in every `.tf` file here with its **absolute** path:

```bash
# macOS/Linux
find . -name '*.tf' -exec sed -i '' 's#__MODULES_PATH__#/Users/siva/dev/temporal-tf-modules#g' {} +
# (drop the '' after -i on Linux/GNU sed)
```

This produces sources like `git::/Users/siva/dev/temporal-tf-modules//modules/project?ref=v0.2.0`.
If your `terraform` build of go-getter rejects a bare local path, use a `file://` URL instead:
`git::file:///Users/siva/dev/temporal-tf-modules//modules/project?ref=v0.2.0`.

## 2. Credentials

```bash
read -rs TEMPORAL_CLOUD_API_KEY && export TEMPORAL_CLOUD_API_KEY   # paste, hit enter
export TEMPORAL_CLOUD_ALLOWED_ACCOUNT_ID=...                        # your account ID, as a guard
```

## 3. Run

```bash
terraform init
terraform plan    # review before applying -- this hits the real API
terraform apply
```

With no `terraform.tfvars`, this creates: one project (`project-poc`), two account-level
custom roles, and two service accounts. Copy `terraform.tfvars.example` to
`terraform.tfvars` and add real SCIM group `idp_id`s (find them in the Temporal Cloud UI
under Users & Roles, or ask whoever manages your Entra ID sync) to also validate the SCIM
group RBAC and project-admin pieces.

## 4. Check what happened

Open the Temporal Cloud UI and confirm the project, roles, service accounts and (if you set
group idp_ids) the group access grants look right. `terraform show` prints everything Terraform
believes it created.

## 5. Clean up

```bash
terraform destroy
```

`enable_delete_protection` defaults to `false` here specifically so this succeeds. If you flip
it to `true` to test that behaviour, set it back to `false` and `apply` before destroying.

## What this does and doesn't prove

Confirms: the modules apply against a real account, the custom-role/service-account/group-access
schema is correct, and (if you supplied group idp_ids) that the SCIM lookup and project-admin
workaround wire together.

Does not confirm: that the placeholder action strings (`cloud.account.get`) actually grant
audit-log or user-access read -- verify that manually against what the service account can
do. Does not confirm the Account Owner flow, which needs Temporal support regardless of
Terraform. Does not exercise the Azure state backend, GHES pipeline, or the promotion/approval
flow from `temporal-account-provisioning` -- this is a single local apply, deliberately simpler.
