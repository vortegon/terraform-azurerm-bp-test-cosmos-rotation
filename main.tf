module "azure_region" {
  source  = "spacelift.io/vicsoft/comp-regions/azurerm"
  version = "0.1.0"

  azure_region = var.azure_region
}

module "rg" {
  source  = "spacelift.io/vicsoft/comp-rg/azurerm"
  version = "0.1.0"

  location    = module.azure_region.location
  client_name = var.client_name
  environment = var.environment
  stack       = var.stack
}

module "logs" {
  source  = "spacelift.io/vicsoft/comp-logs/azurerm"
  version = "0.1.0"

  client_name         = var.client_name
  environment         = var.environment
  stack               = var.stack
  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.resource_group_name
}

module "cosmosdb" {
  source  = "spacelift.io/vicsoft/comp-cosmos-db/azurerm"
  version = "0.1.4"

  environment    = var.environment
  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  client_name    = var.client_name
  stack          = var.stack

  resource_group_name = module.rg.resource_group_name

  keyvault_id = var.keyvault_id
  key_validity_period_days = var.key_validity_period_days

  logs_destinations_ids = [module.logs.log_analytics_workspace_id]
  backup = {
    type                = "Periodic"
    interval_in_minutes = 60 * 3 # 3 hours
    retention_in_hours  = 24
    storage_redundancy  = "Zone"
  }

  extra_tags = {
    managed_by            = "Open Tofu"
    monitor_autoscale_max = 2
  }
}
