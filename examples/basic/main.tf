# Example implementation of the terraform-aap-job module
# This example creates an inventory with groups and hosts and runs an AAP job

module "aap_job_example" {
  # In real usage, this would point to the module source location (GitHub, local path, etc.)
  # For local development testing, use a relative path to the parent module
  source = "../../"

  # Required: Job template ID to run
  job_template_id = var.job_template_id

  # Create a new inventory for this job
  create_inventory     = true
  inventory_name       = "Example Application Inventory"
  inventory_description = "Example inventory for application deployment"
  
  # Inventory variables
  inventory_variables = {
    ansible_connection = "ssh"
    environment        = var.environment
    application        = "example-app"
  }
  
  # Create groups in the inventory
  groups = {
    app_servers = {
      variables = {
        ansible_group_priority = 10
        application_tier      = "application"
      }
    },
    db_servers = {
      variables = {
        ansible_group_priority = 20
        application_tier      = "database"
        db_type               = "postgresql"
      }
    },
    lb_servers = {
      variables = {
        ansible_group_priority = 30
        application_tier      = "load_balancer"
      }
    }
  }
  
  # Create hosts in the inventory
  hosts = {
    "app01.example.com" = {
      variables = {
        ansible_host = "10.0.1.10"
        node_role    = "primary"
      }
      groups = ["app_servers"]
    },
    "app02.example.com" = {
      variables = {
        ansible_host = "10.0.1.11"
        node_role    = "secondary"
      }
      groups = ["app_servers"]
    },
    "db01.example.com" = {
      variables = {
        ansible_host = "10.0.1.20"
        node_role    = "primary"
      }
      groups = ["db_servers"]
    },
    "lb01.example.com" = {
      variables = {
        ansible_host = "10.0.1.30"
      }
      groups = ["lb_servers"]
    }
  }
  
  # Job extra variables
  extra_vars = {
    deployment_id    = var.deployment_id
    application_name = "example-app"
    version          = var.app_version
    update_packages  = true
  }
  
  # Triggers that will cause the job to run when changed
  job_triggers = {
    app_version = var.app_version
    hosts = {
      for name, host in local.host_configs : name => host.ip_address
    }
  }
}