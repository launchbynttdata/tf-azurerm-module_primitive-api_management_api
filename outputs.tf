output "api_id" {
  description = "The ID of the API Management API resource."
  value       = azurerm_api_management_api.api.id
}

output "api_name" {
  description = "The name of the API Management API resource."
  value       = azurerm_api_management_api.api.name
}

output "api_path" {
  description = "The path of the API Management API resource."
  value       = azurerm_api_management_api.api.path
}

output "revision" {
  description = "The revision of the API Management API resource."
  value       = azurerm_api_management_api.api.revision
}

output "is_current" {
  description = "Indicates whether the API Management API is the current revision."
  value       = azurerm_api_management_api.api.is_current
}

output "version" {
  description = "The version of the API Management API resource."
  value       = azurerm_api_management_api.api.version
}

output "version_set_id" {
  description = "The ID of the version set to which this API belongs."
  value       = azurerm_api_management_api.api.version_set_id
}
