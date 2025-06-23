variable "resource_group_name" {
  type        = string
  description = "name of the resource group where the APIM exists"
  default     = null
  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{1,50}$", var.resource_group_name))
    error_message = "The resource group name can only contain alphanumeric characters and dashes and must be between 1 and 50 characters long."
  }
}

variable "api_management_name" {
  type        = string
  description = "name of the APIM in which this api will de deployed"
  default     = null
  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{1,50}$", var.api_management_name))
    error_message = "The APIM name can only contain alphanumeric characters and dashes and must be between 1 and 50 characters long."
  }
}

variable "name" {
  type        = string
  description = "name of the API"
  default     = null
  validation {
    condition     = can(regex("^[a-zA-Z0-9- ]{1,50}$", var.name))
    error_message = "The title can only contain alphanumeric characters, dashes, or spaces and must be between 1 and 50 characters long."
  }
}

variable "revision" {
  type        = string
  description = "revision of the API"
  default     = null
  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{1,50}$", var.revision))
    error_message = "The APIM name can only contain alphanumeric characters and dashes and must be between 1 and 50 characters long."
  }
}

variable "api_type" {
  type    = string
  default = "http"
  validation {
    condition     = can(regex("^(graphql|http|soap|websocket)$", var.api_type))
    error_message = "The API type must be either graphql, http, soap, or websocket."
  }
}

variable "display_name" {
  type        = string
  description = "display name of the API"
  default     = null
  validation {
    condition     = can(regex("^[a-zA-Z0-9- ]{1,50}$", var.display_name))
    error_message = "The display name can only contain alphanumeric characters, dashes, or spaces and must be between 1 and 50 characters long."
  }
}

variable "path" {
  type        = string
  description = "path of the API"
  default     = null
  validation {
    condition     = can(regex("^[a-zA-Z0-9\\-\\/]{1,50}$", var.path))
    error_message = "The path can only contain alphanumeric characters, dashes, or forward slashes and must be between 1 and 50 characters long."
  }
}

variable "protocols" {
  type        = list(string)
  description = "protocols supported by the API"
  default     = ["https"]
  validation {
    condition     = alltrue([for protocol in var.protocols : can(regex("^(http|https|ws|wss)$", protocol))])
    error_message = "Valid protocols are http, https, ws, and wss."
  }
}

variable "contact" {
  type = object({
    name  = optional(string, null)
    email = optional(string, null)
    url   = optional(string, null)
  })
  description = "contact information for the API"
  default     = null
}

variable "description" {
  type        = string
  description = "description of the API"
  default     = null
}

variable "import" {
  type = object({
    content_format = string
    content_value  = string
  })
  description = "options for importing an API"
  default     = null
  validation {
    condition     = var.import == null || can(regex("^(openapi|openapi\\+json|openapi\\+json-link|openapi-link|swagger-json|swagger-link-json|wadl-link-json|wadl-xml|wsdl|wsdl-link)$", var.import.content_format))
    error_message = "The content_format must be one of the following: openapi, openapi+json, openapi+json-link, openapi-link, swagger-json, swagger-link-json, wadl-link-json, wadl-xml, wsdl, wsdl-link."
  }
}

variable "license" {
  type = object({
    name = optional(string, null)
    url  = optional(string, null)
  })
  description = "license information for the API"
  default     = null
}

variable "service_url" {
  type        = string
  description = "the backend service URL for the API"
  default     = null
  validation {
    condition     = var.service_url == null || can(regex("^(http|https)://", var.service_url))
    error_message = "The service URL must start with http:// or https://."
  }
}

variable "soap_pass_through" {
  type        = bool
  description = "whether to pass through SOAP requests without transformation"
  default     = null
}

variable "subscription_required" {
  type        = bool
  description = "whether the API requires a subscription key for access"
  default     = true
}

variable "terms_of_service_url" {
  type        = string
  description = "URL to the terms of service for the API"
  default     = null
  validation {
    condition     = var.terms_of_service_url == null || can(regex("^(http|https)://", var.terms_of_service_url))
    error_message = "The terms of service URL must start with http:// or https://."
  }
}

variable "version_number" {
  type        = string
  description = "the Version number of this API, if this API is versioned."
  default     = null
}

variable "version_set_id" {
  type        = string
  description = "the ID of the version set to which this API belongs"
  default     = null
  validation {
    condition     = var.version_set_id == null || can(regex("^[a-zA-Z0-9-]{1,50}$", var.version_set_id))
    error_message = "The version set ID can only contain alphanumeric characters and dashes and must be between 1 and 50 characters long."
  }
}

variable "revision_description" {
  type        = string
  description = "description of the API revision"
  default     = null
}

variable "version_description" {
  type        = string
  description = "description of the API version"
  default     = null
}

variable "source_api_id" {
  type        = string
  description = "the ID of the source API from which this API is derived"
  default     = null
  validation {
    condition     = var.source_api_id == null || can(regex("^[a-zA-Z0-9-]{1,50}$", var.source_api_id))
    error_message = "The source API ID can only contain alphanumeric characters and dashes and must be between 1 and 50 characters long."
  }
}
