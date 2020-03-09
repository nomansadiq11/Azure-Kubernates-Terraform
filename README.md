# Azure Create Kubernetes cluster using Terraform

This repo having all the details how to create kubernetes cluster over Azure using terraform. 

## Advance Networking 

- We need to have Virtual Network and 1 Subnet to assign private network to containers
- We need to add agent_node_pool and specfic the details of subnet in that
- Plugin will be use azure

### Note:

Careful using default_node_pool vs agent_node_pool



## Variables

| Variable      | Value | Description |
| ------------- | ------------- | ------------- | 
| resouce_group_name       | akscluster   | resouce group name |
| tag | Dev/Stage  | Give tag name to resoues |
| location | West Europe  | Location where resouces will be created |



