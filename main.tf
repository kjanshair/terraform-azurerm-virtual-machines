#############################################################
# VIRTUAL MACHINE RESOURCES
#############################################################

resource "azurerm_public_ip" "public_ip" {
    count               = "${var.nb_instances}"
    name                         = "${element(var.host_names, count.index)}"
    location                     = "${var.location}"
    resource_group_name          = "${var.resource_group}"
    public_ip_address_allocation = "static"
}

resource "azurerm_network_interface" "network_interface_card" {
    name                      = "${element(var.host_names, count.index)}NIC"
    location                  = "${var.location}"
    resource_group_name       = "${var.resource_group}"
    network_security_group_id = "${var.nsg_id}"
    count   =   "${var.nb_instances}"

    ip_configuration {
        name                          = "${element(var.host_names, count.index)}Configuration"
        subnet_id                     = "${var.subnet_id}"
        private_ip_address_allocation = "static"
        private_ip_address            = "${element(var.private_ip_addresses, count.index)}"
        public_ip_address_id          = "${element(azurerm_public_ip.public_ip.*.id, count.index)}"
        load_balancer_backend_address_pools_ids = ["${element(var.backend_address_pools_ids, count.index)}"]
    }
}

resource "azurerm_virtual_machine" "virtual_machine" {
    name                  = "${element(var.host_names, count.index)}"
    location              = "${var.location}"
    resource_group_name   = "${var.resource_group}"
    network_interface_ids = ["${element(azurerm_network_interface.network_interface_card.*.id, count.index)}"]
    vm_size               = "${var.vm_sizes}"
    availability_set_id = "${azurerm_availability_set.availability_set.id}"
    count   =   "${var.nb_instances}"
    
    storage_os_disk {
        name              = "${element(var.host_names, count.index)}OSDisk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "${var.vm_managed_disk_type}"
    }

    storage_image_reference {
        publisher = "${var.os_image_publisher}"
        offer     = "${var.os_image_offer}"
        sku       = "${var.os_image_sku}"
        version   = "${var.os_image_version}"
    }

    os_profile {
        computer_name  = "${element(var.host_names, count.index)}"
        admin_username = "${element(var.host_names, count.index)}"
    }

    os_profile_linux_config {
        disable_password_authentication = true
        ssh_keys {
            path     = "/home/${element(var.host_names, count.index)}/.ssh/authorized_keys"
            key_data = "${var.ssh_key}"
        }
    }
}

resource "azurerm_availability_set" "availability_set" {
  name                = "${var.availability_set_name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group}"

  managed             = true

  platform_fault_domain_count = "${var.fault_domain_count}"
  platform_update_domain_count = "${var.update_domain_count}"
}