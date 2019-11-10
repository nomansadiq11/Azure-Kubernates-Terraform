resource "azurerm_resource_group" "PaymentFacade" {
  name     = "PaymentFacade"
  location = "${var.location}"

  tags = {
    environment = "${var.tag}"
  }
}


# Virtual Network PaymentSecVNET


resource "azurerm_network_security_group" "acceptanceTestSecurityGroup1" {
  name                = "acceptanceTestSecurityGroup1"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.PaymentFacade.name}"
}

resource "azurerm_network_ddos_protection_plan" "ddospplan1" {
  name                = "ddospplan1"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.PaymentFacade.name}"
}

resource "azurerm_virtual_network" "PaymentSecVNet_Dev" {
  name                = "PaymentSecVNet-Dev"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.PaymentFacade.name}"
  address_space       = ["10.140.0.0/16"]
  dns_servers         = ["10.140.0.4", "10.140.0.5"]

  ddos_protection_plan {
    id     = "${azurerm_network_ddos_protection_plan.ddospplan1.id}"
    enable = true
  }

  subnet {
    name           = "subnet1"
    address_prefix = "10.140.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.140.2.0/24"
  }

  subnet {
    name           = "subnet3"
    address_prefix = "10.140.3.0/24"
    security_group = "${azurerm_network_security_group.acceptanceTestSecurityGroup1.id}"
  }

  tags = {
    environment = "${var.tag}"
  }
}

# Virtual Network PaymentIngeVNET

resource "azurerm_virtual_network" "PaymentIntegVNET_Dev" {
  name                = "PaymentIntegVNET-Dev"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.PaymentFacade.name}"
  address_space       = ["10.141.0.0/16"]
  dns_servers         = ["10.141.0.4", "10.141.0.5"]

  ddos_protection_plan {
    id     = "${azurerm_network_ddos_protection_plan.ddospplan1.id}"
    enable = true
  }

  subnet {
    name           = "subnet1"
    address_prefix = "10.141.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.141.2.0/24"
  }

  subnet {
    name           = "subnet3"
    address_prefix = "10.141.3.0/24"
    security_group = "${azurerm_network_security_group.acceptanceTestSecurityGroup1.id}"
  }

  tags = {
    environment = "${var.tag}"
  }
}