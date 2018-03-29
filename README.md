# Create Linux Azure Virtual Machine(s)

Use this module to create one or more Linux Virtual Machines within a managed availability set and behind a Azure Load Balancer.

User name and the host name for each virtual machine are the same and are case-sensitive.

## Simple Usage

```
resource "azurerm_subnet" "subnet" {
  name  = "default"
  address_prefix = "10.0.0.0/16"
  resource_group_name = "<resource-group-name>"
  virtual_network_name = "<vnet-name>"
  network_security_group_id = "${module.NetworkSecurityGroup.network_security_group_id}"
}

module "NetworkSecurityGroup" {
    source = "Azure/network-security-group/azurerm"
    resource_group_name        = "<resource-group-name>"
    location                   = "<nsg-location>"
    security_group_name        = "<nsg-name>"

    predefined_rules           = [
      {
        name                   = "SSH"
        priority               = "1001"
        source_address_prefix  = ["*"]
      },
      {
        name                   = "HTTP"
        priority               = "1002"
        source_address_prefix  = ["*"]
      }
    ]
}

module "VirtualMachine" {
    source = "kjanshair/virtual-machine/azurerm"
    nsg_id = "<network-security-group-id>"
    subnet_id = "${azurerm_subnet.subnet.id}"
    resource_group = "<resource-group-name>"
    location            = "<nsg-location>"
    count         =   2
    update_domain_count     =   2
    fault_domain_count      =   2
    availability_set_name   =   "<as-name>"
    host_names      =   ["host0", "host1", "host2"]
    private_ips      =   ["10.0.1.0", "10.0.2.0", "10.0.3.0"]
    backend_address_pools_ids         = ["<azure-load-balancer-backend-pool-id>"]
    ssh_key = "<your-sshkey>"
}
```

Note: This module creates Linux Virtual Machines with SSH based-authentication only.