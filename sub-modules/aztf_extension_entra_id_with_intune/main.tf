#--------------------------------------------*--------------------------------------------
# Sub-Module:  Entra ID with Intune enrolled Extension
#--------------------------------------------*--------------------------------------------

resource "azurerm_virtual_machine_extension" "aad_extension_with_intune" {
  name                 =format("%s-%s", var.vm_name, "AADLoginForWindows")
  virtual_machine_id   = var.vm_id
  publisher            = "Microsoft.Azure.ActiveDirectory"
  type                 = "AADLoginForWindows"
  type_handler_version = "1.0"
  auto_upgrade_minor_version = true
  settings = <<-SETTINGS
    {
      "mdmId": "0000000a-0000-0000-c000-000000000000"
    }
  SETTINGS
  tags                 = var.vm_tags
}

# end
#--------------------------------------------*--------------------------------------------

