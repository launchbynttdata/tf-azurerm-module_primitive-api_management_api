variable "apim_name" {
  type        = string
  description = "name of the apim"
  validation {
    condition     = can(regex("^\\w[\\w\\-]{0,47}\\w$", var.apim_name))
    error_message = "The api_name must be between 2 and 50 characters long, only contain letters, numbers, hyphens and underscores, and must not start or end with a hyphen or underscore."
  }
}

variable "description" {
  type        = string
  description = "description of the API that may include HTML formatting tags"
  default     = null
}

variable "service_url" {
  type        = string
  description = "service url of the API"
  default     = null
  validation {
    condition     = can(regex("^https?://", var.service_url)) || var.service_url == null
    error_message = "The service_url must start with http:// or https://."
  }
}

variable "subscription_required" {
  type        = bool
  description = "whether subscription is required for the API"
  default     = true
  validation {
    condition     = can(regex("^(true|false)$", var.subscription_required))
    error_message = "The subscription_required must be either true or false."
  }
}

variable "terms_of_service_url" {
  type        = string
  description = "terms of service url of the API"
  default     = null
  validation {
    condition     = can(regex("^https?://", var.terms_of_service_url)) || var.terms_of_service_url == null
    error_message = "The terms_of_service_url must start with http:// or https://."
  }
}

variable "apiversion" {
  type        = string
  description = "version of the API"
  default     = null
  validation {
    condition     = can(regex("^[[:alnum:]\\.]{1,64}$", var.apiversion)) || var.apiversion == null
    error_message = "value must be between 1 and 64 characters long, and only contain letters, numbers, and hyphens."
  }
}

variable "version_set_id" {
  type        = string
  description = "version set id of the API"
  default     = null
  validation {
    condition     = can(regex("^[\\.\\/\\w\\-]{0,254}$", var.version_set_id)) || var.version_set_id == null
    error_message = "The version_set_id must be between 2 and 50 characters long, only contain letters, numbers, hyphens and underscores, and must not start or end with a hyphen or underscore."
  }
}

variable "resource_group_name" {
  type        = string
  description = "name of the resource group that contains the apim"
  validation {
    condition     = can(regex("^[\\-\\w\\.\\(\\)]+$", var.resource_group_name))
    error_message = "The resource_group_name must be between 1 and 90 characters long, only contain letters, numbers, hyphens, underscores, periods, parentheses and spaces, and must not end with a period."
  }
}

variable "api_name" {
  type        = string
  description = "name of the API"
  validation {
    condition     = can(regex("^\\w[\\w\\-]{0,47}\\w$", var.api_name))
    error_message = "The api_name must be between 2 and 50 characters long, only contain letters, numbers, hyphens and underscores, and must not start or end with a hyphen or underscore."
  }
}

variable "revision" {
  type        = string
  description = "revision of the API"
  validation {
    condition     = can(regex("^[[:alnum:]]{1,64}$", var.revision))
    error_message = "value must be between 1 and 64 characters long, and only contain letters, numbers, and hyphens."
  }
}

variable "api_display_name" {
  type        = string
  description = "display name of the API"
  default     = null
  validation {
    condition     = can(regex("^\\w[\\w\\-]{0,47}\\w$", var.api_display_name)) || var.api_display_name == null
    error_message = "The display_name must be between 2 and 50 characters long, only contain letters, numbers, hyphens and underscores, and must not start or end with a hyphen or underscore."
  }
}

variable "api_path" {
  type        = string
  description = "path of the API"
  validation {
    condition     = can(regex("^\\w[\\w\\/\\-]*\\w$", var.api_path))
    error_message = "The api_path must not start or end with a slash."
  }
}

variable "protocols" {
  type        = list(string)
  description = "protocols of the API"
  validation {
    condition     = length([for protocol in var.protocols : protocol if can(regex("^(http|https|ws|wss)$", protocol))]) == length(var.protocols)
    error_message = "The protocols must be one of the following: http, https, ws, wss."
  }
}

variable "api_type" {
  type        = string
  description = "type of the API"
  default     = "http"
  validation {
    condition     = can(regex("^(graphql|http|soap|websocket)$", var.api_type))
    error_message = "The api_type must be one of the following: http, soap, graphql, or websocket."
  }
}

variable "oauth2_authorization" {
  type = object({
    authorization_server_name = optional(string, null)
    scope                     = optional(string, null)
  })
  description = "oauth2 authorization settings"
  default     = null
  validation {
    condition     = (can(var.oauth2_authorization.authorization_server_name) && can(regex("^[\\w\\-]{1,80}$", var.oauth2_authorization.authorization_server_name))) || var.oauth2_authorization == null
    error_message = "The authorization_server_id must be between 1 and 80 characters long, and only contain letters, numbers, hyphens, and underscores."
  }
  validation {
    condition     = can(var.oauth2_authorization.scope) && can(regex("^[\\w\\-]{1,80}$", var.oauth2_authorization.scope)) || var.oauth2_authorization == null
    error_message = "The scope must be between 1 and 80 characters long, and only contain letters, numbers, hyphens, and underscores."
  }

}

