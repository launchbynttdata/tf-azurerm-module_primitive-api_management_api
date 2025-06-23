resource "azurerm_api_management_api" "api" {
  name                  = var.name
  api_management_name   = var.api_management_name
  resource_group_name   = var.resource_group_name
  revision              = var.revision
  revision_description  = var.revision_description
  api_type              = var.api_type
  description           = var.description
  display_name          = var.display_name
  path                  = var.path
  protocols             = var.protocols
  service_url           = var.service_url
  soap_pass_through     = var.soap_pass_through
  source_api_id         = var.source_api_id
  subscription_required = var.subscription_required
  terms_of_service_url  = var.terms_of_service_url
  version               = var.version_number
  version_description   = var.version_description
  version_set_id        = var.version_set_id

  dynamic "contact" {
    for_each = var.contact != null ? [var.contact] : []
    content {
      name  = contact.value.name
      email = contact.value.email
      url   = contact.value.url
    }
  }

  dynamic "import" {
    for_each = var.import != null ? [var.import] : []
    content {
      content_format = import.value.content_format
      content_value  = import.value.content_value
    }
  }

  dynamic "license" {
    for_each = var.license != null ? [var.license] : []
    content {
      name = license.value.name
      url  = license.value.url
    }
  }
}

resource "azurerm_api_management_api_policy" "api_policy" {
  count = var.policy != null ? 1 : 0

  api_name            = azurerm_api_management_api.api.name
  api_management_name = var.api_management_name
  resource_group_name = var.resource_group_name

  xml_content = try(var.policy.xml_content, null)
  xml_link    = try(var.policy.xml_link, null)
}
