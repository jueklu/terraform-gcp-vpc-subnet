# VPC
resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

# Subnets Public
resource "google_compute_subnetwork" "subnets_public" {
  count          = length(var.subnets_cidr_blocks)
  name           = var.subnets_names[count.index]
  ip_cidr_range  = var.subnets_cidr_blocks[count.index]
  region         = var.subnets_regions[count.index]
  network        = google_compute_network.vpc_network.id
}