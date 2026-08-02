variable "location" {
  type    = string
  default = "centralindia"
}

variable "environment" {
  type    = string
  default = "prod"
}

variable "prefix" {
  type    = string
  default = "cnmp"
}

variable "common_tags" {
  type = map(string)
  default = {
    application = "cloud-native-monitoring-platform"
    managed_by  = "terraform"
  }
}

variable "aks_node_count" {
  type    = number
  default = 3
}

variable "alert_email" {
  type = string
}

