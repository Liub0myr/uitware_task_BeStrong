# === Create a Storage Account ===
resource "azurerm_storage_account" "storage_account" {
  name                     = "bestrongstorageaccount3"
  resource_group_name      = azurerm_resource_group.BeStrong.name
  location                 = azurerm_resource_group.BeStrong.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  # public_network_access_enabled = false # 403 This request is not authorized to perform this operation
  public_network_access_enabled = true
}

resource "azurerm_storage_share" "file_share" {
  name                 = "bestrong-file-share"
  storage_account_name = azurerm_storage_account.storage_account.name
  quota                = var.BeStrong_storage_file_share_size_gb
}

resource "azurerm_private_endpoint" "storage_private_endpoint" {
  name                = "bestorage-private-endpoint"
  location            = azurerm_resource_group.BeStrong.location
  resource_group_name = azurerm_resource_group.BeStrong.name
  subnet_id           = azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = "storagePrivLink"
    private_connection_resource_id = azurerm_storage_account.storage_account.id
    is_manual_connection           = false
    subresource_names              = ["file"]
  }
}