// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
variable "product_family" {
  description = <<EOF
    (Required) Name of the product family for which the resource is created.
    Example: org_name, department_name.
  EOF
  type        = string
  default     = "dso"
}

variable "product_service" {
  description = <<EOF
    (Required) Name of the product service for which the resource is created.
    For example, backend, frontend, middleware etc.
  EOF
  type        = string
  default     = "apim"
}

variable "environment" {
  description = "Environment in which the resource should be provisioned like dev, qa, prod etc."
  type        = string
  default     = "dev"
}

variable "environment_number" {
  description = "The environment count for the respective environment. Defaults to 000. Increments in value of 1"
  type        = string
  default     = "000"
}

variable "resource_number" {
  description = "The resource count for the respective resource. Defaults to 000. Increments in value of 1"
  type        = string
  default     = "000"
}

variable "region" {
  description = "Azure Region in which the infra needs to be provisioned"
  type        = string
  default     = "eastus"
}

variable "resource_names_map" {
  description = "A map of key to resource_name that will be used by tf-launch-module_library-resource_name to generate resource names"
  type = map(object(
    {
      name       = string
      max_length = optional(number, 60)
    }
  ))
  default = {
    resource_group = {
      name       = "rg"
      max_length = 50
    }
    api_management = {
      name       = "apim"
      max_length = 50
    }
  }
}

# APIM settings

variable "sku_name" {
  type        = string
  description = <<EOT
    String consisting of two parts separated by an underscore. The fist part is the name, valid values include: Developer,
    Basic, Standard and Premium. The second part is the capacity. Default is Consumption_0.
  EOT
  default     = "Consumption_0"
}

variable "publisher_name" {
  type        = string
  description = "The name of publisher/company."
  default     = "launchdso"
}

variable "publisher_email" {
  type        = string
  description = "The email of publisher/company."
  default     = "launchdso@nttdata.com"
}

variable "public_network_access_enabled" {
  description = <<EOT
    Should the API Management Service be accessible from the public internet?
    This option is applicable only to the Management plane, not the API gateway or Developer portal.
    It is required to be true on the creation.
    For sku=Developer/Premium and network_type=Internal, it must be true.
    It can only be set to false if there is at least one approve private endpoint connection.
  EOT
  type        = bool
  default     = true
}

variable "virtual_network_type" {
  type        = string
  description = <<EOT
    The type of virtual network you want to use, valid values include: None, External, Internal.
    External and Internal are only supported in the SKUs - Premium and Developer
  EOT
  default     = "None"
}

# API settings
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

variable "policy" {
  type = object({
    xml_content = optional(string)
    xml_link    = optional(string)
  })
  description = "Policy to apply to the API. Either xml_content or xml_link must be provided"
  default     = null

  validation {
    condition     = var.policy == null || try(one(compact([var.policy.xml_content, var.policy.xml_link])) != null, false)
    error_message = "One of xml_content or xml_link must be provided, but not both"
  }
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

# Common settings

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}
