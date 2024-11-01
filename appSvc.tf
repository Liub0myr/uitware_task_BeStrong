# === Create a App Service ===
# Warn: App Service Identity has access to Container Registry: BeStrongContainerRegistry
#       more in containerRegistry.tf
resource "azurerm_service_plan" "svcplan" {
  name                = "BeStrong-appserviceplan"
  location            = azurerm_resource_group.BeStrong.location
  resource_group_name = azurerm_resource_group.BeStrong.name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "appsvc" {
  name                      = "BeStrong-appservice-webapp3"
  location                  = azurerm_resource_group.BeStrong.location
  resource_group_name       = azurerm_resource_group.BeStrong.name
  service_plan_id           = azurerm_service_plan.svcplan.id
  virtual_network_subnet_id = azurerm_subnet.subnet.id # VNet integration
  site_config {
    always_on = false
  }

  storage_account {
    name         = azurerm_storage_account.storage_account.name
    account_name = azurerm_storage_account.storage_account.name
    share_name   = azurerm_storage_share.file_share.name
    mount_path   = "/mnt/fileshare"
    type         = "AzureFiles"
    access_key   = azurerm_storage_account.storage_account.primary_access_key
  }

  identity {
    type = "SystemAssigned"
  }
  depends_on = [azurerm_storage_share.file_share]
}