#_______________________________________________________________
#
# App Hello Workspaces: {prefix_value}_{cluster_name}_app_hello
#_______________________________________________________________

module "app_hello_workspaces" {
  source = "terraform-cisco-modules/modules/tfe//modules/tfc_workspace"
  depends_on = [
    module.tfc_agent_pool
  ]
  for_each          = var.k8s_cluster_variables
  agent_pool        = module.tfc_agent_pool.tfc_agent_pool
  auto_apply        = true
  description       = "${var.name_prefix}_${each.value.cluster_name} - App Hello Workspace."
  execution_mode    = "agent"
  name              = "${var.name_prefix}_${each.value.cluster_name}_app_hello"
  terraform_version = var.terraform_version
  tfc_oath_token    = var.tfc_oath_token
  tfc_org_name      = var.tfc_organization
  vcs_repo          = var.vcs_repo
  working_directory = "app_hello"
}

output "app_hello_workspaces" {
  description = "Terraform Cloud App Hello Workspace ID(s)."
  value       = { for v in sort(keys(module.app_hello_workspaces)) : v => module.app_hello_workspaces[v] }
}

#_______________________________________________________________
#
# App Hello Variables: {prefix_value}_{cluster_name}_app_hello
#_______________________________________________________________

module "app_hello_variables" {
  source = "terraform-cisco-modules/modules/tfe//modules/tfc_variables"
  depends_on = [
    module.app_hello_workspaces
  ]
  for_each     = var.k8s_cluster_variables
  category     = "terraform"
  workspace_id = module.app_hello_workspaces["${each.value.cluster_name}"].workspace.id
  variable_list = {
    #---------------------------
    # Terraform Cloud Variables
    #---------------------------
    tfc_organization = {
      description = "Terraform Cloud Organization."
      key         = "tfc_organization"
      value       = var.tfc_organization
    },
    tfc_workspace_1 = {
      description = "global_vars Workspace."
      key         = "ws_global_vars"
      value       = "${var.prefix_value}_global_vars"
    },
    tfc_workspace_2 = {
      description = "Intersight Kubernetes Service kube_config Workspace."
      key         = "ws_kube"
      value       = "${var.prefix_value}_${each.value.cluster_name}_kube"
    }
  }
}