variable "openid_authentication" {
  type = object({
    openid_provider_name         = optional(string, null)
    bearer_token_sending_methods = optional(list(string), [])
  })
  description = "openid authorization settings"
  default     = null
  validation {
    condition     = (can(var.openid_authentication) && can(regex("^[\\w\\-]{1,80}$", var.openid_authentication.openid_provider_name))) || var.openid_authentication == null
    error_message = "The openid_provider_name must be between 1 and 80 characters long, and only contain letters, numbers, hyphens, and underscores."
  }
  validation {
    condition     = (can(var.openid_authentication) && can(length([for method in var.openid_authentication.bearer_token_sending_methods : method if can(regex("^(authorizationHeader|query)$", method))]) == length(var.openid_authentication.bearer_token_sending_methods))) || var.openid_authentication == null
    error_message = "The bearer_token_sending_methods must be one of the following: authorizationHeader, query."
  }

}

variable "subscription_key_parameter_names" {
  type = object({
    header = optional(string, null)
    query  = optional(string, null)
  })
  description = "subscription key parameter names"
  default     = null
  validation {
    condition     = (can(var.subscription_key_parameter_names) && can(regex("^[\\w\\-]{1,256}$", var.subscription_key_parameter_names.header))) || var.subscription_key_parameter_names == null
    error_message = "The header must be between 1 and 256 characters long, and only contain letters, numbers, hyphens, and underscores."
  }
  validation {
    condition     = (can(var.subscription_key_parameter_names) && can(regex("^[\\w\\-]{1,256}$", var.subscription_key_parameter_names.query))) || var.subscription_key_parameter_names == null
    error_message = "The query must be between 1 and 256 characters long, and only contain letters, numbers, hyphens, and underscores."
  }

}

variable "license" {
  type = object({
    name = optional(string, null)
    url  = optional(string, null)
  })
  description = "license"
  default     = null
  validation {
    condition     = (can(var.license) && can(regex("^[\\w\\/\\-\\.]{1,256}$", var.license.name))) || var.license == null
    error_message = "The name must be between 1 and 256 characters long, and only contain letters, numbers, hyphens, periods, and underscores."
  }
  validation {
    condition     = (can(var.license) && can(regex("^(http|https)://[\\w\\/\\-\\.]{1,256}$", var.license.url))) || var.license == null
    error_message = "The url must be between 1 and 256 characters long, and only contain letters, numbers, hyphens, periods, and underscores."
  }


}

variable "contact" {
  type = object({
    name  = optional(string, null)
    email = optional(string, null)
    url   = optional(string, null)
  })
  description = "contact"
  default     = null
  validation {
    condition     = (can(var.contact.name) && can(regex("^[\\ \\w\\/\\-\\.]{1,256}$", var.contact.name))) || var.contact == null
    error_message = "The name must be between 1 and 256 characters long, and only contain letters, numbers, hyphens, periods, and underscores."
  }
  validation {
    condition     = (can(var.contact.email) && can(regex("^[\\@\\w\\/\\-\\.]{1,256}$", var.contact.email))) || var.contact == null
    error_message = "The email must be between 1 and 256 characters long, and only contain letters, numbers, hyphens, periods, and underscores."
  }
  validation {
    condition     = (can(var.contact.url) && can(regex("^(http|https)://[\\w\\/\\-\\.]{1,256}$", var.contact.url))) || var.contact == null
    error_message = "The url must be between 1 and 256 characters long, and only contain letters, numbers, hyphens, periods, and underscores."
  }

}

variable "revision_description" {
  type        = string
  description = "revision description"
  default     = null
  validation {
    condition     = (can(var.revision_description) && can(regex("^[\\ \\w\\/\\-\\.]{1,256}$", var.revision_description))) || var.revision_description == null
    error_message = "The revision_description must be between 1 and 256 characters long."
  }
}

variable "version_description" {
  type        = string
  description = "version description"
  default     = null
  validation {
    condition     = (can(var.version_description) && can(regex("^[\\ \\w\\/\\-\\.]{1,256}$", var.version_description))) || var.version_description == null
    error_message = "The version_description must be between 1 and 256 characters long."
  }
}

variable "source_api_id" {
  type        = string
  description = "source api id"
  default     = null
  validation {
    condition     = (can(var.source_api_id) && can(regex("^[\\w\\/\\-\\.;=]{1,256}$", var.source_api_id))) || var.source_api_id == null
    error_message = "The source_api_id must be between 1 and 256 characters long."
  }
}

variable "import_api" {
  type = object({
    content_format = optional(string, null)
    content_value  = optional(string, null)
    wsdl_selector = optional(object({
      service_name  = optional(string, null)
      endpoint_name = optional(string, null)
    }), null)
  })
  description = "import api"
  default     = null
  validation {
    condition     = can(regex("^(openapi|openapi+json|openapi+json-link|openapi-link|swagger-json|swagger-link-json|wsdl|wsdl-link|wadl-link-json|wadl-xml)$", var.import_api.content_format))
    error_message = "The spec_format must be one of the following: openapi, openapi+json, openapi+json-link, openapi-link, swagger-json, swagger-link-json, wadl-link-json, wadl-xml, wsdl, wsdl-link."
  }
}
