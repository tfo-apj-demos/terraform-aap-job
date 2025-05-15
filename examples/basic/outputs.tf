output "job_id" {
  description = "The ID of the created AAP job"
  value       = module.aap_job_example.job_id
}

output "inventory_id" {
  description = "The ID of the inventory created for the job"
  value       = module.aap_job_example.inventory_id
}

output "job_status" {
  description = "The status of the AAP job"
  value       = module.aap_job_example.job_status
}

output "groups" {
  description = "Map of created AAP groups and their IDs"
  value       = module.aap_job_example.groups
}

output "hosts" {
  description = "Map of created AAP hosts and their IDs"
  value       = module.aap_job_example.hosts
}