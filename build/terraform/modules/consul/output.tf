output "instance_in_ips" {
  value = "${join(" ", google_compute_instance.consul_server.*.network_interface.0.address)}"
}
