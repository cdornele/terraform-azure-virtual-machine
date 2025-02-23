# terraform-az-virtual-machine

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | > 4.10.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | > 4.10.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vm_ansible_inventory"></a> [vm\_ansible\_inventory](#module\_vm\_ansible\_inventory) | ./sub-modules/aztf_ansible_host_inventory | n/a |
| <a name="module_vm_configure_devops"></a> [vm\_configure\_devops](#module\_vm\_configure\_devops) | ./sub-modules/aztf_extension_devops_access | n/a |
| <a name="module_vm_mssql_windows_extension"></a> [vm\_mssql\_windows\_extension](#module\_vm\_mssql\_windows\_extension) | ./sub-modules/aztf_extension_sql_server | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.vm-linux](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_managed_disk.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/managed_disk) | resource |
| [azurerm_marketplace_agreement.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/marketplace_agreement) | resource |
| [azurerm_network_interface.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_virtual_machine_data_disk_attachment.dataDisk-Linux-Attachment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment) | resource |
| [azurerm_virtual_machine_data_disk_attachment.dataDisk-Windows-Attachment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_data_disk_attachment) | resource |
| [azurerm_windows_virtual_machine.windows-vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ansible_host_file_enabled"></a> [ansible\_host\_file\_enabled](#input\_ansible\_host\_file\_enabled) | Enable ansible host file | `bool` | `false` | no |
| <a name="input_ansible_host_file_private_enabled"></a> [ansible\_host\_file\_private\_enabled](#input\_ansible\_host\_file\_private\_enabled) | Enable private ansible host file | `bool` | `true` | no |
| <a name="input_configure_devops_enabled"></a> [configure\_devops\_enabled](#input\_configure\_devops\_enabled) | Enable devops configuration | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | The location of the resources. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_sql_connectivity_update_password"></a> [sql\_connectivity\_update\_password](#input\_sql\_connectivity\_update\_password) | The password for the SQL connectivity update | `string` | `null` | no |
| <a name="input_sql_connectivity_update_username"></a> [sql\_connectivity\_update\_username](#input\_sql\_connectivity\_update\_username) | The username for the SQL connectivity update | `string` | `null` | no |
| <a name="input_vm_authentication_SshPublicKey"></a> [vm\_authentication\_SshPublicKey](#input\_vm\_authentication\_SshPublicKey) | The ssh public key for the virtual machine | `string` | `null` | no |
| <a name="input_vm_authentication_adminPassword"></a> [vm\_authentication\_adminPassword](#input\_vm\_authentication\_adminPassword) | The admin password for the virtual machine | `string` | `null` | no |
| <a name="input_vm_authentication_adminUsername"></a> [vm\_authentication\_adminUsername](#input\_vm\_authentication\_adminUsername) | The admin username for the virtual machine | `string` | n/a | yes |
| <a name="input_vm_bootDiagnosticsUri"></a> [vm\_bootDiagnosticsUri](#input\_vm\_bootDiagnosticsUri) | The URI of the storage account for boot diagnostics | `string` | n/a | yes |
| <a name="input_vm_count"></a> [vm\_count](#input\_vm\_count) | The number of virtual machines to create. | `number` | `1` | no |
| <a name="input_vm_custom_imageId"></a> [vm\_custom\_imageId](#input\_vm\_custom\_imageId) | The ID of the custom image to use for the virtual machine. | `string` | `null` | no |
| <a name="input_vm_dataDisks"></a> [vm\_dataDisks](#input\_vm\_dataDisks) | A list of data disks to attach to the virtual machine. | `list` | `[]` | no |
| <a name="input_vm_devops_ssh_key"></a> [vm\_devops\_ssh\_key](#input\_vm\_devops\_ssh\_key) | SSH key for DevOps access | `string` | `null` | no |
| <a name="input_vm_disable_password_authentication"></a> [vm\_disable\_password\_authentication](#input\_vm\_disable\_password\_authentication) | Disable password authentication | `bool` | `true` | no |
| <a name="input_vm_dns_servers"></a> [vm\_dns\_servers](#input\_vm\_dns\_servers) | The DNS servers for the virtual machine. | `list(string)` | `[]` | no |
| <a name="input_vm_enableAcceleratedNetworking"></a> [vm\_enableAcceleratedNetworking](#input\_vm\_enableAcceleratedNetworking) | Enable Accelerated Networking on the virtual machine. | `bool` | `false` | no |
| <a name="input_vm_enableIpForwarding"></a> [vm\_enableIpForwarding](#input\_vm\_enableIpForwarding) | Enable IP Forwarding on the virtual machine. | `bool` | `false` | no |
| <a name="input_vm_imageOffer"></a> [vm\_imageOffer](#input\_vm\_imageOffer) | The offer of the image to use for the virtual machine. | `string` | `null` | no |
| <a name="input_vm_imagePlanExist"></a> [vm\_imagePlanExist](#input\_vm\_imagePlanExist) | Does the image have a plan? | `string` | `"no"` | no |
| <a name="input_vm_imagePlanId"></a> [vm\_imagePlanId](#input\_vm\_imagePlanId) | The ID of the image plan | `string` | `null` | no |
| <a name="input_vm_imagePlanProductId"></a> [vm\_imagePlanProductId](#input\_vm\_imagePlanProductId) | The product ID of the image plan | `string` | `null` | no |
| <a name="input_vm_imagePlanPublisher"></a> [vm\_imagePlanPublisher](#input\_vm\_imagePlanPublisher) | The publisher of the image plan | `string` | `null` | no |
| <a name="input_vm_imagePublisher"></a> [vm\_imagePublisher](#input\_vm\_imagePublisher) | The publisher of the image to use for the virtual machine. | `string` | `null` | no |
| <a name="input_vm_imageSku"></a> [vm\_imageSku](#input\_vm\_imageSku) | The SKU of the image to use for the virtual machine. | `string` | `null` | no |
| <a name="input_vm_imageVersion"></a> [vm\_imageVersion](#input\_vm\_imageVersion) | The version of the image to use for the virtual machine. | `string` | `null` | no |
| <a name="input_vm_internalDnsNameLabel"></a> [vm\_internalDnsNameLabel](#input\_vm\_internalDnsNameLabel) | The internal DNS name label for the virtual machine. | `string` | `null` | no |
| <a name="input_vm_isWindows"></a> [vm\_isWindows](#input\_vm\_isWindows) | Is the virtual machine a windows machine | `bool` | n/a | yes |
| <a name="input_vm_osDisk_sizeGiB"></a> [vm\_osDisk\_sizeGiB](#input\_vm\_osDisk\_sizeGiB) | The size of the OS disk in GiB. | `number` | `128` | no |
| <a name="input_vm_osDisk_storageAccountType"></a> [vm\_osDisk\_storageAccountType](#input\_vm\_osDisk\_storageAccountType) | The storage account type for the OS disk. | `string` | `"Standard_LRS"` | no |
| <a name="input_vm_prefix"></a> [vm\_prefix](#input\_vm\_prefix) | The prefix for the virtual machine. | `string` | n/a | yes |
| <a name="input_vm_private_ip_address"></a> [vm\_private\_ip\_address](#input\_vm\_private\_ip\_address) | The private IP address for the virtual machine. | `list(string)` | `[]` | no |
| <a name="input_vm_private_ip_address_allocation"></a> [vm\_private\_ip\_address\_allocation](#input\_vm\_private\_ip\_address\_allocation) | The private IP address allocation method for the virtual machine. | `string` | `"Dynamic"` | no |
| <a name="input_vm_publicIp_id"></a> [vm\_publicIp\_id](#input\_vm\_publicIp\_id) | The ID of a Public IP Address to associate with the Network Interface. | `list(string)` | `[]` | no |
| <a name="input_vm_public_ip_enabled"></a> [vm\_public\_ip\_enabled](#input\_vm\_public\_ip\_enabled) | Enable public IP address for the virtual machine. | `bool` | `false` | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | The size of the virtual machine. | `string` | n/a | yes |
| <a name="input_vm_sql_enabled"></a> [vm\_sql\_enabled](#input\_vm\_sql\_enabled) | Enable SQL Server | `bool` | `false` | no |
| <a name="input_vm_sql_settings"></a> [vm\_sql\_settings](#input\_vm\_sql\_settings) | Settings for the SQL Server | `map` | `{}` | no |
| <a name="input_vm_subnet_id"></a> [vm\_subnet\_id](#input\_vm\_subnet\_id) | The ID of the subnet in which the virtual machine will be created. | `string` | n/a | yes |
| <a name="input_vm_tags"></a> [vm\_tags](#input\_vm\_tags) | Tags for the resources | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_linux_vm_info"></a> [linux\_vm\_info](#output\_linux\_vm\_info) | Linux VMs information |
| <a name="output_linux_vm_private_ips"></a> [linux\_vm\_private\_ips](#output\_linux\_vm\_private\_ips) | Public IP's map for the all linux Virtual Machines |
| <a name="output_linux_vm_public_ips"></a> [linux\_vm\_public\_ips](#output\_linux\_vm\_public\_ips) | Public IP's map for the all linux Virtual Machines |
| <a name="output_windows_vm_info"></a> [windows\_vm\_info](#output\_windows\_vm\_info) | Windows VMs information |
| <a name="output_windows_vm_private_ips"></a> [windows\_vm\_private\_ips](#output\_windows\_vm\_private\_ips) | Public IP's map for the all Windows Virtual Machines |
| <a name="output_windows_vm_public_ips"></a> [windows\_vm\_public\_ips](#output\_windows\_vm\_public\_ips) | Public IP's map for the all Windows Virtual Machines |
<!-- END_TF_DOCS -->