resource "azurerm_app_configuration" "appconfig" {
  name                = "${local.env}-${var.config_name}"
  resource_group_name = var.resource_group_name
  location            = var.location
}

data "azurerm_client_config" "current" {}

resource "azurerm_role_assignment" "appconfig_dataowner" {
  scope                = azurerm_app_configuration.appconfig.id
  role_definition_name = "App Configuration Data Owner"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_app_configuration_feature" "feature" {
  for_each = var.features

  configuration_store_id = azurerm_app_configuration.appconfig.id
  name                   = each.key
  description            = each.value.description
  enabled                = each.value.enabled
  label                  = each.value.label

  lifecycle {
    ignore_changes = [
      enabled,
    ]
  }

  depends_on = [
    azurerm_role_assignment.appconfig_dataowner,
  ]
}
