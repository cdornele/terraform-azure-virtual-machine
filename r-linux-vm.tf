#--------------------------------------------*--------------------------------------------
# Module: Azure Virtual Machine - Linux VM
#--------------------------------------------*--------------------------------------------

# Linux VM


resource "azurerm_linux_virtual_machine" "vm-linux" {
  count                 = !var.vm_isWindows ? var.vm_count : 0
  name                  = format("%s%02d", var.vm_prefix, (count.index + 1))
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.this[count.index].id]
  size                  = var.vm_size

  # Secure Boot and vTPM
  secure_boot_enabled = var.vm_secure_boot_enabled
  vtpm_enabled        = var.vm_vtpm_enabled

  # Availability Zones
  zone = var.vm_availability_zones_enabled ? ((floor(count.index / length(var.vm_dataDisks))) % var.vm_availability_zones_number) + 1 : null


  # Custom Image
  source_image_id = var.vm_custom_imageId != null ? var.vm_custom_imageId : null

  # Image form Marketplace
  dynamic "source_image_reference" {
    for_each = var.vm_custom_imageId != null ? [] : [1]
    content {
      publisher = var.vm_imagePublisher
      offer     = var.vm_imageOffer
      sku       = var.vm_imageSku
      version   = var.vm_imageVersion
    }
  }

  # Image with Marketplace Plan
  dynamic "plan" {
    for_each = var.vm_imagePlanExist == "yes" ? [1] : []
    content {
      name      = var.vm_imagePlanId
      product   = var.vm_imagePlanProductId
      publisher = var.vm_imagePlanPublisherId
    }
  }
  os_disk {
    name                 = format("md_%s%02d_osdisk", var.vm_prefix, (count.index + 1))
    caching              = "ReadWrite"
    storage_account_type = var.vm_osDisk_storageAccountType
    disk_size_gb         = var.vm_osDisk_sizeGiB
  }

  computer_name = format("%s%02d", var.vm_prefix, (count.index + 1))

  disable_password_authentication = var.vm_disable_password_authentication
  admin_username                  = var.vm_authentication_adminUsername
  admin_password                  = var.vm_disable_password_authentication ? null : var.vm_authentication_adminPassword

  dynamic "admin_ssh_key" {
    for_each = var.vm_disable_password_authentication ? [1] : []
    content {
      username   = var.vm_authentication_adminUsername
      public_key = var.vm_authentication_SshPublicKey
    }
  }

  boot_diagnostics {
    storage_account_uri = var.vm_bootDiagnosticsUri
  }

  identity {
    type = "SystemAssigned"
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

# Disk attachment linux vms
resource "azurerm_virtual_machine_data_disk_attachment" "dataDisk-Linux-Attachment" {
  count              = (length(local.dataDisks) > 0) && !var.vm_isWindows ? length(local.dataDisks) : 0
  managed_disk_id    = azurerm_managed_disk.this[count.index].id
  virtual_machine_id = azurerm_linux_virtual_machine.vm-linux[floor(count.index / length(var.vm_dataDisks))].id
  lun                = local.dataDisks[count.index].dataDiskLun
  caching            = local.dataDisks[count.index].dataDiskCache
  depends_on = [azurerm_linux_virtual_machine.vm-linux,
  azurerm_managed_disk.this]
}

# end
#--------------------------------------------*--------------------------------------------