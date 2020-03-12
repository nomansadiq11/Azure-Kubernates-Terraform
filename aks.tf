

# resource "azurerm_kubernetes_cluster" "aks_cluster" {
#   name                = "akscluster"
#   resource_group_name = "${azurerm_resource_group.akscluster.name}"
#   location            = "${var.location}"
#   dns_prefix          = "akscluster"

#   agent_pool_profile {
#         name            = "nodepool01"
#         count           = "3"
#         vm_size         = "Standard_DS2_v2"
#         os_type         = "Linux"
#         os_disk_size_gb = 30

#         # Required for advanced networking
#         vnet_subnet_id = "${azurerm_subnet.cluster.id}"
#     }

#   service_principal {
#     client_id     = "clientid"
#     client_secret = "secretkey"
#   }

#   addon_profile {
#         oms_agent {
#             enabled = true
#             log_analytics_workspace_id = "${azurerm_log_analytics_workspace.aks.id}"
#         }
#     }

# network_profile {
#         network_plugin = "azure"
#     }


#   tags = {
#     Environment = "${var.tag}"
#   }
# }
