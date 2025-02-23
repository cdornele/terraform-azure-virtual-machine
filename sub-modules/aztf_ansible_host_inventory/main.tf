#--------------------------------------------*--------------------------------------------
# Sub-Module:  Ansible Inventory
#--------------------------------------------*--------------------------------------------

resource "local_file" "ansible_inventory" {
  content = templatefile(format("%s/templates/ansible_inventory.tmpl", path.module),
    {
      vm_nodes       = var.vm_nodes
      username       = var.vm_username
      vm_pips_nodes  = var.vm_addressess
    }
  )
  filename = format("%s/hosts.yml", path.cwd)
}

# end
#--------------------------------------------*--------------------------------------------