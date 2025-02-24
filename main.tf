#--------------------------------------------*--------------------------------------------
# Module: Azure Virtual Machine - Main
#--------------------------------------------*--------------------------------------------

# Marketplace Agreement

resource "azurerm_marketplace_agreement" "this" {
  count     = lower(var.vm_imagePlanExist) == "yes" ? 1 : 0
  publisher = var.vm_imagePlanId
  offer     = var.vm_imagePlanProductId
  plan      = var.vm_imagePlanId
}

# Network Interface

resource "azurerm_network_interface" "this" {
  count                             = var.vm_count
  name                              = format("nic_%s%02d",var.vm_prefix, (count.index + 1))
  location                          = var.location
  resource_group_name               = var.resource_group_name

  accelerated_networking_enabled    = var.vm_enableAcceleratedNetworking
  ip_forwarding_enabled             = var.vm_enableIpForwarding
  internal_dns_name_label           = var.vm_internalDnsNameLabel

  ip_configuration {
    name                            = "nic_ipconfig"
    subnet_id                       = var.vm_subnet_id
    private_ip_address_allocation   = var.vm_private_ip_address_allocation
    private_ip_address              = lower(var.vm_private_ip_address_allocation) == "static" ? coalesce(try(var.vm_private_ip_address[count.index])) : null
    public_ip_address_id            = var.vm_public_ip_enabled ? var.vm_publicIp_id[count.index] : null
  }

  dns_servers                       = var.vm_dns_servers

  tags                              = var.vm_tags

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Compute

# Windows VM

resource "azurerm_windows_virtual_machine" "windows-vm" {
  count               = var.vm_isWindows ? var.vm_count : 0
  name                = format("%s%02d",var.vm_prefix, (count.index + 1))
  location            = var.location
  resource_group_name = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.this[count.index].id]
  size                  = var.vm_size
  zone                  = var.availability_zones_enabled ? ((floor(count.index / length(var.vm_dataDisks))) % var.availability_zones_number) + 1 : null

  # Custom Image
  source_image_id       = var.vm_custom_imageId != null ? var.vm_custom_imageId : null

  # Image form Marketplace
  dynamic "source_image_reference" {
    for_each              = var.vm_custom_imageId != null ? [] : [1]
    content {
      publisher = var.vm_imagePublisher
      offer     = var.vm_imageOffer
      sku       = var.vm_imageSku
      version   = var.vm_imageVersion
    }
  }

  # Image with Marketplace Plan
  dynamic "plan" {
    for_each                        = var.vm_imagePlanExist == "yes" ? [1] : []
    content {
      name      = var.vm_imagePlanId
      product   = var.vm_imagePlanProductId
      publisher = var.vm_imagePlanPublisher
    }
  }
  os_disk {
    name                 = format("md_%s%02d_osdisk",var.vm_prefix, (count.index + 1))
    caching              = "ReadWrite"
    storage_account_type = var.vm_osDisk_storageAccountType
    disk_size_gb         = var.vm_osDisk_sizeGiB
  }

  computer_name         = format("%s%02d",var.vm_prefix, (count.index + 1))

  admin_username                  = var.vm_authentication_adminUsername
  admin_password                  = var.vm_authentication_adminPassword


  boot_diagnostics {
    storage_account_uri = var.vm_bootDiagnosticsUri
  }

  

  tags = var.vm_tags
  depends_on = [azurerm_marketplace_agreement.this,
    azurerm_network_interface.this]

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}


# Linux VM

resource "azurerm_linux_virtual_machine" "vm-linux" {
  count               = !var.vm_isWindows ? var.vm_count : 0
  name                = format("%s%02d",var.vm_prefix, (count.index + 1))
  location            = var.location
  resource_group_name = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.this[count.index].id]
  size                  = var.vm_size
  zone                  = var.availability_zones_enabled ? ((floor(count.index / length(var.vm_dataDisks))) % var.availability_zones_number) + 1 : null

  # Custom Image
  source_image_id       = var.vm_custom_imageId != null ? var.vm_custom_imageId : null

  # Image form Marketplace
  dynamic "source_image_reference" {
    for_each              = var.vm_custom_imageId != null ? [] : [1]
    content {
      publisher = var.vm_imagePublisher
      offer     = var.vm_imageOffer
      sku       = var.vm_imageSku
      version   = var.vm_imageVersion
    }
  }

  # Image with Marketplace Plan
  dynamic "plan" {
    for_each                        = var.vm_imagePlanExist == "yes" ? [1] : []
    content {
      name      = var.vm_imagePlanId
      product   = var.vm_imagePlanProductId
      publisher = var.vm_imagePlanPublisher
    }
  }
  os_disk {
    name                 = format("md_%s%02d_osdisk",var.vm_prefix, (count.index + 1))
    caching              = "ReadWrite"
    storage_account_type = var.vm_osDisk_storageAccountType
    disk_size_gb         = var.vm_osDisk_sizeGiB
  }

  computer_name         = format("%s%02d",var.vm_prefix, (count.index + 1))

  disable_password_authentication = var.vm_disable_password_authentication
  admin_username                  = var.vm_authentication_adminUsername
  admin_password                  = var.vm_disable_password_authentication ? null : var.vm_authentication_adminPassword

  dynamic "admin_ssh_key" {
    for_each =  var.vm_disable_password_authentication ? [1] : []
    content {
      username   = var.vm_authentication_adminUsername
      public_key =  var.vm_authentication_SshPublicKey
    }
  }

  boot_diagnostics {
    storage_account_uri = var.vm_bootDiagnosticsUri
  }
  tags = var.vm_tags
  depends_on = [azurerm_marketplace_agreement.this,
                azurerm_network_interface.this]

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Data

