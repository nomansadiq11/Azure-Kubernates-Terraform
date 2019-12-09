variable "location" {
  default = "West Europe"
}


variable "tag" {
  default = "Dev"
}


variable "resouce_group_name" {
  default = "akscluster"
}



resource "random_integer" "ri" {
  min = 10000
  max = 99999
}