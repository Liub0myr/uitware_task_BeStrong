terraform test
c52ef17
main.tf
@@ -0,0 +1,27 @@
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.7.0"
    }
  }
  required_version = "1.9.8"
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = false
      recover_soft_deleted_key_vaults = true
    }
  }
  # skip_provider_registration = true       # Legacy. Replaced by resource_provider_registrations
  resource_provider_registrations = "core" # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#resource-provider-registrations
  use_oidc                        = true
}

# === test ===
resource "azurerm_resource_group" "BeStrong" {
  name     = "testGitHubActionsAuth"
  location = "uksouth"
}