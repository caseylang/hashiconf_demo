output "project_id" {
  value = "${var.project_name}"
}

output "project_zone" {
  value = "${var.region_zone}"
}

output "consul_instance_in_ips" {
  value = "${module.consul.instance_in_ips}"
}
