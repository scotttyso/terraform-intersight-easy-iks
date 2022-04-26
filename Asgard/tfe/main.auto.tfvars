#__________________________________________________________
#
# Terraform Cloud Variables
#__________________________________________________________

agent_pools       = ["Richfield_Agents"]
terraform_version = "1.1.8"
tfc_organization  = "Cisco-Richfield-Lab"
vcs_repo          = "scotttyso/terraform-intersight-easy-iks"
/*
  We highly recommend that for the terraform_cloud_token you use an environment variable for input:
  - export TF_VAR_terraform_cloud_token="abcdefghijklmnopqrstuvwxyz.0123456789"
  If you still want to move forward with it in this file, uncomment the line below, and input your value.
*/
# terraform_cloud_token = "value"
/*
  We highly recommend that for the tfc_oath_token you use an environment variable for input; Like:
  - export TF_VAR_tfc_oath_token="abcdefghijklmnopqrstuvwxyz.0123456789"
  If you still want to move forward with it in this file, uncomment the line below, and input your value.
*/
# tfc_oauth_token = "value"


#__________________________________________________________
#
# Intersight Variables
#__________________________________________________________

# secretkey    = "../../../../intersight.secret"
/*
  To export the Secret Key via an Environment Variable the format is as follows (Note: they are not quotation marks, but escape characters):
  - export TF_VAR_secretkey=`cat ../../intersight.secret`
  Either way will work in this case as we are not posting the contents of the file here.
*/
/*
  We highly recommend that for the apikey you use an environment variable for input:
  - export TF_VAR_apikey="abcdefghijklmnopqrstuvwxyz.0123456789"
*/
# apikey = "value"


#__________________________________________________________
#
# Workspaces to Create
#__________________________________________________________

workspaces = {
  "Thor_kubernetes_policies" = {
    auto_apply                    = true
    description                   = "Thor Kubernetes Policies."
    global_remote_state           = true
    structured_run_output_enabled = false
    working_directory             = "Asgard/kubernetes_policies"
    workspace_type                = "policies"
  }
  "Thor_iks_clusters" = {
    auto_apply                    = false
    description                   = "Thor Intersight Kubernetes Service Cluster01"
    global_remote_state           = true
    structured_run_output_enabled = false
    working_directory             = "Asgard/kubernetes_cluster_profiles"
    workspace_type                = "cluster"
  }
  "Thor_iks_kubeconfig" = {
    auto_apply                    = true
    description                   = "Thor Intersight Kubernetes Service Cluster01 kubeconfig."
    global_remote_state           = true
    structured_run_output_enabled = false
    working_directory             = "Asgard/kubeconfig"
    workspace_type                = "kubeconfig"
  }
  "Thor_iks_app_hello" = {
    agent_pool                    = "Richfield_Agents"
    auto_apply                    = true
    description                   = "Thor Intersight Kubernetes Service Cluster01 App Hello."
    execution_mode                = "agent"
    structured_run_output_enabled = false
    working_directory             = "Asgard/app_hello"
    workspace_type                = "app"
  }
  "Thor_iks_iwo" = {
    agent_pool                    = "Richfield_Agents"
    auto_apply                    = true
    description                   = "Thor Intersight Kubernetes Service Cluster01 IWO."
    execution_mode                = "agent"
    structured_run_output_enabled = false
    working_directory             = "Asgard/iwo"
    workspace_type                = "app"
  }
}
