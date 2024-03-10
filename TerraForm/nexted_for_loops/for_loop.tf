locals {
  vmDisks = {
    for key, value in flatten([
      for vmKey, vm in var.VirtualMachine : [
        for diskKey, disk in vm.Disks.Data : {
          VmId   = vmKey
          DiskId = diskKey
          disk   = disk
          Lun    = 1 + index(keys(vm.Disks.Data), diskKey)
        }
      ]
      if contains(keys(vm.Disks), "Data")
    ]) : "${value.VmId}.${value.DiskId}" => value
  }
}

output "test" {
  value = local.vmDisks
}

variable "VirtualMachine" {
  default = {
    app = {
      Size = "Standard_B4ms"
      Disks = {
        OS = {
          Cache = "ReadWrite"
          Size  = 128
          Type  = "Premium_LRS"
        }
        Data = {
          Cache = "ReadWrite"
          Size  = 64
          Type  = "Premium_LRS"
        }
      }
      Image = {
        Publisher = "MicrosoftWindowsServer"
        Offer     = "WindowsServer"
        Sku       = "2022-datacenter-azure-edition"
        Version   = "latest"
      }
    }
  }
}