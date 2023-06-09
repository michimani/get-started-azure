locals {
  env       = "dev"
  image_tag = "develop"
  location  = "japaneast"

  subscription_id = data.azurerm_subscription.current.subscription_id

  tags = {
    env        = local.env
    managed_by = "terraform"
  }
}

data "azurerm_subscription" "current" {}
