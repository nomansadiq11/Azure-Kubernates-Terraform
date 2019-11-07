resource "azurerm_resource_group" "PaymentFacade" {
  name     = "PaymentFacade"
  location = "${var.location}"

  tags = {
    environment = "${var.tag}"
  }
}


# Virtual Network PaymentSecVNET


resource "azurerm_network_security_group" "test" {
  name                = "acceptanceTestSecurityGroup1"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.PaymentFacade.name}"
}

resource "azurerm_network_ddos_protection_plan" "test" {
  name                = "ddospplan1"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.PaymentFacade.name}"
}

resource "azurerm_virtual_network" "test" {
  name                = "PaymentSecVNet-Dev"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.PaymentFacade.name}"
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  ddos_protection_plan {
    id     = "${azurerm_ddos_protection_plan.test.id}"
    enable = true
  }

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
  }

  subnet {
    name           = "subnet3"
    address_prefix = "10.0.3.0/24"
    security_group = "${azurerm_network_security_group.test.id}"
  }

  tags = {
    environment = "${var.tag}"
  }
}