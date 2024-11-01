# === Create an Application Insights ===
resource "azurerm_application_insights" "appinsights" {
  name                = "BeStrong-appinsights"
  location            = azurerm_resource_group.BeStrong.location
  resource_group_name = azurerm_resource_group.BeStrong.name
  application_type    = "web"
}

