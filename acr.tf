
# resource "azurerm_container_registry" "acr" {
#   name                = "acspaymenttest"
#   resource_group_name = "${var.resouce_group_name}"
#   location            = "${var.location}"
#   sku                 = "basic"
#   admin_enabled       = false
# }



# resource "azurerm_role_definition" "acs-assign-acr-role" {
#   name        = "assign-role-acr"
#   scope       = "${azurerm_container_registry.acr.id}"
#   description = "This is a custom role created via Terraform"

#   permissions {
#     actions     = ["*"]
#     not_actions = []
#   }

#   assignable_scopes = [
#     "${azurerm_container_registry.acr.id}", 
#   ]
# }
