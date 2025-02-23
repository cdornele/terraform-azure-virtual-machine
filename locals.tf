#--------------------------------------------*--------------------------------------------
# Module: Azure Virtual Machine - Locals
#--------------------------------------------*--------------------------------------------

locals {
  dataDisks = flatten([
    for index in range(var.vm_count) : [
      for dataDisk in var.vm_dataDisks : {
        dataDiskName    = format("md_%s%02d_%s_%s", var.vm_prefix, index + 1, dataDisk.dataDiskId, dataDisk.dataDiskLun)
        dataDiskStgType = dataDisk.dataDiskStgType
        dataDiskSizeGiB = dataDisk.dataDiskSizeGiB
        dataDiskLun     = dataDisk.dataDiskLun
        dataDiskCache   = dataDisk.dataDiskCache
        dataDiskId      = dataDisk.dataDiskId
        fsType          = try(dataDisk.fsType, null)
      }
    ]
  ])
}
