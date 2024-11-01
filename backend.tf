# terraform {
#   backend "azurerm" {
#     resource_group_name  = "storage"
#     storage_account_name = "liubfiles"
#     container_name       = "bestrong-tfstate"
#     key                  = "terraform.tfstate"
#     use_oidc             = true
#   }
# }