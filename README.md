# tf-azurerm-module_primitive-api_management_api

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![License: CC BY-NC-ND 4.0](https://img.shields.io/badge/License-CC_BY--NC--ND_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-nd/4.0/)

## Overview

This module provisions an Azure API Management API, exposing backend services at a certain path within the instance.

## Pre-Commit hooks

[.pre-commit-config.yaml](.pre-commit-config.yaml) file defines certain `pre-commit` hooks that are relevant to terraform, golang and common linting tasks. There are no custom hooks added.

`commitlint` hook enforces commit message in certain format. The commit contains the following structural elements, to communicate intent to the consumers of your commit messages:

- **fix**: a commit of the type `fix` patches a bug in your codebase (this correlates with PATCH in Semantic Versioning).
- **feat**: a commit of the type `feat` introduces a new feature to the codebase (this correlates with MINOR in Semantic Versioning).
- **BREAKING CHANGE**: a commit that has a footer `BREAKING CHANGE:`, or appends a `!` after the type/scope, introduces a breaking API change (correlating with MAJOR in Semantic Versioning). A BREAKING CHANGE can be part of commits of any type.
footers other than BREAKING CHANGE: <description> may be provided and follow a convention similar to git trailer format.
- **build**: a commit of the type `build` adds changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- **chore**: a commit of the type `chore` adds changes that don't modify src or test files
- **ci**: a commit of the type `ci` adds changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
- **docs**: a commit of the type `docs` adds documentation only changes
- **perf**: a commit of the type `perf` adds code change that improves performance
- **refactor**: a commit of the type `refactor` adds code change that neither fixes a bug nor adds a feature
- **revert**: a commit of the type `revert` reverts a previous commit
- **style**: a commit of the type `style` adds code changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- **test**: a commit of the type `test` adds missing tests or correcting existing tests

Base configuration used for this project is [commitlint-config-conventional (based on the Angular convention)](https://github.com/conventional-changelog/commitlint/tree/master/@commitlint/config-conventional#type-enum)

If you are a developer using vscode, [this](https://marketplace.visualstudio.com/items?itemName=joshbolduc.commitlint) plugin may be helpful.

`detect-secrets-hook` prevents new secrets from being introduced into the baseline. TODO: INSERT DOC LINK ABOUT HOOKS

In order for `pre-commit` hooks to work properly

- You need to have the pre-commit package manager installed. [Here](https://pre-commit.com/#install) are the installation instructions.
- `pre-commit` would install all the hooks when commit message is added by default except for `commitlint` hook. `commitlint` hook would need to be installed manually using the command below

```
pre-commit install --hook-type commit-msg
```

## To test the resource group module locally

1. For development/enhancements to this module locally, you'll need to install all of its components. This is controlled by the `configure` target in the project's [`Makefile`](./Makefile). Before you can run `configure`, familiarize yourself with the variables in the `Makefile` and ensure they're pointing to the right places.

```
make configure
```

This adds in several files and directories that are ignored by `git`. They expose many new Make targets.

2. _THIS STEP APPLIES ONLY TO MICROSOFT AZURE. IF YOU ARE USING A DIFFERENT PLATFORM PLEASE SKIP THIS STEP._ The first target you care about is `env`. This is the common interface for setting up environment variables. The values of the environment variables will be used to authenticate with cloud provider from local development workstation.

`make configure` command will bring down `azure_env.sh` file on local workstation. Devloper would need to modify this file, replace the environment variable values with relevant values.

These environment variables are used by `terratest` integration suit.

Service principle used for authentication(value of ARM_CLIENT_ID) should have below privileges on resource group within the subscription.

```
"Microsoft.Resources/subscriptions/resourceGroups/write"
"Microsoft.Resources/subscriptions/resourceGroups/read"
"Microsoft.Resources/subscriptions/resourceGroups/delete"
```

Then run this make target to set the environment variables on developer workstation.

```
make env
```

3. The first target you care about is `check`.

**Pre-requisites**
Before running this target it is important to ensure that, developer has created files mentioned below on local workstation under root directory of git repository that contains code for primitives/segments. Note that these files are `azure` specific. If primitive/segment under development uses any other cloud provider than azure, this section may not be relevant.

- A file named `provider.tf` with contents below

```
provider "azurerm" {
  features {}
}
```

- A file named `terraform.tfvars` which contains key value pair of variables used.

Note that since these files are added in `gitignore` they would not be checked in into primitive/segment's git repo.

After creating these files, for running tests associated with the primitive/segment, run

```
make check
```

If `make check` target is successful, developer is good to commit the code to primitive/segment's git repo.

`make check` target

- runs `terraform commands` to `lint`,`validate` and `plan` terraform code.
- runs `conftests`. `conftests` make sure `policy` checks are successful.
- runs `terratest`. This is integration test suit.
- runs `opa` tests
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.117 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.117.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_api_management_api.api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | name of the resource group where the APIM exists | `string` | `null` | no |
| <a name="input_api_management_name"></a> [api\_management\_name](#input\_api\_management\_name) | name of the APIM in which this api will de deployed | `string` | `null` | no |
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
| <a name="input_service_url"></a> [service\_url](#input\_service\_url) | the backend service URL for the API | `string` | `null` | no |
| <a name="input_soap_pass_through"></a> [soap\_pass\_through](#input\_soap\_pass\_through) | whether to pass through SOAP requests without transformation | `bool` | `null` | no |
| <a name="input_subscription_required"></a> [subscription\_required](#input\_subscription\_required) | whether the API requires a subscription key for access | `bool` | `true` | no |
| <a name="input_terms_of_service_url"></a> [terms\_of\_service\_url](#input\_terms\_of\_service\_url) | URL to the terms of service for the API | `string` | `null` | no |
| <a name="input_version_number"></a> [version\_number](#input\_version\_number) | the Version number of this API, if this API is versioned. | `string` | `null` | no |
| <a name="input_version_set_id"></a> [version\_set\_id](#input\_version\_set\_id) | the ID of the version set to which this API belongs | `string` | `null` | no |
| <a name="input_revision_description"></a> [revision\_description](#input\_revision\_description) | description of the API revision | `string` | `null` | no |
| <a name="input_version_description"></a> [version\_description](#input\_version\_description) | description of the API version | `string` | `null` | no |
| <a name="input_source_api_id"></a> [source\_api\_id](#input\_source\_api\_id) | the ID of the source API from which this API is derived | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_id"></a> [api\_id](#output\_api\_id) | The ID of the API Management API resource. |
| <a name="output_api_name"></a> [api\_name](#output\_api\_name) | The name of the API Management API resource. |
| <a name="output_revision"></a> [revision](#output\_revision) | The revision of the API Management API resource. |
| <a name="output_is_current"></a> [is\_current](#output\_is\_current) | Indicates whether the API Management API is the current revision. |
| <a name="output_version"></a> [version](#output\_version) | The version of the API Management API resource. |
| <a name="output_version_set_id"></a> [version\_set\_id](#output\_version\_set\_id) | The ID of the version set to which this API belongs. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
