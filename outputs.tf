#############################################################
# VIRTUAL MACHINE OUTPUTS
#############################################################

output "public_ip_addresses_name" {
    description = "Output public IP address for each Virtual Machine."  
    value = "${azurerm_public_ip.public_ip.*.ip_address}"
}

output "virtual_machine_name" {
    description = "Output name of each Virtual Machine."
    value = "${azurerm_virtual_machine.virtual_machine.*.name}"
}

output "availability_set_id" {
    description = "ID of the Availaiblity Set."    
    value = "${azurerm_availability_set.availability_set.id}"
}