variable "location" {
  default = "West Europe"
}


variable "tag" {
  default = "Dev"
}


variable "failover_location" {
  default = "North Europe"
}

variable "resouce_group_name" {
  default = "PaymentFacadeDev"
}



resource "random_integer" "ri" {
  min = 10000
  max = 99999
}