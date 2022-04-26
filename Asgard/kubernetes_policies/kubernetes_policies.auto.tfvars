# Intersight Organization
organization = "Asgard"

# Global Tag Values - Consumed by Policies if no specific Tags are defined.
tags = [
  {
    "key"   = "terraform-intersight-easy-iks"
    "value" = "1.5.1"
  },
  {
    "key"   = "deployed-by"
    "value" = "tyscott"
  }
]

# IP Pools
ip_pools = {
  "iks" = {
    assignment_order = "sequential"
    description      = ""
    ipv4_blocks = {
      "0" = {
        from = "10.88.105.64"
        size = 64
        # to   = "10.88.105.128"
      }
    }
    ipv4_config = [{
      gateway       = "10.88.105.1"
      netmask       = "255.255.255.0"
      primary_dns   = "10.101.128.15"
      secondary_dns = "10.101.128.16"
    }]
    ipv6_blocks = {}
    ipv6_config = []
    tags        = []
  }
}

#______________________________
#
# Kubernetes Policies
#______________________________

# Addons
addons_policies = {
  "ccp-monitor" = {
    install_strategy = "Always"
    upgrade_strategy = "ReinstallOnFailure"
  }
  "kubernetes-dashboard" = {
    install_strategy = "Always"
    upgrade_strategy = "ReinstallOnFailure"
  }
  "smm1_8" = {
    chart_name       = "smm"
    chart_version    = "1.8.2-cisco2-helm3"
    install_strategy = "Always"
    overrides        = "demoApplication,enabled,true"
    release_name     = "smm1.8"
    upgrade_strategy = "ReinstallOnFailure"
  }
}

# Container Runtime
container_runtime_policies = {}

# Kubernetes Version
kubernetes_version_policies = {
  "v1.21.10" = {
    version = "v1.21.10"
  }
}

# Network CIDR Policies
network_cidr_policies = {
  "Asgrad_CIDR" = {
    cni_type         = "Calico"
    pod_network_cidr = "100.88.0.0/16"
    service_cidr     = "100.89.0.0/16"
  }
}

# NodeOS Configuration
nodeos_configuration_policies = {
  "Asgard" = {
    dns_servers = ["10.101.128.15", "10.101.128.16"]
    dns_suffix  = "rich.ciscolabs.com"
    ntp_servers = ["10.101.128.15", "10.101.128.16"]
    timezone    = "America/New_York"
  }
}

# Trusted Certificate Authorities
trusted_certificate_authorities = {}

# VM Infra Config
virtual_machine_infra_config = {
  "Thor" = {
    description = ""
    tags        = []
    target      = "asgard-vcenter.rich.ciscolabs.com"
    virtual_infrastructure = [{
      cluster       = "Thor"
      datastore     = "Mjolnir"
      interfaces    = ["prod|Apps|Web1"]
      resource_pool = ""
      type          = "vmware"
    }]
  }
}

# VM Instance Type
virtual_machine_instance_type = {
  "Small" = {}
  "Medium" = {
    cpu              = 8
    memory           = 24576
    system_disk_size = 60
  }
  "Large" = {
    cpu              = 12
    memory           = 32768
    system_disk_size = 80
  }
}