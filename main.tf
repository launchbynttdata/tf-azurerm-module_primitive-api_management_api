resource "azurerm_api_management_api" "apim_api" {
  name                  = var.api_name
  resource_group_name   = var.resource_group_name
  api_management_name   = var.apim_name
  revision              = var.revision
  path                  = var.api_path
  protocols             = var.protocols
  subscription_required = var.subscription_required
  api_type              = var.api_type
  description           = var.description != null ? var.description : null
  service_url           = var.service_url != null ? var.service_url : null
  display_name          = var.api_display_name != null ? var.api_display_name : null
  terms_of_service_url  = var.terms_of_service_url != null ? var.terms_of_service_url : null
  ## both version and version_set_id must be set, or neither should be set
  version_set_id       = var.apiversion != null && var.version_set_id != null ? var.version_set_id : null
  version              = var.apiversion != null && var.version_set_id != null ? var.apiversion : null
  revision_description = var.revision_description != null ? var.revision_description : null
  version_description  = var.version_description != null ? var.version_description : null
  source_api_id        = var.source_api_id != null ? var.source_api_id : null

  dynamic "import" {
    for_each = var.import_api != null ? [var.import_api] : []
    content {
      content_format = import.value.content_format
      content_value  = import.value.content_value
      dynamic "wsdl_selector" {
        for_each = var.import_api.wsdl_selector != null ? [var.import_api.wsdl_selector] : []
        content {
          service_name  = wsdl_selector.value.service_name
          endpoint_name = wsdl_selector.value.endpoint_name
        }
      }
    }
  }

  dynamic "oauth2_authorization" {
    for_each = var.oauth2_authorization != null ? [var.oauth2_authorization] : []
    content {
      authorization_server_name = oauth2_authorization.value.authorization_server_name
      scope                     = oauth2_authorization.value.scope
    }
  }

  dynamic "openid_authentication" {
    for_each = var.openid_authentication != null ? [var.openid_authentication] : []
    content {
      openid_provider_name         = openid_authentication.value.openid_provider_name
      bearer_token_sending_methods = openid_authentication.value.bearer_token_sending_methods
    }
  }

  dynamic "subscription_key_parameter_names" {
    for_each = var.subscription_key_parameter_names != null ? [var.subscription_key_parameter_names] : []
    content {
      header = subscription_key_parameter_names.value.header
      query  = subscription_key_parameter_names.value.query
    }
  }

  dynamic "license" {
    for_each = var.license != null ? [var.license] : []
    content {
      name = license.value.name
      url  = license.value.url
    }
  }
  dynamic "contact" {
    for_each = var.contact != null ? [var.contact] : []
    content {
      name  = contact.value.name
      email = contact.value.email
      url   = contact.value.url
    }
  }
}



resource "azurerm_api_management_api_release" "apim_api_release" {
  name   = "${var.api_name}-current-release"
  api_id = azurerm_api_management_api.apim_api.id
}