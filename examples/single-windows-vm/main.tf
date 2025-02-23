#--------------------------------------------*--------------------------------------------
# Example: Single Azure Windows VM
#--------------------------------------------*--------------------------------------------

resource "random_id" "id" {
  byte_length = 2
}
resource "azurerm_resource_group" "example" {
  name     = "example-rg-${random_id.id.hex}"
  location = "eastus"
  tags = {
    environment = "example"
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

module "windows_vm" {
  source                             = "../.."
  vm_count                           = 1
  vm_size                            = "Standard_B1s"
  vm_imagePublisher                  = "MicrosoftWindowsServer"
  vm_imageOffer                      = "WindowsServer"
  vm_imageSku                        = "2022-datacenter-azure-edition"
  vm_imageVersion                    = "latest"
  vm_isWindows                       = true
  vm_public_ip_enabled               = false
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
                                        }
                                       ]
  vm_tags                             = {
                                          environment = "test"
                                        }
}
# end
#--------------------------------------------*--------------------------------------------