resource "azurerm_managed_disk" "this" {
  count = length(local.dataDisks) > 0 ? length(local.dataDisks) : 0

  name                 = local.dataDisks[count.index].dataDiskName
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = local.dataDisks[count.index].dataDiskStgType
  create_option        = "Empty"
  disk_size_gb         = local.dataDisks[count.index].dataDiskSizeGiB
  zone                 = var.availability_zones_enabled ? ((floor(count.index / length(var.vm_dataDisks))) % var.availability_zones_number) + 1 : null
  tags                 = var.vm_tags

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Disk attachment linux vms
resource "azurerm_virtual_machine_data_disk_attachment" "dataDisk-Linux-Attachment" {
  count              = (length(local.dataDisks) > 0) && !var.vm_isWindows ? length(local.dataDisks) : 0
  managed_disk_id    = azurerm_managed_disk.this[count.index].id
  virtual_machine_id = azurerm_linux_virtual_machine.vm-linux[floor(count.index / length(var.vm_dataDisks))].id
  lun                = local.dataDisks[count.index].dataDiskLun
  caching            = local.dataDisks[count.index].dataDiskCache
  depends_on = [azurerm_linux_virtual_machine.vm-linux,
    azurerm_managed_disk.this ]
}

# Disk attachment for windows vms
resource "azurerm_virtual_machine_data_disk_attachment" "dataDisk-Windows-Attachment" {
  count              = (length(local.dataDisks) > 0) && var.vm_isWindows ? length(local.dataDisks) : 0
  managed_disk_id    = azurerm_managed_disk.this[count.index].id
  virtual_machine_id = azurerm_windows_virtual_machine.windows-vm[floor(count.index / length(var.vm_dataDisks))].id
  lun                = local.dataDisks[count.index].dataDiskLun
  caching            = local.dataDisks[count.index].dataDiskCache
  depends_on = [azurerm_windows_virtual_machine.windows-vm,
    azurerm_managed_disk.this ]
}

# Devops Extensions

module "vm_ansible_inventory" {
  count   = var.ansible_host_file_enabled ? 1 : 0
  source = "./sub-modules/aztf_ansible_host_inventory"
  vm_nodes = azurerm_linux_virtual_machine.vm-linux.*.name
  vm_username = var.vm_authentication_adminUsername
  vm_addressess = var.ansible_host_file_private_enabled ? azurerm_linux_virtual_machine.vm-linux.*.private_ip_address : azurerm_linux_virtual_machine.vm-linux.*.public_ip_address
}

module "vm_configure_devops" {
  count = var.configure_devops_enabled && !var.vm_isWindows ? var.vm_count : 0
  source = "./sub-modules/aztf_extension_devops_access"
  vm_id = azurerm_linux_virtual_machine.vm-linux[count.index].id
  vms_username = var.vm_authentication_adminUsername
  devops_ssh_key = var.vm_devops_ssh_key
}

# MSSQL Extension

module "vm_mssql_windows_extension" {
  count = var.vm_isWindows && var.vm_sql_enabled ? var.vm_count : 0
  source = "./sub-modules/aztf_extension_sql_server"
  vm_id = azurerm_windows_virtual_machine.windows-vm[count.index].id
  vm_luns = try(var.vm_sql_settings.sql_vm_luns, [])
  sql_settings = var.vm_sql_settings
  sql_connectivity_update_password = var.sql_connectivity_update_password
  sql_connectivity_update_username = var.sql_connectivity_update_username
  depends_on = [
    azurerm_virtual_machine_data_disk_attachment.dataDisk-Windows-Attachment,
    azurerm_virtual_machine_data_disk_attachment.dataDisk-Linux-Attachment
  ]
}

# Entra ID Extension

module "entra_extension_windows" {
  source                    = "./sub-modules/aztf_extension_entra_id"
  count                     = var.vm_isWindows && var.vm_isEntraJoined && !var.vm_isIntuneEnrolled ? var.vm_count : 0
  vm_name                   = azurerm_windows_virtual_machine.windows-vm[count.index].name
  vm_id                     = azurerm_windows_virtual_machine.windows-vm[count.index].id
}

module "entra_extension_linux" {
  source                    = "./sub-modules/aztf_extension_entra_id"
  count                     = !var.vm_isWindows && var.vm_isEntraJoined ? var.vm_count : 0
  vm_name                   = azurerm_linux_virtual_machine.vm-linux[count.index].name
  vm_id                     = azurerm_linux_virtual_machine.vm-linux[count.index].id
}

module "entra_extension_windows_intune" {
  source                    = "./sub-modules/aztf_extension_entra_id_with_intune"
  count                     = var.vm_isWindows && var.vm_isIntuneEnrolled && !var.vm_isEntraJoined ? var.vm_count : 0
  vm_name                   = azurerm_windows_virtual_machine.windows-vm[count.index].name
  vm_id                     = azurerm_windows_virtual_machine.windows-vm[count.index].id
}
