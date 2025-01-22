## GCP Configuration

# GCP Credentials File
variable "gcp_credentials_file" {
  description = "Path to the GCP credentials JSON file"
  type        = string
  default     = "~/terraform-key.json"
}

# GCP Project ID
variable "gcp_project_id" {
  description = "GCP project ID"
  type        = string
  default     = "my-example-project-448310"
}

# GCP Region
variable "gcp_region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}


## VPC & Subnets

# VPC Name
variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "example-vpc"
}

## Subnet Region
variable "subnet_region" {
  description = "Subnet Region"
  type        = string
  default     = "us-central1"
}

# Subnet Public CIDR Block
variable "subnet_public_cidr_block" {
  description = "Public Subnet CIDR"
  type        = string
  default     = "10.0.1.0/24"
}

# Subnet Private CIDR Block
variable "subnet_private_cidr_block" {
  description = "Private Subnet CIDR"
  type        = string
  default     = "10.0.2.0/24"
}

# Subnet Public Name
variable "subnet_public_name" {
  description = "Public Subnet name"
  type        = string
  default     = "subnet-public1"
}

# Subnet Private Name
variable "subnet_private_name" {
  description = "Private Subnet name"
  type        = string
  default     = "subnet-private1"
}


## Compuite Engine

# Zone for VirtualMachines
variable "gcp_zone" {
  description = "GCP Zone"
  type        = string
  default     = "us-central1-a"
}

# Image ID
variable "image_id" {
  description = "GCP image to use for the instances"
  type        = string
  default     = "projects/debian-cloud/global/images/family/debian-12"
}

# Machine Type
variable "machine_type" {
  description = "VM Type"
  type        = string
  default     = "f1-micro"
}


## SSH Key

# Define local public SSH Key
variable "ssh_public_key_file" {
  description = "Path to the public SSH key file"
  type        = string
  default     = "~/.ssh/terraform.pub"
}