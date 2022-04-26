tfc_workspaces = [{
  backend      = "remote"
  organization = "Cisco-Richfield-Lab"
  workspace    = "Thor_kubernetes_policies"
}]

kubernetes_cluster_profiles = {
  "thor-cl1" = {
    action                    = "No-op" # Options are {Delete|Deploy|Ready|No-op|Unassign}.
    action_ignore             = false
    addons_policies           = ["ccp-monitor", "kubernetes-dashboard", "smm1_8"]
    certificate_configuration = false
    cluster_configuration = [{
      load_balancer_count = 3
      ssh_public_key      = 1
    }]
    container_runtime_policy = ""
    ip_pool                  = "iks"
    network_cidr_policy      = "Asgard_CIDR"
    node_pools = {
      "Control_Plane" = {
        desired_size = 3
        ip_pool      = "iks"
        kubernetes_labels = [{
          "key"   = "environment"
          "value" = "production"
        }]
        kubernetes_version_policy = "v1.21.10"
        max_size                  = 3
        min_size                  = 2
        node_type                 = "ControlPlane"
        vm_infra_config_policy    = "Thor"
        vm_instance_type_policy   = "Small"
      }
      "Worker_g1" = {
        desired_size = 3
        ip_pool      = "iks"
        kubernetes_labels = [{
          "key"   = "environment"
          "value" = "production"
        }]
        kubernetes_version_policy = "v1.21.10"
        max_size                  = 5
        min_size                  = 3
        node_type                 = "Worker"
        vm_infra_config_policy    = "Thor"
        vm_instance_type_policy   = "Medium"
      }
    }
    nodeos_configuration_policy   = "Asgard"
    trusted_certificate_authority = ""
    wait_for_completion           = false
  }
}