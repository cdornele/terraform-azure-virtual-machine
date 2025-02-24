#--------------------------------------------*--------------------------------------------
# Module: Azure Virtual Machine - Outputs
#--------------------------------------------*--------------------------------------------

output "windows_vm_public_ips" {
  description = "Public IP's map for the all Windows Virtual Machines"
  value       = var.vm_isWindows && var.vm_public_ip_enabled ? azurerm_windows_virtual_machine.windows-vm.*.public_ip_address : null
}

output "windows_vm_private_ips" {
  description = "Public IP's map for the all Windows Virtual Machines"
  value       = var.vm_isWindows ? azurerm_windows_virtual_machine.windows-vm.*.private_ip_address : null
}

output "linux_vm_public_ips" {
  description = "Public IP's map for the all linux Virtual Machines"
  value       = !var.vm_isWindows && var.vm_public_ip_enabled ? azurerm_linux_virtual_machine.vm-linux.*.public_ip_address : null
}

output "linux_vm_private_ips" {
  description = "Public IP's map for the all linux Virtual Machines"
  value       = !var.vm_isWindows ? azurerm_linux_virtual_machine.vm-linux.*.private_ip_address : null
}

output "linux_vm_info" {
  description = "Linux VMs information"
  value       = {
    for vm in azurerm_linux_virtual_machine.vm-linux: vm.name => {
      id = vm.id
      location = vm.location
      private_ip = vm.private_ip_address
      public_ip = vm.public_ip_address
    }
  }
}

output "windows_vm_info" {
  description = "Windows VMs information"
  value       = {
    for vm in azurerm_windows_virtual_machine.windows-vm : vm.name => {
      id = vm.id
      location = vm.location
      private_ip = vm.private_ip_address
      public_ip = vm.public_ip_address
    }
  }
}

# end
#--------------------------------------------*--------------------------------------------