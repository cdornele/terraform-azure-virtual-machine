<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_machine_extension.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_devops_ssh_key"></a> [devops\_ssh\_key](#input\_devops\_ssh\_key) | SSH key for DevOps access | `string` | n/a | yes |
| <a name="input_vm_id"></a> [vm\_id](#input\_vm\_id) | VM ID to associate the extension with | `string` | n/a | yes |
| <a name="input_vms_username"></a> [vms\_username](#input\_vms\_username) | Username for DevOps access | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->