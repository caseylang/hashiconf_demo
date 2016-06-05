resource "google_compute_global_address" "web" {
  name = "web-address"
}

resource "google_compute_http_health_check" "web" {
  name = "web-http-check"
  request_path = "/system/health-check.html"
  check_interval_sec = 5
  healthy_threshold = 5
  unhealthy_threshold = 5
  timeout_sec = 2
  port = "80"
}

resource "google_compute_instance" "web" {
  count = "${var.count}"

  name = "web-server-${count.index}"
  machine_type = "n1-standard-1"
  zone = "${var.region_zone}"
  tags = ["web"]

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
      "https://www.googleapis.com/auth/compute.readonly",
      # Admin sql access
      "https://www.googleapis.com/auth/sqlservice.admin",
      # Read access to google storage during deployments
      "https://www.googleapis.com/auth/devstorage.read_only"
    ]
  }
}

resource "google_compute_instance_group" "web_servers" {
  name = "web-webservers"
  instances = ["${google_compute_instance.web.*.self_link}"]
  named_port {
    name = "http"
    port = "80"
  }

  zone = "${var.region_zone}"
}

resource "google_compute_backend_service" "web" {
  name = "web"
  port_name = "http"
  protocol = "HTTP"
  timeout_sec = 10
  region = "${var.region}"

  backend {
    group = "${google_compute_instance_group.web_servers.self_link}"
  }

  health_checks = ["${google_compute_http_health_check.web.self_link}"]
}

resource "google_compute_url_map" "web" {
  name = "web-url-map"
  default_service = "${google_compute_backend_service.web.self_link}"
}

resource "google_compute_target_http_proxy" "web" {
  name = "web-http-proxy"
  url_map = "${google_compute_url_map.web.self_link}"
}

resource "google_compute_global_forwarding_rule" "web_http" {
  name = "web-http"
  target = "${google_compute_target_http_proxy.web.self_link}"
  port_range = "80"
  ip_address = "${google_compute_global_address.web.address}"
}

resource "google_compute_firewall" "default" {
  name = "web-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports = [
      "80"
    ]
  }

  source_ranges = [
    "0.0.0.0/0", # All IPs
    "130.211.0.0/22"    # HTTP load balancing health checks and lb traffic
  ]
  target_tags = ["web"]
}

resource "google_storage_bucket" "web-logs" {
  name = "web-logs-${var.project_name}"
  location = "US"
}

resource "google_sql_database_instance" "db" {
  name = "${var.sql_instance_name}"
  region = "${var.region}"
  database_version = "MYSQL_5_6"

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled = false
    }
    location_preference {
      zone = "${var.region_zone}"
    }
    # Database settings https://cloud.google.com/sql/docs/mysql-flags
    database_flags {
      name = "log_output"
      value = "TABLE"
    }
    database_flags {
      name = "slow_query_log"
      value = 1
    }
    database_flags {
      name = "long_query_time"
      value = 5
    }
  }
}
