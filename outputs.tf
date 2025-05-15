output "job_id" {
  description = "The ID of the created AAP job"
  value       = aap_job.job.id
}

output "inventory_id" {
  description = "The ID of the inventory used for the job"
  value       = var.create_inventory ? aap_inventory.job_inventory[0].id : var.existing_inventory_id
}

output "job_status" {
  description = "The status of the AAP job"
  value       = aap_job.job.status
}

output "groups" {
  description = "Map of created AAP groups and their IDs"
  value = {
    for name, group in aap_group.job_groups : name => group.id
  }
}

output "hosts" {
  description = "Map of created AAP hosts and their IDs"
  value = {
    for name, host in aap_host.job_hosts : name => host.id
  }
}