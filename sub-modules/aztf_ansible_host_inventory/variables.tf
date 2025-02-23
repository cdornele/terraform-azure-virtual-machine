#--------------------------------------------*--------------------------------------------
# Sub-Module:  Ansible Inventory - Variables
#--------------------------------------------*--------------------------------------------

variable "vm_nodes" {
  description = "List of VM nodes"
  type = list(string)
}

variable "vm_username" {
  description = "Username for the VM"
  type = string
}

variable "vm_addressess" {
  description = "List of VM addresses"
  type = list(string)
}

# end
#--------------------------------------------*--------------------------------------------