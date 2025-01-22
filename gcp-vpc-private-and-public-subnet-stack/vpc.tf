## VPC & Subnets

# VPC
resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

# Subnet Public
resource "google_compute_subnetwork" "subnet_public" {
  name           = var.subnet_public_name
  ip_cidr_range  = var.subnet_public_cidr_block
  region         = var.subnet_region
  network        = google_compute_network.vpc_network.id
}

# Subnet Private
resource "google_compute_subnetwork" "subnet_private" {
  name                      = var.subnet_private_name
  ip_cidr_range             = var.subnet_private_cidr_block
  region                    = var.subnet_region
  network                   = google_compute_network.vpc_network.id
  private_ip_google_access  = true # Allow private IPs to access Google APIs
}


## NAT

## Create Cloud Router
resource "google_compute_router" "router" {
  name    = "nat-router"
  region  = var.subnet_region  # Same region as subnets
  network = google_compute_network.vpc_network.id

}

## Create Nat Gateway
resource "google_compute_router_nat" "nat" {
  name                               = "router-nat"
  router                             = google_compute_router.router.name
  region                             = var.subnet_region 
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"  # Associate (private) subnet

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}