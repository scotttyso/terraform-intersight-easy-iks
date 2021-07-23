terraform {
  experiments = [module_variable_optional_attrs]
}

#__________________________________________________________
#
# Required Variables
#__________________________________________________________

variable "tenant_name" {
  default     = "default"
  description = "Tenant Name for Workspace Creation in Terraform Cloud and IKS Cluster Naming."
  type        = string
}


#______________________________________________
#
# DNS Variables
#______________________________________________

variable "domain_name" {
  default     = "example.com"
  description = "Domain Name for Kubernetes Sysconfig Policy."
  type        = string
}

variable "dns_servers_v4" {
  default     = ["198.18.0.100", "198.18.0.101"]
  description = "DNS Servers for Kubernetes Sysconfig Policy."
  type        = list(string)
}


#______________________________________________
#
# Time Variables
#______________________________________________

variable "ntp_servers" {
  default     = []
  description = "NTP Servers for Kubernetes Sysconfig Policy."
  type        = list(string)
}

variable "timezone" {
  default     = "Etc/GMT"
  description = "Timezone for Deployment.  For a List of supported timezones see the following URL.\r\n https://github.com/terraform-cisco-modules/terraform-intersight-imm/blob/master/modules/policies_ntp/README.md."
  type        = string
}

#______________________________________________
#
# IP Pools
#______________________________________________

variable "ip_pools" {
  default = {
    default = {
      name    = "{tenant_name}_ip_pool"
      gateway = "198.18.0.1/24"
      from    = 20
      size    = 30
    }
  }
  type = map(object(
    {
      name    = optional(string)
      gateway = optional(string)
      from    = optional(number)
      size    = optional(number)
    }
  ))
}


#______________________________________________
#
# IP Pools
#______________________________________________

variable "k8s_runtime_policy" {
  default = (
    {
      proxy_http_hostname     = ""
      proxy_http_port         = 8080
      proxy_http_protocol     = ""
      proxy_http_username     = ""
      proxy_https_hostname    = ""
      proxy_https_port        = 8443
      proxy_https_protocol    = ""
      proxy_https_username    = ""
      k8s_runtime_policy_name = ""
    }
  )
  type = object(
    {
      proxy_http_hostname  = optional(string)
      proxy_http_port      = optional(number)
      proxy_http_protocol  = optional(string)
      proxy_http_username  = optional(string)
      proxy_https_hostname = optional(string)
      proxy_https_port     = optional(number)
      proxy_https_protocol = optional(string)
      proxy_https_username = optional(string)
      runtime_policy_name  = optional(string)
    }
  )
}


#__________________________________________________________
#
# Terraform Cloud Workspace: {tenant_name}
#__________________________________________________________

module "tenant_workspace" {
  source = "terraform-cisco-modules/modules/tfe//modules/tfc_workspace"
  depends_on = [
    module.tfc_agent_pool
  ]
  auto_apply          = true
  description         = "${var.tenant_name} Workspace."
  global_remote_state = true
  name                = var.tenant_name
  terraform_version   = var.terraform_version
  tfc_oath_token      = var.tfc_oath_token
  tfc_org_name        = var.tfc_organization
  vcs_repo            = var.vcs_repo
  working_directory   = "tenant"
}

output "tenant_workspace" {
  description = "Terraform Cloud Tenant Workspace ID."
  value       = module.tenant_workspace
}

#__________________________________________________________
#
# Terraform Cloud Workspace Variables: global_vars
#__________________________________________________________

module "tenant_variables" {
  source = "../../../terraform-tfe-modules/modules/tfc_variables"
  depends_on = [
    module.tenant_workspace
  ]
  category     = "terraform"
  workspace_id = module.tenant_workspace.workspace.id
  variable_list = {
    intersight_org = {
      description = "Intersight Organization."
      key         = "organization"
      value       = var.organization
    },
    domain_name = {
      description = "Domain Name."
      key         = "domain_name"
      value       = var.domain_name
    },
    dns_servers = {
      description = "DNS Servers."
      hcl         = true
      key         = "dns_servers_v4"
      value       = "[${join(",", [for s in var.dns_servers_v4 : format("%q", s)])}]"
      # value       = "[\"${join("\",\"", var.dns_servers_v4)}\"]"
    },
    ntp_servers = {
      description = "NTP Servers."
      hcl         = true
      key         = "ntp_servers"
      value       = "[${join(",", [for s in var.ntp_servers : format("%q", s)])}]"
    },
    ip_pools = {
      description = "${var.tenant_name} IP Pools."
      hcl         = true
      key         = "ip_pools"
      # value       = "${var.ip_pools}"
      # value = replace(replace(jsonencode(var.ip_pools), "\"", "\""), ":", "=")
      # value = replace(replace(jsonencode(var.ip_pools), "\"", ""), ":", "=")
      value       = "${jsonencode(var.ip_pools)}"
    },
  }
}
