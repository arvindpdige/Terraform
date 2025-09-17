data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "key_vault" {
  name                        = "${var.prefix}-keyvault"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  tags                        = var.tags
  sku_name                    = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "List", "Update", "Create", "Import", "Delete", "Recover", "Backup", "Restore", "Decrypt", "Encrypt",
      "UnwrapKey", "WrapKey", "Verify", "Sign", "Purge", "Release", "Rotate", "GetRotationPolicy",
      "SetRotationPolicy"
    ]

    secret_permissions = [
      "Get", "List", "Set", "Delete", "Recover", "Backup", "Restore", "Purge"
    ]
    certificate_permissions = [
      "Get", "List", "Create", "Delete", "Update", "Import", "Recover", "Purge",
      "Backup", "Restore", "ManageContacts", "ManageIssuers", "GetIssuers",
      "ListIssuers", "SetIssuers", "DeleteIssuers"
    ]
  }
  public_network_access_enabled = true


}