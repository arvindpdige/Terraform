resource "azurerm_service_plan" "asp" {
  name                = "${var.prefix}-asp"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "F1"

}

resource "azurerm_linux_web_app" "app_linux" {
  name                = "${var.prefix}-app"
  location            = azurerm_service_plan.asp.location
  resource_group_name = azurerm_service_plan.asp.resource_group_name
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    linux_fx_version = "NODE|20-lts"
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "SCM_DO_BUILD_DURING_DEPLOYMENT"      = true
    "WEBSITE_LOCAL_CACHE_OPTION"          = "Never"
  }
  identity {
    type = "SystemAssigned"
  }

}
