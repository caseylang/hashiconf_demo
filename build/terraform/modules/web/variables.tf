variable "region" {
  type = "string"
}

variable "region_zone" {
  type = "string"
}

variable "user" {
  type = "string"
}

variable "project_name" {
  type = "string"
}

variable "public_key_path" {
  type = "string"
}

variable "count" {
  default = 2
  description = "The number of web servers to have behind the lb."
}

variable "sql_instance_name" {
  description = "Name of sql db instance to create. This name must start with a letter, consist of only lowercase letters, numbers and hyphens."
}
