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

# VPC CIDR
variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

# Subnets CIDR Blocks
variable "subnets_cidr_blocks" {
  description = "List of CIDR blocks for subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

# Subnets Names
variable "subnets_names" {
  description = "List of names for the subnets"
  type        = list(string)
  default     = ["subnet-public1", "subnet-public2"]
}


## Compuite Engine

# Zones for Subnets
variable "gcp_zones" {
  description = "List of GCP zones for the subnets"
  type        = list(string)
  default     = ["us-central1-a", "us-central1-b"] 
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