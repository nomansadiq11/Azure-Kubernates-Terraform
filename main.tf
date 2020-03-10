resource "azurerm_resource_group" "akscluster" {
  name     = "${var.resouce_group_name}"
  location = "${var.location}"

  tags = {
    environment = "${var.tag}"
  }
}


# Virtual Network PaymentSecVNET


resource "azurerm_network_security_group" "acceptanceTestSecurityGroup1" {
  name                = "acceptanceTestSecurityGroup1"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.akscluster.name}"
}

resource "azurerm_network_ddos_protection_plan" "ddospplan1" {
  name                = "ddospplan1"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.akscluster.name}"
}

resource "azurerm_virtual_network" "PaymentSecVNet_Dev" {
  name                = "PaymentSecVNet-Dev"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.akscluster.name}"
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
  resource_group_name = "${azurerm_resource_group.akscluster.name}"
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






# Start Kubernetes Cluster and ACR


resource "azurerm_container_registry" "acr" {
  name                = "acrforaks"
  resource_group_name = "${var.resouce_group_name}"
  location            = "${var.location}"
  sku                 = "basic"
  admin_enabled       = false
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "akscluster"
  resource_group_name = "${azurerm_resource_group.akscluster.name}"
  location            = "${var.location}"
  dns_prefix          = "akscluster"

  default_node_pool {
    name            = "default"
    node_count      = 3
    vm_size         = "Standard_D2s_v3"
    
  }

  service_principal {
    client_id     = "0000-0000-0000-000-0000"
    client_secret = "000000000000000"
  }



  tags = {
    Environment = "${var.tag}"
  }
}


resource "azurerm_role_definition" "acs-assign-acr-role" {
  name        = "assign-role-acr"
  scope       = "${azurerm_container_registry.acr.id}"
  description = "This is a custom role created via Terraform"

  permissions {
    actions     = ["*"]
    not_actions = []
  }

  assignable_scopes = [
    "${azurerm_container_registry.acr.id}", 
  ]
}



# AKS End


## End Kubernetes Cluster and ACR 