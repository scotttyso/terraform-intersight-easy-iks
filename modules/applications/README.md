# applications - Kubernetes Applications

## Use this module to deploy Helm Charts and Kubectl YAML Manifests

Run the plan from the Terraform cloud workspace.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | 1.11.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | 1.11.3 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.helm_chart](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.manifest](https://registry.terraform.io/providers/gavinbunney/kubectl/1.11.3/docs/resources/manifest) | resource |
| [terraform_remote_state.local_kubeconfigs](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.remote_kubeconfigs](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the Cluster to push Policy to | `string` | n/a | yes |
| <a name="input_helm_chart"></a> [helm\_chart](#input\_helm\_chart) | Key - Name of the Helm Chart<br>* chart - location to find the chart<br>* namespace - Kubernetes Namespace to assign to the pod<br>* set - List of Parameters for deployment | <pre>map(object(<br>    {<br>      chart     = string<br>      namespace = string<br>      set       = list(map(string))<br>    }<br>  ))</pre> | n/a | yes |
| <a name="input_kubectl_manifest"></a> [kubectl\_manifest](#input\_kubectl\_manifest) | n/a | <pre>map(object(<br>    {<br>      yaml_body = string<br>    }<br>  ))</pre> | n/a | yes |
| <a name="input_tfc_workspaces"></a> [tfc\_workspaces](#input\_tfc\_workspaces) | * backend: Options are:<br>  - local - The backend is on the Local Machine<br>  - Remote - The backend is in TFCB.<br>* kubeconfig\_dir: Name of the Policies directory when the backend is local.<br>* organization: Name of the Terraform Cloud Organization when backend is remote.<br>* workspace: Name of the workspace in Terraform Cloud. | <pre>list(object(<br>    {<br>      backend        = string<br>      kubeconfig_dir = optional(string)<br>      organization   = optional(string)<br>      workspace      = optional(string)<br>    }<br>  ))</pre> | <pre>[<br>  {<br>    "backend": "remote",<br>    "kubeconfig_dir": "../kubeconfigs/",<br>    "organization": "default",<br>    "workspace": "kubeconfigs"<br>  }<br>]</pre> | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
