<#
.SYNOPSIS
    Disclaimer for PowerShell Scripts

.DESCRIPTION


.NOTICE


#>


Get-Disk | Where LOCATION -match 'LUN 10' | Initialize-Disk -PartitionStyle MBR -PassThru


Get-Disk | Where LOCATION -match 'LUN 11' | Initialize-Disk -PartitionStyle MBR -PassThru


Get-Disk | Where LOCATION -match 'LUN 12' | Initialize-Disk -PartitionStyle MBR -PassThru


Get-Disk | Where LOCATION -match 'LUN 13' | Initialize-Disk -PartitionStyle MBR -PassThru

