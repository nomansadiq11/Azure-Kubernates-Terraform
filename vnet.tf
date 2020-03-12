resource "azurerm_virtual_network" "aks-Dev" {
  name                = "aks-Dev"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.akscluster.name}"
  address_space       = ["10.140.0.0/16"]
  dns_servers         = ["10.140.0.4", "10.140.0.5"]


  tags = {
    environment = "${var.tag}"
  }


}