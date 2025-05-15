variable "job_template_id" {
  description = "The ID of the AAP job template to run"
  type        = string
}

variable "create_inventory" {
  description = "Whether to create a new inventory or use an existing one"
  type        = bool
  default     = true
}

variable "existing_inventory_id" {
  description = "The ID of an existing inventory to use when create_inventory is false"
  type        = string
  default     = ""
}

variable "inventory_name" {
  description = "Name of the AAP inventory to create"
  type        = string
  default     = "Terraform Managed Inventory"
}

variable "inventory_description" {
  description = "Description for the AAP inventory"
  type        = string
  default     = "Inventory created and managed by Terraform"
}

variable "inventory_variables" {
  description = "Variables to apply to the inventory in JSON format"
  type        = map(any)
  default     = {}
}

variable "groups" {
  description = "Map of AAP groups to create with their variables"
  type = map(object({
    variables = map(any)
  }))
  default = {}
}

variable "hosts" {
  description = "Map of AAP hosts to create with their variables and group associations"
  type = map(object({
    variables = map(any)
    groups    = list(string)
  }))
  default = {}
}

variable "extra_vars" {
  description = "Extra variables to pass to the job template"
  type        = map(any)
  default     = {}
}

variable "job_triggers" {
  description = "A map of trigger values that will cause the job to run when changed"
  type        = map(any)
  default     = {}
}