#############################################################
# VIRTUAL MACHINE VARIABLES
#############################################################

variable "location" {
    description = "Specify region of Azure Virtual Machines."
    default = "West US"
}

variable "resource_group" {
    description = "Specify resource group of Azure Virtual Machines."  
    default = "Default"
}

variable "private_ip_addresses" {
    description = "Specify list if private_ips assigned to each VMs respectively"  
    type    = "list"
}

variable "nsg_id" {
    description = "Specify Network Security Group ID attached to the subnet." 
}

variable "availability_set_name" {
    description = "Name of the Availability Set."
    default = "default"
}

variable "subnet_id" {
    description = "Specify ID of the subnet."    
}

variable "nb_instances" {
    description = "Specify number of vms to be created."
    default = "1"
}

variable "ssh_key" {
    description = "Pass public SSH key for each VM" 
}

variable "os_image_publisher" {
    description = "VM image publisher"
    default = "credativ"
}

variable "os_image_offer" {
    description = "Specify list if private_ips assigned to each VMs respectively"
    default = "Debian"
} 

variable "os_image_sku" {
    description = "Specify OS image SKU."    
    default = 9
}

variable "os_image_version" {
    description = "Specify OS image Version."   
    default = "latest"
}

variable "vm_sizes" { 
    description = "Specify Virtual Machine sizes."    
    default = "Standard_DS1_v2"
}

variable "vm_managed_disk_type" { 
    description = "Specify VM OS Disk Type."    
    default = "Premium_LRS"
} 

variable "fault_domain_count" {
    description = "Specify Availability Set Fault Domain."    
    default = 2
}

variable "update_domain_count" {
    description = "Specify Availability Set Update Domain."    
    default = 2
} 

variable "host_names" {
    description = "Specify Host Name for each virtual machine starting with 0 respectively."
    type    = "list"
}

variable "backend_address_pools_ids" {
    description = "Backend Address Pool IDs used to attached each VM behind Azure Load Balancer."    
    type    = "list"
}