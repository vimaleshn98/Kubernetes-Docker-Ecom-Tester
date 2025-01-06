
resource "azurerm_linux_virtual_machine" "globo_vm" {
  for_each = toset(var.vmlist) # Create 3 VMs with unique names
  # for_each            = toset(["vm1", "vm2", "vm3"]) # Create 3 VMs with unique names
  name                = "${var.vm_name}-${each.key}" # VM names will be globo-vm1, globo-vm2, globo-vm3
  location            = var.azure_resource_group_location
  resource_group_name = var.azure_resource_group_name
  size                = var.vm_size
  admin_username      = var.admin_username
  # network_interface_ids = var.network_interface_ids
  network_interface_ids = [var.network_interface_ids[each.key == "vm1" ? 0 : each.key == "vm2" ? 1 : 2], ]
  os_disk {
    caching              = var.os_disk_variable.caching
    storage_account_type = var.os_disk_variable.storage_account_type
  }
  source_image_reference {
    publisher = var.source_image_reference_variable.publisher
    offer     = var.source_image_reference_variable.offer
    sku       = var.source_image_reference_variable.sku
    version   = var.source_image_reference_variable.version
  }

  admin_ssh_key {
    username   = var.ssh_adminuser
    public_key = file(var.ssh_key_path)
  }

  provisioner "remote-exec" {
    connection {
      host        = self.public_ip_address
      type        = "ssh"
      user        = var.ssh_adminuser
      private_key = file(var.ssh_private_key_path)
    }
    inline = var.command_to_run
  }
}
