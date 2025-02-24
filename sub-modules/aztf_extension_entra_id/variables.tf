#--------------------------------------------*--------------------------------------------
# Module: Azure Windows Virtual Machine - Azure Active Directory Extension - Variables
#--------------------------------------------*--------------------------------------------

variable "vm_name" {
  type        = string
  description = "The name of the Windows Virtual Machine"
}

variable "vm_id" {
  type        = string
  description = "The ID of the Windows Virtual Machine"
}

variable "vm_tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}

# end
#--------------------------------------------*--------------------------------------------

