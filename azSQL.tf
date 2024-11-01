# === MS SQL Server DB with Private Endpoint ===
resource "azurerm_mssql_server" "AzureSQL_Server" {
  name                          = "bestrong-az-sql-srv3"
  location                      = azurerm_resource_group.BeStrong.location
  resource_group_name           = azurerm_resource_group.BeStrong.name
  version                       = "12.0"
  administrator_login           = var.BeStrong_azSQL_login
  administrator_login_password  = var.BeStrong_azSQL_password
  public_network_access_enabled = false
}

resource "azurerm_mssql_database" "AzureSQL_DB" {
  name      = "BeStrong-az-sql-db"
  server_id = azurerm_mssql_server.AzureSQL_Server.id
  collation = "SQL_Latin1_General_CP1_CI_AS"
  #license_type = "LicenseIncluded"
  max_size_gb                 = var.BeStrong_azSQL_size_gb
  sku_name                    = join("", ["GP_S_Gen5_", tostring(var.BeStrong_azSQL_vCPU_max)])
  min_capacity                = var.BeStrong_azSQL_vCPU_min
  auto_pause_delay_in_minutes = var.BeStrong_azSQL_vCPU_pause_delay

  lifecycle {
    prevent_destroy = false
  }
}

resource "azurerm_private_endpoint" "sql_private_endpoint" {
  name                = "BeStrong-sql-private-endpoint"
  location            = azurerm_resource_group.BeStrong.location
  resource_group_name = azurerm_resource_group.BeStrong.name
  subnet_id           = azurerm_subnet.private_endpoints_subnet.id

  private_service_connection {
    name                           = "sqlPrivLink"
    private_connection_resource_id = azurerm_mssql_server.AzureSQL_Server.id
    is_manual_connection           = false
    subresource_names              = ["sqlServer"]
  }
}