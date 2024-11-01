# === Create a Container Registry and grant App Service Identity access to it ===
resource "azurerm_container_registry" "acr" {
  name                = "BeStrongContainerRegistry3"
  location            = azurerm_resource_group.BeStrong.location
  resource_group_name = azurerm_resource_group.BeStrong.name
  sku                 = "Basic"
  admin_enabled       = false
}

resource "azurerm_role_assignment" "appsvc_acr_pull" {
  principal_id         = azurerm_linux_web_app.appsvc.identity[0].principal_id
  role_definition_name = "AcrPull"
  scope                = azurerm_container_registry.acr.id
  depends_on           = [azurerm_linux_web_app.appsvc]
}