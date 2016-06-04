variable "count" {
  default = 3
  description = "The number of consul servers in the cluster."
}

variable "region_zone" {
  default = "us-central1-a"
}

variable "user" {
  description = "User to create on the servers"
}

variable "public_key_path" {
  description = "Path to a public key to add to the machine"
}
