# === Create a Key Vault and grant permissions to App Service Identity ===
data "azurerm_client_config" "current" {} # Get the current tenant_id

resource "azurerm_key_vault" "key_vault" {
  name                        = "BeStrong-Key-Vault"
  location                    = azurerm_resource_group.BeStrong.location
  resource_group_name         = azurerm_resource_group.BeStrong.name
  enabled_for_disk_encryption = false # required bypass = "AzureServices"
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = azurerm_linux_web_app.appsvc.identity[0].principal_id

    key_permissions = [
      "Get",
      "List",
    ]

    secret_permissions = [
      "Get",
      "List",
    ]

    storage_permissions = [
      "Get",
      "List",
    ]
  }

  network_acls {
    default_action = "Deny"
    bypass         = "None" # AzureServices

    virtual_network_subnet_ids = [
      azurerm_subnet.subnet.id,
    ]
  }
}