#--------------------------------------------*--------------------------------------------
# Sub-Module: Azure MSSQL Virtual Machine - main
#--------------------------------------------*--------------------------------------------
resource "local_file" "this" {
  content = templatefile(format("%s/templates/initialiaze-disk.ps1.tmpl", path.module),
    {
      luns       = var.vm_luns
    }
  )
  filename = format("%s/mssql_extension_bootstrap.ps1", path.module)
}


resource "azurerm_virtual_machine_extension" "this" {
  depends_on = [
    local_file.this
  ]
  name                 = "vm-sql-extension-1"
  virtual_machine_id   = var.vm_id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
    {
          "commandToExecute": "powershell -command \"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${base64encode(local_file.this.content)}')) | Out-File -filepath mssql_extension_bootstrap.ps1\" && powershell -ExecutionPolicy Unrestricted -File mssql_extension_bootstrap.ps1"
    }
SETTINGS
}

resource "azurerm_mssql_virtual_machine" "this" {
  virtual_machine_id               = var.vm_id
  sql_license_type                 = lookup(var.sql_settings, "sql_license_type", "PAYG")
  sql_connectivity_port            = lookup(var.sql_settings, "sql_connectivity_port", "1433")
  sql_connectivity_type            = lookup(var.sql_settings, "sql_connectivity_type", "PRIVATE")
  sql_connectivity_update_password = var.sql_connectivity_update_password
  sql_connectivity_update_username = var.sql_connectivity_update_username

  dynamic "auto_patching" {
    for_each = lookup(var.sql_settings, "sql_auto_patching", false) == true ? [1] : []
    content {
      day_of_week                            = lookup(var.sql_settings, "sql_auto_patching_week_day", "Sunday")
      maintenance_window_duration_in_minutes = lookup(var.sql_settings, "sql_maintenance_windows_in_minutes", 60)
      maintenance_window_starting_hour       = lookup(var.sql_settings, "sql_maintenance_windows_in_hours", 2)
    }
  }

  sql_instance {
    collation                           = lookup(var.sql_settings, "sql_collation", "SQL_Latin1_General_CP1_CI_AS")
    instant_file_initialization_enabled = lookup(var.sql_settings, "instant_file_initialization_enabled", false)
    lock_pages_in_memory_enabled        = lookup(var.sql_settings, "lock_pages_in_memory_enabled", false)
    max_dop                             = lookup(var.sql_settings, "max_dop", 0)
    max_server_memory_mb                = lookup(var.sql_settings, "max_server_memory_mb", 2147483647)
    min_server_memory_mb                = lookup(var.sql_settings, "min_server_memory_mb", 0)
  }

  dynamic "storage_configuration" {
    for_each = lookup(var.sql_settings, "storage_configuration_enabled", false) == true ? [1] : []
    content {
      disk_type             = lookup(var.sql_settings, "sql_storage_replication_disk_type", "NEW")
      storage_workload_type = lookup(var.sql_settings, "sql_storage_workload_type", "OLTP")
      system_db_on_data_disk_enabled = lookup(var.sql_settings, "sql_system_db_on_data_disk_enabled", false )
      # The storage_settings block supports the following:
      dynamic "data_settings" {
        for_each = lookup(var.sql_settings.storage_configuration, "data_settings_enabled", false) == true ? [1] : []
        content {
          default_file_path = var.sql_settings.storage_configuration.data_settings.default_file_path
          luns              = var.sql_settings.storage_configuration.data_settings.default_file_path_lun
        }
      }

      dynamic "log_settings" {
        for_each = lookup(var.sql_settings.storage_configuration, "log_settings_enabled", false) == true ? [1] : []
        content {
          default_file_path = var.sql_settings.storage_configuration.log_settings.default_log_path
          luns              = var.sql_settings.storage_configuration.log_settings.default_log_lun
        }
      }

      dynamic "temp_db_settings" {
        for_each = lookup(var.sql_settings.storage_configuration, "tmp_settings_enabled", false) == true ? [1] : []
        content {
          default_file_path = var.sql_settings.storage_configuration.tmp_settings.default_tmp_path
          luns              = var.sql_settings.storage_configuration.tmp_settings.default_tmp_lun
          data_file_count   = lookup(var.sql_settings.storage_configuration.tmp_settings, "data_file_count", 8)
          data_file_size_mb = lookup(var.sql_settings.storage_configuration.tmp_settings, "data_file_size_mb", 8)
          data_file_growth_in_mb = lookup(var.sql_settings.storage_configuration.tmp_settings, "data_file_growth_in_mb", 64)
        }
      }
    }
  }
}


# end
#--------------------------------------------*--------------------------------------------
