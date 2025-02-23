<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 4.10.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 4.10.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_machine_extension.aad_extension_with_intune](https://registry.terraform.io/providers/hashicorp/azurerm/4.10.0/docs/resources/virtual_machine_extension) | resource |
| [azurerm_virtual_machine_extension.aad_extension_without_intune](https://registry.terraform.io/providers/hashicorp/azurerm/4.10.0/docs/resources/virtual_machine_extension) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_windows_vm_id"></a> [windows\_vm\_id](#input\_windows\_vm\_id) | The ID of the Windows Virtual Machine | `string` | n/a | yes |
| <a name="input_windows_vm_intune_enabled"></a> [windows\_vm\_intune\_enabled](#input\_windows\_vm\_intune\_enabled) | Enable Intune for the Windows Virtual Machine | `bool` | `false` | no |
| <a name="input_windows_vm_name"></a> [windows\_vm\_name](#input\_windows\_vm\_name) | The name of the Windows Virtual Machine | `string` | n/a | yes |
| <a name="input_windows_vm_tags"></a> [windows\_vm\_tags](#input\_windows\_vm\_tags) | The tags for the Windows Virtual Machine | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->