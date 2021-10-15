#_______________________________________________________________________
#
# Terraform Required Parameters - Intersight Provider
# https://registry.terraform.io/providers/CiscoDevNet/intersight/latest
#_______________________________________________________________________

terraform {
  required_providers {
    intersight = {
      source  = "CiscoDevNet/intersight"
      version = "1.0.13"
    }
  }
}

#______________________________________________
#
# Intersight Provider Settings
#______________________________________________

provider "intersight" {
  apikey    = var.apikey
  endpoint  = local.endpoint
  secretkey = var.secretkey
}
