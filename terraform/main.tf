terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.31.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" 
}

variable "resource_group_name" {
  type        = string
  default = "xxx"
}

variable "location" {
  type        = string
  default     = "xxx"
}

variable "aks_cluster_name" {
  type        = string
  default     = "xxx"
  
}
