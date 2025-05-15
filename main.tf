# Ansible Automation Platform Job Module
# This module creates and runs an AAP job based on a specified job template

# Create an AAP inventory for this workspace
resource "aap_inventory" "job_inventory" {
  count       = var.create_inventory ? 1 : 0
  name        = var.inventory_name
  description = var.inventory_description

  variables = jsonencode(var.inventory_variables)
}

# Create AAP groups based on provided configuration
resource "aap_group" "job_groups" {
  for_each = var.create_inventory ? var.groups : {}

  inventory_id = var.create_inventory ? aap_inventory.job_inventory[0].id : var.existing_inventory_id
  name         = each.key

  variables = jsonencode(each.value.variables)
}

# Create AAP hosts based on provided configuration
resource "aap_host" "job_hosts" {
  for_each = var.create_inventory ? var.hosts : {}

  inventory_id = var.create_inventory ? aap_inventory.job_inventory[0].id : var.existing_inventory_id
  name         = each.key

  variables = jsonencode(each.value.variables)

  groups = [for group_name in each.value.groups : aap_group.job_groups[group_name].id if contains(keys(var.groups), group_name)]
}

# Run AAP job on deployed resources
resource "aap_job" "job" {
  job_template_id = var.job_template_id
  inventory_id    = var.create_inventory ? aap_inventory.job_inventory[0].id : var.existing_inventory_id
  extra_vars      = jsonencode(var.extra_vars)

  triggers = var.job_triggers
}