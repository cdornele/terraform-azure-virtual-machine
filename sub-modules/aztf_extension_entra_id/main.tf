#--------------------------------------------*--------------------------------------------
# Sub-Module: Entra ID Extension
#--------------------------------------------*--------------------------------------------

resource "azurerm_virtual_machine_extension" "aad_extension_without_intune" {
  name                 = format("%s-%s", var.vm_name, "AADLoginForWindows")
  virtual_machine_id   = var.vm_id
  publisher            = "Microsoft.Azure.ActiveDirectory"
  type                 = "AADLoginForWindows"
  type_handler_version = "1.0"
  auto_upgrade_minor_version = true
}


# end
#--------------------------------------------*--------------------------------------------

