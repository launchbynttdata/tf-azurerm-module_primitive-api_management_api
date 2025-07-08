# complete

Please set a provider block with the following, to avoid soft-deletes of the APIM instance which can cause problems with the tests
```
provider "azurerm" {
  features {
    api_management {
      purge_soft_delete_on_destroy = true
      recover_soft_deleted         = true
    }
  }
}
```


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.117 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_resource_names"></a> [resource\_names](#module\_resource\_names) | terraform.registry.launch.nttdata.com/module_library/resource_name/launch | ~> 2.0 |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | terraform.registry.launch.nttdata.com/module_primitive/resource_group/azurerm | ~> 1.0 |
| <a name="module_apim"></a> [apim](#module\_apim) | terraform.registry.launch.nttdata.com/module_primitive/api_management/azurerm | ~> 1.0 |
| <a name="module_apim_api"></a> [apim\_api](#module\_apim\_api) | ../.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_product_family"></a> [product\_family](#input\_product\_family) | (Required) Name of the product family for which the resource is created.<br>    Example: org\_name, department\_name. | `string` | `"dso"` | no |
| <a name="input_product_service"></a> [product\_service](#input\_product\_service) | (Required) Name of the product service for which the resource is created.<br>    For example, backend, frontend, middleware etc. | `string` | `"apim"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment in which the resource should be provisioned like dev, qa, prod etc. | `string` | `"dev"` | no |
| <a name="input_environment_number"></a> [environment\_number](#input\_environment\_number) | The environment count for the respective environment. Defaults to 000. Increments in value of 1 | `string` | `"000"` | no |
| <a name="input_resource_number"></a> [resource\_number](#input\_resource\_number) | The resource count for the respective resource. Defaults to 000. Increments in value of 1 | `string` | `"000"` | no |
| <a name="input_region"></a> [region](#input\_region) | Azure Region in which the infra needs to be provisioned | `string` | `"eastus"` | no |
| <a name="input_resource_names_map"></a> [resource\_names\_map](#input\_resource\_names\_map) | A map of key to resource\_name that will be used by tf-launch-module\_library-resource\_name to generate resource names | <pre>map(object(<br>    {<br>      name       = string<br>      max_length = optional(number, 60)<br>    }<br>  ))</pre> | <pre>{<br>  "api_management": {<br>    "max_length": 50,<br>    "name": "apim"<br>  },<br>  "resource_group": {<br>    "max_length": 50,<br>    "name": "rg"<br>  }<br>}</pre> | no |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | String consisting of two parts separated by an underscore. The fist part is the name, valid values include: Developer,<br>    Basic, Standard and Premium. The second part is the capacity. Default is Consumption\_0. | `string` | `"Consumption_0"` | no |
| <a name="input_publisher_name"></a> [publisher\_name](#input\_publisher\_name) | The name of publisher/company. | `string` | `"launchdso"` | no |
| <a name="input_publisher_email"></a> [publisher\_email](#input\_publisher\_email) | The email of publisher/company. | `string` | `"launchdso@nttdata.com"` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Should the API Management Service be accessible from the public internet?<br>    This option is applicable only to the Management plane, not the API gateway or Developer portal.<br>    It is required to be true on the creation.<br>    For sku=Developer/Premium and network\_type=Internal, it must be true.<br>    It can only be set to false if there is at least one approve private endpoint connection. | `bool` | `true` | no |
| <a name="input_virtual_network_type"></a> [virtual\_network\_type](#input\_virtual\_network\_type) | The type of virtual network you want to use, valid values include: None, External, Internal.<br>    External and Internal are only supported in the SKUs - Premium and Developer | `string` | `"None"` | no |
| <a name="input_name"></a> [name](#input\_name) | name of the API | `string` | `null` | no |
| <a name="input_revision"></a> [revision](#input\_revision) | revision of the API | `string` | `null` | no |
| <a name="input_api_type"></a> [api\_type](#input\_api\_type) | n/a | `string` | `"http"` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | display name of the API | `string` | `null` | no |
| <a name="input_path"></a> [path](#input\_path) | path of the API | `string` | `null` | no |
| <a name="input_protocols"></a> [protocols](#input\_protocols) | protocols supported by the API | `list(string)` | <pre>[<br>  "https"<br>]</pre> | no |
| <a name="input_contact"></a> [contact](#input\_contact) | contact information for the API | <pre>object({<br>    name  = optional(string, null)<br>    email = optional(string, null)<br>    url   = optional(string, null)<br>  })</pre> | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | description of the API | `string` | `null` | no |
| <a name="input_import"></a> [import](#input\_import) | options for importing an API | <pre>object({<br>    content_format = string<br>    content_value  = string<br>  })</pre> | `null` | no |
| <a name="input_license"></a> [license](#input\_license) | license information for the API | <pre>object({<br>    name = optional(string, null)<br>    url  = optional(string, null)<br>  })</pre> | `null` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | Policy to apply to the API. Either xml\_content or xml\_link must be provided | <pre>object({<br>    xml_content = optional(string)<br>    xml_link    = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_service_url"></a> [service\_url](#input\_service\_url) | the backend service URL for the API | `string` | `null` | no |
| <a name="input_soap_pass_through"></a> [soap\_pass\_through](#input\_soap\_pass\_through) | whether to pass through SOAP requests without transformation | `bool` | `null` | no |
| <a name="input_subscription_required"></a> [subscription\_required](#input\_subscription\_required) | whether the API requires a subscription key for access | `bool` | `true` | no |
| <a name="input_terms_of_service_url"></a> [terms\_of\_service\_url](#input\_terms\_of\_service\_url) | URL to the terms of service for the API | `string` | `null` | no |
| <a name="input_version_number"></a> [version\_number](#input\_version\_number) | the Version number of this API, if this API is versioned. | `string` | `null` | no |
| <a name="input_version_set_id"></a> [version\_set\_id](#input\_version\_set\_id) | the ID of the version set to which this API belongs | `string` | `null` | no |
| <a name="input_revision_description"></a> [revision\_description](#input\_revision\_description) | description of the API revision | `string` | `null` | no |
| <a name="input_version_description"></a> [version\_description](#input\_version\_description) | description of the API version | `string` | `null` | no |
| <a name="input_source_api_id"></a> [source\_api\_id](#input\_source\_api\_id) | the ID of the source API from which this API is derived | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_management_name"></a> [api\_management\_name](#output\_api\_management\_name) | The name of the API Management Service |
| <a name="output_api_management_id"></a> [api\_management\_id](#output\_api\_management\_id) | The ID of the API Management Service |
| <a name="output_api_management_gateway_url"></a> [api\_management\_gateway\_url](#output\_api\_management\_gateway\_url) | The URL of the Gateway for the API Management Service |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | n/a |
| <a name="output_api_id"></a> [api\_id](#output\_api\_id) | n/a |
| <a name="output_api_name"></a> [api\_name](#output\_api\_name) | n/a |
| <a name="output_api_path"></a> [api\_path](#output\_api\_path) | n/a |
| <a name="output_is_current"></a> [is\_current](#output\_is\_current) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
