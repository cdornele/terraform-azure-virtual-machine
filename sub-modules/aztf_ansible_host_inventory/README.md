<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [local_file.ansible_inventory](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vm_addressess"></a> [vm\_addressess](#input\_vm\_addressess) | List of VM addresses | `list(string)` | n/a | yes |
| <a name="input_vm_nodes"></a> [vm\_nodes](#input\_vm\_nodes) | List of VM nodes | `list(string)` | n/a | yes |
| <a name="input_vm_username"></a> [vm\_username](#input\_vm\_username) | Username for the VM | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->