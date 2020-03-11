resource "azurerm_resource_group" "akscluster" {
  name     = "${var.resouce_group_name}"
  location = "${var.location}"

  tags = {
    environment = "${var.tag}"
  }
}


# Virtual Network PaymentSecVNET


# resource "azurerm_network_security_group" "acceptanceTestSecurityGroup1" {
#   name                = "acceptanceTestSecurityGroup1"
#   location            = "${var.location}"
#   resource_group_name = "${azurerm_resource_group.akscluster.name}"
# }

# resource "azurerm_network_ddos_protection_plan" "ddospplan1" {
#   name                = "ddospplan1"
#   location            = "${var.location}"
#   resource_group_name = "${azurerm_resource_group.akscluster.name}"
# }

resource "azurerm_virtual_network" "PaymentSecVNet_Dev" {
  name                = "PaymentSecVNet-Dev"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.akscluster.name}"
  address_space       = ["10.140.0.0/16"]
  dns_servers         = ["10.140.0.4", "10.140.0.5"]


  tags = {
    environment = "${var.tag}"
  }


}
