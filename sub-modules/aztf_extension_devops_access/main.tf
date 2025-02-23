#--------------------------------------------*--------------------------------------------
# Sub-Module:  Configure DevOps Access
#--------------------------------------------*--------------------------------------------

resource "azurerm_virtual_machine_extension" "this" {
  name                 = "configure_devops_key"
  virtual_machine_id   = var.vm_id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.1"
  protected_settings = jsonencode(
    {
      "script" = base64encode(
        templatefile(
          format(
            "%s/templates/configure_devops.sh.tmpl", path.module),
          {
            local_user = var.vms_username
            key        = var.devops_ssh_key
          }
        )
      )
    }
  )
}