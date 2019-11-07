resource "azurerm_resource_group" "PaymentFacade" {
  name     = "PaymentFacade"
  location = "${var.location}"

  tags = {
    environment = "Development"
  }
}