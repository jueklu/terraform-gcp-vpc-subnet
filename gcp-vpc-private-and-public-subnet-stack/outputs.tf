# Public VM Outputs
output "public_vm_ips" {
  description = "Public and private IPs of the public VM"
  value = {
    name        = google_compute_instance.debian_vm_public.name
    public_ip   = google_compute_instance.debian_vm_public.network_interface[0].access_config[0].nat_ip
    private_ip  = google_compute_instance.debian_vm_public.network_interface[0].network_ip
  }
}

# Private VM Outputs
output "private_vm_ips" {
  description = "Private IP of the private VM"
  value = {
    name        = google_compute_instance.debian_vm_private.name
    private_ip  = google_compute_instance.debian_vm_private.network_interface[0].network_ip
  }
}