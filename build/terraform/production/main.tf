provider "google" {
  region = "${var.region}"
  project = "${var.project_name}"
  credentials = "${file(var.account_file_path)}"
}

module "consul" {
  source = "../modules/consul/"
  region_zone = "${var.region_zone}"
  user = "${var.user}"
  public_key_path = "${var.public_key_path}"
}

module "memcache" {
  source = "../modules/memcache/"
  region_zone = "${var.region_zone}"
  public_key_path = "${var.public_key_path}"
  user = "${var.user}"
}
