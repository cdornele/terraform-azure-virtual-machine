#--------------------------------------------*--------------------------------------------
# Sub-Module:  Configure DevOps Access - Variables
#--------------------------------------------*--------------------------------------------

variable "vm_id" {
  description = "VM ID to associate the extension with"
  type = string
}

variable "devops_ssh_key" {
  description = "SSH key for DevOps access"
  type = string
}

variable "vms_username" {
  description = "Username for DevOps access"
  type = string
}

# end
#--------------------------------------------*--------------------------------------------