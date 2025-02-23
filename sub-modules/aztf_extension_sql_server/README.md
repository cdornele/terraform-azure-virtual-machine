<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_mssql_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_virtual_machine) | resource |
| [azurerm_virtual_machine_extension.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension) | resource |
| [local_file.this](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_sql_connectivity_update_password"></a> [sql\_connectivity\_update\_password](#input\_sql\_connectivity\_update\_password) | Update the SQL Server password | `any` | n/a | yes |
| <a name="input_sql_connectivity_update_username"></a> [sql\_connectivity\_update\_username](#input\_sql\_connectivity\_update\_username) | Update the SQL Server username | `any` | n/a | yes |
| <a name="input_sql_settings"></a> [sql\_settings](#input\_sql\_settings) | Settings for the SQL Server | `any` | n/a | yes |
| <a name="input_vm_id"></a> [vm\_id](#input\_vm\_id) | ID of the VM to install the extension on | `any` | n/a | yes |
| <a name="input_vm_luns"></a> [vm\_luns](#input\_vm\_luns) | LUNs to use for the data disks | `list` | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

<!-- Begin_Custom_DOC --->

## SQL Settings Block
| Name                                                                                                                                                                                                                                           | Description                                                                                                                                                                        | Type   | Default                      | Required |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------|------------------------------|----------|
| <a name="input_sql_license_type"></a> [sql\_license\_type](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_virtual_machine#sql_license_type-1)                                                           | The SQL Server license type. Possible values are AHUB (Azure Hybrid Benefit), DR (Disaster Recovery), and PAYG (Pay-As-You-Go). Changing this forces a new resource to be created. | string | "PAYG"                       | no       |
| <a name="inut_sql_connectivity_port"></a> [sql\_connectivity\_port>](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_virtual_machine#sql_connectivity_port-1)                                            | The SQL Server port                                                                                                                                                                | number | 1433                         | no       |
| <a name="input_sql_collation"></a> [sql\_collation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_virtual_machine#collation-1)                                                                         | Collation of the SQL Server                                                                                                                                                        | string | SQL_Latin1_General_CP1_CI_AS | no       |
| <a name="input_instant_file_initialization_enabled"></a> [instant\_file\_initialization\_enabled](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_virtual_machine#instant_file_initialization_enabled-1) | Specifies if Instant File Initialization is enabled for the SQL Server                                                                                                             | bool   | false                        | no       |
| <a name="input_lock_pages_in_memory_enabled"></a> [lock\_pages\_in\_memory\_enabled](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_virtual_machine#lock_pages_in_memory_enabled-1)                     | Specifies if Lock Pages in Memory is enabled for the SQL Server                                                                                                                    | bool   | false                        |          |
| <a name="input_max_dop"></a> [max\_dop](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_virtual_machine#max_dop-1)                                                                                                                                                                                                      | Maximum Degree of Parallelism of the SQL Server. Possible values are between 0 and 32767                                                                                           | number | 0                            |          |
| <a name="input_max_server_memory_mb"></a> [max\_server\_memory\_mb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_virtual_machine#max_server_memory_mb-1)                                                                                                                                                                          | Maximum amount memory that SQL Server Memory Manager can allocate to the SQL Server process                                                                                        | number | 2147483647                   | no       |
| <a name="input_min_server_memory_mb"></a> [min\_server\_memory\_mb](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_virtual_machine#min_server_memory_mb-1)                                                                                                                                                                          | Minimum amount memory that SQL Server Memory Manager can allocate to the SQL Server process                                                                                        | number | 0                            | no       |
| <a name="input_storage_configuration_enabled"></a> [storage\_configuration\_enabled]()                                                                                                                                                         | Define if storage configuration will be configured.                                                                                                                                | bool   | false | no       |
| <a name="input_sql_storage_replication_disk_type"></a> [sql\_storage\_replication\_disk\_type](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_virtual_machine#disk_type-1)                                                                                                                                               | The type of disk configuration to apply to the SQL Server. Valid values include NEW, EXTEND, or ADD                                                                                | string | "NEW" | yes      |
| <a name="input_sql_storage_workload_type"></a> [sql\_storage\_workload\_type](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_virtual_machine#storage_workload_type-1)                                                                                                                                                                | The type of storage workload. Valid values include GENERAL, OLTP, or DW                                                                                                            | string | "OLTP"| yes      |
| <a name="input_sql_system_db_on_data_disk_enabled"></a> [sql\_system\_db\_on\_data\_disk\_enabled](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_virtual_machine#system_db_on_data_disk_enabled-1)                                                                                                                                           | Specifies whether to set system databases (except tempDb) location to newly created data storage.                                                                                  | bool | false | no |

## SQL Settings Storage Configuration Block
| Name                                                                 | Description | Type   | Default                      | Required |
|----------------------------------------------------------------------|------|--------|------------------------------|----------|
| <a name="input_data_settings_enabled"></a> [data_settings_enabled]() | | bool | false | no |
| <a name="input_log_settings_enabled"></a> [log_settings_enabled]()   | | bool | false | no |
| <a name="input_tmp_settings_enabled"></a> [tmp_settings_enabled]()   | | bool | false | no |

<!-- End-Custom_DOC --->