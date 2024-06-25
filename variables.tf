variable "azure_region" {
  description = "Azure region to use."
  type        = string
}

variable "client_name" {
  description = "Client name"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "stack" {
  description = "Stack name"
  type        = string
}

variable "keyvault_id" {
  description = "ID of the keyvault for key rotation."
  type        = string
}

variable "key_validity_period_days" {
  description = "Number of days when the key is rotated."
  type        = number
}