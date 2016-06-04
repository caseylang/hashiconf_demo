resource "google_compute_firewall" "memcache" {
  name = "memcache-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["11211"]
  }

  target_tags = ["memcache"]
}

resource "google_compute_instance" "memcache" {
  count = 1

  name = "memcache"
  machine_type = "n1-standard-1"
  zone = "${var.region_zone}"
  tags = ["memcache"]

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
    scopes = [
      "https://www.googleapis.com/auth/compute.readonly"
    ]
  }
}
