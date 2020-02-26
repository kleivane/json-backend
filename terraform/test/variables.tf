variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 80
}
variable "container_name" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = "static-json"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
  default     = "2"
}
