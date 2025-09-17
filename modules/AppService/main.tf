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
  https_only          = true
  site_config {
    application_stack {
      node_version = "20-lts"
    }
    
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

resource "azurerm_app_service_source_control" "scm" {
  app_id             = azurerm_linux_web_app.app_linux.id
  repo_url           = "https://github.com/Azure-Samples/nodejs-docs-hello-world"
  branch             = "main"
  use_manual_integration = true
  use_mercurial      = false
}
