locals {
  # Host configuration map used for job triggers
  host_configs = {
    "app01" = {
      ip_address = "10.0.1.10"
      role       = "application"
    },
    "app02" = {
      ip_address = "10.0.1.11"
      role       = "application"
    },
    "db01" = {
      ip_address = "10.0.1.20"
      role       = "database"
    },
    "lb01" = {
      ip_address = "10.0.1.30"
      role       = "load_balancer"
    }
  }
}