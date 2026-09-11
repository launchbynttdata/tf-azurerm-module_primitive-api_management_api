# tf-azurerm-module_primitive-api_management_api

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

This module provisions an Azure API Management API, exposing backend services at a certain path within the instance.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.117, < 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_api.api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) | resource |
| [azurerm_api_management_api_operation.operations](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation) | resource |
| [azurerm_api_management_api_operation_policy.operation_policies](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_operation_policy) | resource |
| [azurerm_api_management_api_policy.api_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_management_name"></a> [api\_management\_name](#input\_api\_management\_name) | name of the APIM in which this api will de deployed | `string` | `null` | no |
| <a name="input_api_type"></a> [api\_type](#input\_api\_type) | n/a | `string` | `"http"` | no |
| <a name="input_contact"></a> [contact](#input\_contact) | contact information for the API | <pre>object({<br/>    name  = optional(string, null)<br/>    email = optional(string, null)<br/>    url   = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_description"></a> [description](#input\_description) | description of the API | `string` | `null` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | display name of the API | `string` | `null` | no |
| <a name="input_import"></a> [import](#input\_import) | options for importing an API | <pre>object({<br/>    content_format = string<br/>    content_value  = string<br/>  })</pre> | `null` | no |
| <a name="input_license"></a> [license](#input\_license) | license information for the API | <pre>object({<br/>    name = optional(string, null)<br/>    url  = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | name of the API | `string` | `null` | no |
| <a name="input_operation_policies"></a> [operation\_policies](#input\_operation\_policies) | List of operation policies to apply | <pre>list(object({<br/>    operation_id = string<br/>    xml_content  = optional(string)<br/>    xml_link     = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_operations"></a> [operations](#input\_operations) | List of operations to create for the API | <pre>list(object({<br/>    operation_id = string<br/>    display_name = string<br/>    method       = string<br/>    url_template = string<br/>    description  = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_path"></a> [path](#input\_path) | path of the API | `string` | `null` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | Policy to apply to the API. Either xml\_content or xml\_link must be provided | <pre>object({<br/>    xml_content = optional(string)<br/>    xml_link    = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_protocols"></a> [protocols](#input\_protocols) | protocols supported by the API | `list(string)` | <pre>[<br/>  "https"<br/>]</pre> | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | name of the resource group where the APIM exists | `string` | `null` | no |
| <a name="input_revision"></a> [revision](#input\_revision) | revision of the API | `string` | `null` | no |
| <a name="input_revision_description"></a> [revision\_description](#input\_revision\_description) | description of the API revision | `string` | `null` | no |
| <a name="input_service_url"></a> [service\_url](#input\_service\_url) | the backend service URL for the API | `string` | `null` | no |
| <a name="input_soap_pass_through"></a> [soap\_pass\_through](#input\_soap\_pass\_through) | whether to pass through SOAP requests without transformation | `bool` | `null` | no |
| <a name="input_source_api_id"></a> [source\_api\_id](#input\_source\_api\_id) | the ID of the source API from which this API is derived | `string` | `null` | no |
| <a name="input_subscription_required"></a> [subscription\_required](#input\_subscription\_required) | whether the API requires a subscription key for access | `bool` | `true` | no |
| <a name="input_terms_of_service_url"></a> [terms\_of\_service\_url](#input\_terms\_of\_service\_url) | URL to the terms of service for the API | `string` | `null` | no |
| <a name="input_version_description"></a> [version\_description](#input\_version\_description) | description of the API version | `string` | `null` | no |
| <a name="input_version_number"></a> [version\_number](#input\_version\_number) | the Version number of this API, if this API is versioned. | `string` | `null` | no |
| <a name="input_version_set_id"></a> [version\_set\_id](#input\_version\_set\_id) | the ID of the version set to which this API belongs | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_id"></a> [api\_id](#output\_api\_id) | The ID of the API Management API resource. |
| <a name="output_api_name"></a> [api\_name](#output\_api\_name) | The name of the API Management API resource. |
| <a name="output_api_path"></a> [api\_path](#output\_api\_path) | The path of the API Management API resource. |
| <a name="output_is_current"></a> [is\_current](#output\_is\_current) | Indicates whether the API Management API is the current revision. |
| <a name="output_revision"></a> [revision](#output\_revision) | The revision of the API Management API resource. |
| <a name="output_version"></a> [version](#output\_version) | The version of the API Management API resource. |
| <a name="output_version_set_id"></a> [version\_set\_id](#output\_version\_set\_id) | The ID of the version set to which this API belongs. |
<!-- END_TF_DOCS -->

## Module Development

### Pre-Requisites

The following commands should be available on your system:

- `asdf` or `mise`
- `make`
- `python3` (for pre-commit)

Additionally, your `git` user and email must be configured. Run the `make configure` command from the root of the repository to ensure that you meet these requirements.

### Pre-Commit hooks

The [.pre-commit-config.yaml](.pre-commit-config.yaml) file defines certain `pre-commit` hooks that are relevant to Terraform and Golang, as well as some common linting tasks. These will be configured for you when you run `make configure`.

### Local Validation

You should validate the changes you make to any module locally, prior to pushing your changes in a branch to GitHub.

1. Ensure that you have run `make configure` successfully.

2. Ensure you are signed into the appropriate cloud provider (e.g. AWS or Azure) for the module under test in your current console session.

3. Run the Terraform and Golang linters with the following command:

```
make lint
```

4. Once you have satisfied the linters, the following command will build example infrastructure in your configured cloud, run the tests, and then tear down the infrastructure it created:

```
make test
```

The pre-commit validations, as well as the `make lint` and `make test` targets, will all be performed in CI. Running these validations locally prior to opening a PR helps ensure a smooth review and merge process.

### Review & Merge Process

Once your change has been tested locally and your branch pushed up, open a new Pull Request for your branch to the default (main) branch of this repository.

The title of your Pull Request will determine the version bump for this change, and the title must be in [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/#specification) format in order to merge. A breaking change will trigger a major version bump, a feature will trigger a minor version bump, and all other types will trigger a patch version bump.

Ensure your CI workflows are passing; seek approval from teammates and address any feedback; seek any explicit approvals required by the CODEOWNERS file. You may merge the PR as soon as all requirements are met, and a new release and tag will be automatically created for you.

### Automatic Updates

The shared configuration and workflow files in this repository are largely managed through the [launch-terraform-skeleton](https://github.com/launchbynttdata/launch-terraform-skeleton) repository. Outside of perhaps the `.gitignore` to account for specific files being generated by certain Terraform modules (e.g. Lambda functions), there should not be much cause to update these files on a per-repo basis, and making changes to them individually is discouraged.

If desired, you can check for and run these updates locally in a branch if you have the `copier` tool installed. Some example commands are included below:

```
# Check for updates, optionally checking prerelease versions
copier check-update [--prereleases]

# Run an update, using default answers if there are any. We use tasks, which requires --trust to be set.
copier update --defaults --trust [--prereleases]

# Recopy from the source, and --overwrite all templated files in the process
copier recopy --defaults --trust --overwrite [--prereleases]
```

Automatic updates will run through a scheduled workflow, and if the post-update tests are successful, the Pull Request created will automatically merge. Conflicts in the update or failures to test may leave a Pull Request outstanding, which needs to be addressed by a Launch Engineer.
