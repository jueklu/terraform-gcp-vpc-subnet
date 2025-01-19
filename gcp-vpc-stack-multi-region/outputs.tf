# Public IPs of the VMs
output "vm_public_ips" {
  description = "Public IP addresses of the VMs"
  value       = [for ip in google_compute_address.static_ip : ip.address]
}

# Private IPs of the VMs
output "vm_private_ips" {
  description = "Private IP addresses of the VMs"
  value       = [for vm in google_compute_instance.debian_vm : vm.network_interface[0].network_ip]
}