variable "project" {
  type = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]*$", var.project))
    error_message = "Project må starte med liten bokstav og bare inneholde små bokstaver, tall og bindestrek."
  }
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}