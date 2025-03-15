#--------------------------------------------*--------------------------------------------
# Module: Azure Virtual Machine - Variables
#--------------------------------------------*--------------------------------------------

variable "location" {
  description = "The location of the resources."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

# ansible inventory

variable "ansible_host_file_private_enabled" {
  description = "Enable private ansible host file"
  type        = bool
  default     = true
}

variable "ansible_host_file_enabled" {
  description = "Enable ansible host file"
  type        = bool
  default     = false
}

# devops config
variable "configure_devops_enabled" {
  description = "Enable devops configuration"
  type        = bool
  default     = false
}

variable "vm_devops_ssh_key" {
  description = "SSH key for DevOps access"
  type        = string
  default     = null
}

# vm

variable "vm_size" {
  description = "The size of the virtual machine."
  type        = string
}

variable "vm_count" {
  description = "The number of virtual machines to create."
  type        = number
  default     = 1
}

variable "vm_enableAcceleratedNetworking" {
  description = "Enable Accelerated Networking on the virtual machine."
  type        = bool
  default     = false
}

variable "vm_availability_zones_enabled" {
  description = "Enable availability zones for the virtual machine."
  type        = bool
  default     = false

}

variable "vm_secure_boot_enabled" {
  description = "Enable secure boot on the virtual machine."
  type        = bool
  default     = false
}

variable "vm_vtpm_enabled" {
  description = "Enable vTPM on the virtual machine."
  type        = bool
  default     = false
}

variable "vm_availability_zones_number" {
  description = "The number of availability zones for the virtual machine."
  type        = number
  default     = 0

}


variable "vm_enableIpForwarding" {
  description = "Enable IP Forwarding on the virtual machine."
  type        = bool
  default     = false
}

variable "vm_internalDnsNameLabel" {
  description = "The internal DNS name label for the virtual machine."
  type        = string
  default     = null
}

variable "vm_public_ip_enabled" {
  description = "Enable public IP address for the virtual machine."
  type        = bool
  default     = false
}

variable "vm_publicIp_id" {
  description = "The ID of a Public IP Address to associate with the Network Interface."
  type        = list(string)
  default     = []
}

variable "vm_subnet_id" {
  description = "The ID of the subnet in which the virtual machine will be created."
  type        = string
}

variable "vm_private_ip_address_allocation" {
  description = "The private IP address allocation method for the virtual machine."
  type        = string
  default     = "Dynamic"
}

variable "vm_private_ip_address" {
  description = "The private IP address for the virtual machine."
  type        = list(string)
  default     = []
}

variable "vm_dns_servers" {
  description = "The DNS servers for the virtual machine."
  type        = list(string)
  default     = []
}

variable "vm_osDisk_storageAccountType" {
  description = "The storage account type for the OS disk."
  type        = string
  default     = "Standard_LRS"
}

variable "vm_osDisk_sizeGiB" {
  description = "The size of the OS disk in GiB."
  type        = number
  default     = 128
}

variable "vm_dataDisks" {
  description = "A list of data disks to attach to the virtual machine."
  default     = []
}

variable "vm_prefix" {
  description = "The prefix for the virtual machine."
  type        = string
}

variable "vm_custom_imageId" {
  description = "The ID of the custom image to use for the virtual machine."
  type        = string
  default     = null
}

variable "vm_imagePublisher" {
  description = "The publisher of the image to use for the virtual machine."
  type        = string
  default     = null
}

variable "vm_imageOffer" {
  description = "The offer of the image to use for the virtual machine."
  type        = string
  default     = null
}

variable "vm_imageSku" {
  description = "The SKU of the image to use for the virtual machine."
  type        = string
  default     = null
}

variable "vm_imageVersion" {
  description = "The version of the image to use for the virtual machine."
  type        = string
  default     = null
}

variable "vm_imagePlanExist" {
  description = "Does the image have a plan?"
  type        = string
  default     = "no"
}

variable "vm_imagePlanId" {
  description = "The ID of the image plan"
  type        = string
  default     = null
}

variable "vm_imagePlanProductId" {
  description = "The product ID of the image plan"
  type        = string
  default     = null
}

variable "vm_imagePlanPublisherId" {
  description = "The publisher of the image plan"
  type        = string
  default     = null
}

variable "vm_disable_password_authentication" {
  description = "Disable password authentication"
  type        = bool
  default     = true
}

variable "vm_authentication_adminUsername" {
  description = "The admin username for the virtual machine"
  type        = string
}

variable "vm_authentication_adminPassword" {
  description = "The admin password for the virtual machine"
  type        = string
  default     = null
}

variable "vm_authentication_SshPublicKey" {
  description = "The ssh public key for the virtual machine"
  type        = string
  default     = null
}

variable "vm_isWindows" {
  description = "Is the virtual machine a windows machine"
  type        = bool
}

variable "vm_isEntraJoined" {
  description = "Is the virtual machine is Entra ID joined to domain"
  type        = bool
  default     = false
}

variable "vm_isIntuneEnrolled" {
  description = "Is the virtual machine is Intune enrolled"
  type        = bool
  default     = false
}

variable "vm_bootDiagnosticsUri" {
  description = "The URI of the storage account for boot diagnostics"
  type        = string
}

variable "sql_connectivity_update_username" {
  description = "The username for the SQL connectivity update"
  type        = string
  default     = null
}

variable "sql_connectivity_update_password" {
  description = "The password for the SQL connectivity update"
  type        = string
  default     = null
}

variable "vm_sql_settings" {
  description = "Settings for the SQL Server"
  default     = {}
}

variable "vm_sql_enabled" {
  description = "Enable SQL Server"
  type        = bool
  default     = false
}

variable "vm_tags" {
  description = "Tags for the resources"
}

# end
#--------------------------------------------*--------------------------------------------
