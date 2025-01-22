## Compute Engine Instances

# Static IP for Public VM
resource "google_compute_address" "static_ip" {
  name   = "public-ip"
  region = var.subnet_region # Use the same region as the subnets
}

# Compute Engine Instance for Public Subnet
resource "google_compute_instance" "debian_vm_public" {
  name         = "debian-public-vm"
  machine_type = var.machine_type
  zone         = var.gcp_zone
  tags         = ["ingress-public", "egress"] # Tags for firewall rules

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
    subnetwork = google_compute_subnetwork.subnet_public.id # Use the public subnet

    access_config {
      nat_ip = google_compute_address.static_ip.address # Assign the static public IP
    }
  }
}

# Compute Engine Instance for Private Subnet
resource "google_compute_instance" "debian_vm_private" {
  name         = "debian-private-vm"
  machine_type = var.machine_type
  zone         = var.gcp_zone
  tags         = ["ingress-private", "egress"] # Tags for firewall rules

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
    subnetwork = google_compute_subnetwork.subnet_private.id # Use the private subnet
  }
}


## Firewall

# Firewall: Ingress Rules for Public Subnet
resource "google_compute_firewall" "ingress_public" {
  name          = "ingress-public-vm"
  network       = google_compute_network.vpc_network.name
  target_tags   = ["ingress-public"]

  allow {
    protocol = "tcp"
    ports    = ["22"]  # Allow SSH
  }
  allow {
    protocol = "icmp"  # Allow Ping
  }
  source_ranges = ["0.0.0.0/0"]  # Allow traffic from anywhere
}

# Firewall: Ingress Rules for Private Subnet
resource "google_compute_firewall" "ingress-private" {
  name    = "ingress-private-vm"
  network = google_compute_network.vpc_network.name
  target_tags   = ["ingress-private"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  allow {
    protocol = "icmp"  # Allow Ping
  }

  source_ranges = ["10.0.1.0/24"] # Public subnet CIDR
}

# Firewall: Egress Rules for both Subnets
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