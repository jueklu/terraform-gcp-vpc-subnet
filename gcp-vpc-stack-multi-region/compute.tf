## Compute

# Static IPs for VMs
resource "google_compute_address" "static_ip" {
  count   = length(var.gcp_zones)
  name    = "debian-vm-${count.index + 1}"
  region  = substr(var.gcp_zones[count.index], 0, length(var.gcp_zones[count.index]) - 2) # Extract the region from the zone
}

# Compute Engine Instances
resource "google_compute_instance" "debian_vm" {
  count        = length(var.gcp_zones)
  name         = "debian-${count.index + 1}"
  machine_type = var.machine_type
  zone         = element(var.gcp_zones, count.index)
  tags         = ["ingress","egress"]  # Add both ingress and egress tags

  # Metadata for SSH Access
  metadata = {
    ssh-keys = "debian:${file(var.ssh_public_key_file)}"
  }

  boot_disk {
    initialize_params {
      image = var.image_id
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnets_public[count.index].id

    access_config {
      nat_ip = google_compute_address.static_ip[count.index].address
    }
  }
}


## Firewall

# Firewall: Ingress Rules
resource "google_compute_firewall" "ingress" {
  name          = "ingress"
  network       = google_compute_network.vpc_network.name
  target_tags   = ["ingress"]

  allow {
    protocol = "tcp"
    ports    = ["22"]  # Allow SSH
  }
  allow {
    protocol = "icmp"  # Allow Ping
  }
  source_ranges = ["0.0.0.0/0"]  # Allow traffic from anywhere
}

# Firewall: Egress Rules
resource "google_compute_firewall" "egress" {
  name    = "egress"
  network = google_compute_network.vpc_network.name
  target_tags   = ["egress"]

  allow {
    protocol = "all"
  }
  direction          = "EGRESS"
  destination_ranges = ["0.0.0.0/0"]
}