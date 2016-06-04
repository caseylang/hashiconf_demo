resource "google_compute_instance" "consul_server" {
  count = "${var.count}"

  name = "consul-server-${count.index}"
  machine_type = "f1-micro"
  zone = "${var.region_zone}"
  tags = ["consul", "consul-server"]

  disk {
    image = "centos-6-v20160526"
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata {
    sshKeys = "${var.user}:${file(var.public_key_path)}"
  }

  service_account {
    scopes = ["https://www.googleapis.com/auth/compute.readonly"]
  }
}

resource "google_compute_firewall" "consul" {
  name = "consul-server-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["8500"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["consul-server"]
}
