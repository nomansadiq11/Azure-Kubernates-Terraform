
terraform {
  backend "azurerm" {
    resource_group_name  = "ACS_EA_DEV_TEST"
    storage_account_name = "osnterraformstate"
    container_name       = "partnerstage"
    key                  = "paymentfacade.terraform.tfstate"
  }
}