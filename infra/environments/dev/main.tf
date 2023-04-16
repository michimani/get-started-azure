resource "azurerm_resource_group" "main" {
  name     = "${local.env}-get-started-azure-rg"
  location = local.location
}

module "feature_flags" {
  source = "../../modules/featureflag"

  env                 = local.env
  location            = local.location
  resource_group_name = azurerm_resource_group.main.name

  config_name = "get-started-azure-config"
  features = {
    "color_red" = {
      description = "color red"
      enabled     = true
      label       = "color"
    },
  }
}
