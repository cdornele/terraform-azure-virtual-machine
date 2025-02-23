#--------------------------------------------*--------------------------------------------
# Example: Single Azure Windows VM with MSQL
#--------------------------------------------*--------------------------------------------

resource "random_id" "id" {
  byte_length = 2
}
resource "azurerm_resource_group" "example" {
  name     = "example-rg-${random_id.id.hex}"
  location = "eastus"
  tags = {
    environment = "example"
    project     = "terraform-samples-2020"
    owner       = "<EMAIL>"
    customer    = "<USERNAME>"
  }
}

resource "azurerm_virtual_network" "example" {
  name                = "example-vnet-${random_id.id.hex}"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  tags = {
    environment = "example"
  }
}

resource "azurerm_public_ip" "pip" {
  count               = 1
  name                = format("%s-%s","example-pip",random_id.id.hex)
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    environment = "dev"
  }
}

resource "azurerm_subnet" "example" {
  name                 = "example-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_storage_account" "example" {
  name                     = "stdiagexemple${random_id.id.hex}"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "example"
  }
}

resource "azurerm_network_security_group" "example_nsg" {
  name                = "example-nsg"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name


  security_rule {
    name                       = "my_home"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "46.136.223.21/32"
    destination_address_prefix = "*"
  }
}
resource "azurerm_subnet_network_security_group_association" "example_association" {
  subnet_id                 = azurerm_subnet.example.id
  network_security_group_id = azurerm_network_security_group.example_nsg.id
}

module "windows_vm" {
  source                             = "../.."
  vm_count                           = 1
  vm_size                            = "Standard_D2s_v5"
  vm_imagePublisher                  = "microsoftsqlserver"
  vm_imageOffer                      = "sql2022-ws2022"
  vm_imageSku                        = "standard-gen2"
  vm_imageVersion                    = "latest"
  vm_isWindows                       = true
  vm_isEntraJoined                   = false
  vm_public_ip_enabled               = true
  vm_publicIp_id                     = azurerm_public_ip.pip.*.id
  vm_disable_password_authentication = false
  vm_imagePlanExist                  = "no"
  vm_authentication_adminUsername    = "adminuser"
  vm_authentication_adminPassword    = "Password1234!"
  vm_prefix                          = "vmtest${random_id.id.hex}"
  location                           = azurerm_resource_group.example.location
  resource_group_name                = azurerm_resource_group.example.name
  vm_enableAcceleratedNetworking     = false
  vm_subnet_id                       = azurerm_subnet.example.id
  vm_private_ip_address_allocation   = "Static"
  vm_private_ip_address              = ["10.0.1.11"]
  vm_bootDiagnosticsUri              = azurerm_storage_account.example.primary_blob_endpoint
  vm_dataDisks                       = [
                                        {
                                          dataDiskStgType = "Standard_LRS"
                                          dataDiskCache = "None"
                                          dataDiskSizeGiB = 256
                                          dataDiskLun = 10
                                          dataDiskId = "data"
                                        },
                                      {
                                        dataDiskStgType = "Standard_LRS"
                                        dataDiskCache = "None"
                                        dataDiskSizeGiB = 256
                                        dataDiskLun = 11
                                        dataDiskId = "data"
                                      },
                                      {
                                        dataDiskStgType = "Standard_LRS"
                                        dataDiskCache = "None"
                                        dataDiskSizeGiB = 128
                                        dataDiskLun = 12
                                        dataDiskId = "log"
                                      },
                                      {
                                        dataDiskStgType = "Standard_LRS"
                                        dataDiskCache = "None"
                                        dataDiskSizeGiB = 128
                                        dataDiskLun = 13
                                        dataDiskId = "log"
                                      }
                                       ]
  vm_sql_enabled                      = true
  sql_connectivity_update_password    = "Password1234!"
  sql_connectivity_update_username    = "sqladmin"
  vm_sql_settings                     = {
                                          sql_vm_luns = [10,11,12,13]
                                          sql_license_type = "PAYG"
                                          sql_connectivity_type = "PRIVATE"
                                          sql_auto_patching = false
                                          storage_configuration_enabled = true
                                          sql_storage_replication_disk_type = "NEW"
                                          sql_storage_workload_type = "OLTP"
                                          sql_system_db_on_data_disk_enabled = true
                                          storage_configuration = {
                                            data_settings_enabled = true
                                            log_settings_enabled = true
                                            tmp_settings_enabled = false
                                            data_settings = {
                                              default_file_path = "F:Data"
                                              default_file_path_lun = [10,11]
                                            }
                                            log_settings = {
                                              default_log_path = "L:Logs"
                                              default_log_lun = [12,13]
                                            }
                                          }
                                        }
  vm_tags                             = {
                                          environment = "test"
                                        }
}
# end
#--------------------------------------------*--------------------------------------------