# Example - Single Azure Linux Virtual Machine

```
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

resource "azurerm_public_ip" "pip-lnx" {
  count               = 1
  name                = format("%s-%01d-%s","example-pip-linx",count.index+1,random_id.id.hex)
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags = {
    environment = "dev"
  }
}

module "linux_vm" {
  source                             = "../.."
  vm_count                           = 1
  vm_size                            = "Standard_B1s"
  vm_imagePublisher                  = "Canonical"
  vm_imageOffer                      = "ubuntu-24_04-lts"
  vm_imageSku                        = "server-gen1"
  vm_isWindows                       = false
  vm_public_ip_enabled               = true
  vm_publicIp_id                     = azurerm_public_ip.pip-lnx.*.id
  vm_disable_password_authentication = false
  vm_imageVersion                    = "latest"
  vm_imagePlanExist                  = "no"
  vm_authentication_adminUsername    = ***username***
  vm_authentication_adminPassword    = ***password***
  vm_prefix                          = "vmlnxtst${random_id.id.hex}"
  location                           = azurerm_resource_group.example.location
  resource_group_name                = azurerm_resource_group.example.name
  vm_enableAcceleratedNetworking     = false
  vm_subnet_id                       = azurerm_subnet.example.id
  vm_private_ip_address_allocation   = "Dynamic"
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
                                            dataDiskSizeGiB = 128
                                            dataDiskLun = 11
                                            dataDiskId = "log"
                                          },
                                        ]
  vm_tags = {
    environment = "dev"
  }
}
```