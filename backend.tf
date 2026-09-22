# Local state for a laptop PoC only. State still holds every attribute of every resource
# (service account names, role permissions, etc.) even though it never contains the API key
# itself, so keep terraform.tfstate out of git (see .gitignore) and delete this whole folder
# when you're done, or move to the real azurerm backend from temporal-account-provisioning.
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
