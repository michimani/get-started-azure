locals {
  env      = var.env
  location = var.location

  tags = {
    env        = var.env
    managed_by = "terraform"
  }
}


variable "env" {
  type        = string
  description = "name of environment"
}

variable "location" {
  type        = string
  description = "location of resources"
}

variable "resource_group_name" {
  type        = string
  description = "name of resource group"
}

variable "config_name" {
  type        = string
  description = "name of app configuration"
}

variable "features" {
  type = map(object({
    description = string
    enabled     = bool
    label       = string
  }))
  description = "map of feature flags. (map key is the name of the feature flag)"
}
