# Terraform Ansible Automation Platform (AAP) Job Module

This Terraform module provides a standardized way to create and run Ansible Automation Platform jobs with optional inventory, group, and host management.

## Features

- Create and run AAP jobs using job templates
- Optionally create and manage AAP inventories, groups, and hosts
- Support for using existing inventories
- Configurable job triggers for automation workflows
- Complete output of job status and resource IDs

## Usage

```hcl
module "aap_job" {
  source = "path/to/terraform-aap-job"

  job_template_id = "12345"
  
  # Optional: Create a new inventory
  create_inventory     = true
  inventory_name       = "My Application Servers"
  inventory_description = "Inventory for application servers managed by Terraform"
  
  # Inventory variables
  inventory_variables = {
    environment = "production"
    region      = "us-west"
  }
  
  # Create groups in the inventory
  groups = {
    web_servers = {
      variables = {
        ansible_group_priority = 10
        application_tier      = "web"
      }
    },
    db_servers = {
      variables = {
        ansible_group_priority = 20
        application_tier      = "database"
      }
    }
  }
  
  # Create hosts in the inventory
  hosts = {
    "web01.example.com" = {
      variables = {
        ansible_host = "10.0.0.10"
        role        = "primary"
      }
      groups = ["web_servers"]
    },
    "web02.example.com" = {
      variables = {
        ansible_host = "10.0.0.11"
        role        = "secondary"
      }
      groups = ["web_servers"]
    },
    "db01.example.com" = {
      variables = {
        ansible_host = "10.0.0.20"
        role        = "primary"
      }
      groups = ["db_servers"]
    }
  }
  
  # Job extra variables
  extra_vars = {
    deployment_id = "12345"
    update_packages = true
  }
  
  # Triggers that will cause the job to run when changed
  job_triggers = {
    vm_names = {
      "server1" = "web01"
      "server2" = "web02"
    }
  }
}
```

## Using an Existing Inventory

```hcl
module "aap_job" {
  source = "path/to/terraform-aap-job"

  job_template_id      = "12345"
  create_inventory     = false
  existing_inventory_id = "67890"
  
  extra_vars = {
    deployment_id = "12345"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.0 |
| aap | >= 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| aap | >= 1.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| job_template_id | The ID of the AAP job template to run | `string` | n/a | yes |
| create_inventory | Whether to create a new inventory or use an existing one | `bool` | `true` | no |
| existing_inventory_id | The ID of an existing inventory to use when create_inventory is false | `string` | `""` | no |
| inventory_name | Name of the AAP inventory to create | `string` | `"Terraform Managed Inventory"` | no |
| inventory_description | Description for the AAP inventory | `string` | `"Inventory created and managed by Terraform"` | no |
| inventory_variables | Variables to apply to the inventory in JSON format | `map(any)` | `{}` | no |
| groups | Map of AAP groups to create with their variables | `map(object({variables = map(any)}))` | `{}` | no |
| hosts | Map of AAP hosts to create with their variables and group associations | `map(object({variables = map(any), groups = list(string)}))` | `{}` | no |
| extra_vars | Extra variables to pass to the job template | `map(any)` | `{}` | no |
| job_triggers | A map of trigger values that will cause the job to run when changed | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| job_id | The ID of the created AAP job |
| inventory_id | The ID of the inventory used for the job |
| job_status | The status of the AAP job |
| groups | Map of created AAP groups and their IDs |
| hosts | Map of created AAP hosts and their IDs |

## License

MIT