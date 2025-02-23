#--------------------------------------------*--------------------------------------------
# Sub-Module: Azure MSSQL Virtual Machine - variables
#--------------------------------------------*--------------------------------------------

variable "vm_id" {
  description = "ID of the VM to install the extension on"
}

variable "vm_luns" {
  description = "LUNs to use for the data disks"
  default = []
}

variable "sql_settings" {
  description = "Settings for the SQL Server"
}

variable "sql_connectivity_update_password" {
  description = "Update the SQL Server password"
  sensitive = true
}

variable "sql_connectivity_update_username" {
  description = "Update the SQL Server username"
}


# end
#--------------------------------------------*--------------------------------------------
