output "project_id" {
  value = "${var.project_name}"
}

output "project_zone" {
  value = "${var.region_zone}"
}

output "consul_instance_in_ips" {
  value = "${module.consul.instance_in_ips}"
}

output "web_global_address" {
  value = "${module.web.global_address}"
}

output "sql_socket" {
  value = "/cloudsql/${var.project_name}:${var.region}:${var.sql_instance_name}"
}
