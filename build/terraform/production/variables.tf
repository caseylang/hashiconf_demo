variable "region" {
  default = "us-central1"
}

variable "region_zone" {
  default = "us-central1-a"
}

variable "user" {
  default = "hashiconf-demo"
  description = "User to create on the servers"
}

variable "project_name" {
  description = "The ID of your Google Cloud project"
}

variable "account_file_path" {
  description = "Path to the JSON file used to describe your GCP account credentials"
}

variable "public_key_path" {
  description = "Path to a public key to add to the machine"
  default = "~/.ssh/id_rsa.pub"
}
