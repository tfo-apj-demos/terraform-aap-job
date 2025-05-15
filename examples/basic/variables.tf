variable "job_template_id" {
  description = "The ID of the AAP job template to run"
  type        = string
  default     = "12345"  # Default for example purposes, should be replaced in real usage
}

variable "environment" {
  description = "The deployment environment"
  type        = string
  default     = "development"
}

variable "deployment_id" {
  description = "A unique identifier for this deployment"
  type        = string
  default     = "example-123"
}

variable "app_version" {
  description = "The version of the application to deploy"
  type        = string
  default     = "1.0.0"
}

variable "aap_host" {
  description = "AAP host URL"
  type        = string
  default     = "https://aap.example.com"
}

variable "aap_username" {
  description = "AAP username"
  type        = string
  default     = "admin"
  sensitive   = true
}

variable "aap_password" {
  description = "AAP password"
  type        = string
  default     = ""  # Should be provided via environment variable or other secure method
  sensitive   = true
}