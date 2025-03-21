/**
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "project_id" {
  description = "The ID of the project in which resources will be provisioned."
  type        = string
  default     = "secound-312107"
}

variable "db_name" {
  description = "The name of the SQL Database instance"
  default     = "example-mysql-public"
}

variable "authorized_networks" {
  default = [{
    name  = "sample-gcp-health-checkers-range"
    value = "130.211.0.0/28"
  }]
  type        = list(map(string))
  description = "List of mapped public networks authorized to access to the instances. Default - short range of GCP health-checkers IPs"
}

   variable "region" {
  description = "The GCP region to create and test resources in"
  type        = string
  default     = "us-central1"
}

variable "subnetwork" {
  description = "The subnetwork selflink to host the compute instances in"
}

variable "num_instances" {
  description = "Number of instances to create"
}

variable "nat_ip" {
  description = "Public ip address"
  default     = null
}

variable "network_tier" {
  description = "Network network_tier"
  default     = "PREMIUM"
}


variable "service_account" {
  default = null
  type = object({
    email  = string,
    scopes = set(string)
  })
  description = "Service account to attach to the instance. See https://www.terraform.io/docs/providers/google/r/compute_instance_template.html#service_account."
}
   
variable "members" {
  description = "List of members in the standard GCP form: user:{email}, serviceAccount:{email}, group:{email}"
  type        = list(string)
}

variable "project" {
  description = "Project ID where the bastion will run"
  type        = string
  default     = "secound-312107"
}

variable "target_size" {
  description = "Number of instances to create"
  default     = 2
}

variable "image" {
  type = string

  description = "Source image for the Bastion. If image is not specified, image_family will be used (which is the default)."
  default     = ""
}

variable "image_family" {
  type = string

  description = "Source image family for the Bastion."
  default     = "centos-7"
}

variable "image_project" {
  type = string

  description = "Project where the source image for the Bastion comes from"
  default     = "gce-uefi-images"
}

variable "create_instance_from_template" {
  type = bool

  description = "Whether to create and instance from the template or not. If false, no instance is created, but the instance template is created and usable by a MIG"
  default     = true
}

variable "tags" {
  type = list(string)

  description = "Network tags, provided as a list"
  default     = []
}

variable "labels" {
  type = map(any)

  description = "Key-value map of labels to assign to the bastion host"
  default     = {}
}

variable "machine_type" {
  type        = string
  description = "Instance type for the Bastion host"
  default     = "n1-standard-1"
}

variable "name" {
  type = string

  description = "Name of the Bastion instance"
  default     = "bastion-vm"
}

variable "name_prefix" {
  type = string

  description = "Name prefix for instance template"
  default     = "bastion-instance-template"
}
variable "network" {
  type = string

  description = "Self link for the network on which the Bastion should live"
}

variable "host_project" {
  type = string

  description = "The network host project ID"
  default     = ""
}

variable "scopes" {
  type = list(string)

  description = "List of scopes to attach to the bastion host"
  default     = ["cloud-platform"]
}

variable "service_account_roles" {
  type = list(string)

  description = "List of IAM roles to assign to the service account."
  default = [
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/compute.osLogin",
  ]
}

variable "service_account_roles_supplemental" {
  type = list(string)

  description = "An additional list of roles to assign to the bastion if desired"
  default     = []
}

variable "service_account_name" {
  type = string

  description = "Account ID for the service account"
  default     = "bastion"
}

variable "service_account_email" {
  type = string

  description = "If set, the service account and its permissions will not be created. The service account being passed in should have at least the roles listed in the `service_account_roles` variable so that logging and OS Login work as expected."
  default     = ""
}

variable "shielded_vm" {
  type = bool

  description = "Enable shielded VM on the bastion host (recommended)"
  default     = true
}

variable "startup_script" {
  type = string

  description = "Render a startup script with a template."
  default     = ""
}

variable "subnet" {
  type = string

  description = "Self link for the subnet on which the Bastion should live. Can be private when using IAP"
}

variable "zone" {
  type = string

  description = "The primary zone where the bastion host will live"
  default     = "us-central1-a"
}

variable "random_role_id" {
  type = bool

  description = "Enables role random id generation."
  default     = true
}

variable "fw_name_allow_ssh_from_iap" {
  type = string

  description = "Firewall rule name for allowing SSH from IAP"
  default     = "allow-ssh-from-iap-to-tunnel"
}

variable "additional_ports" {
  description = "A list of additional ports/ranges to open access to on the instances from IAP."
  type        = list(string)
  default     = []
}

variable "disk_size_gb" {
  description = "Boot disk size in GB"
  default     = 100
}

variable "disk_type" {
  description = "Boot disk type, can be either pd-ssd, local-ssd, or pd-standard"
  default     = "pd-standard"
}

variable "metadata" {
  type        = map(string)
  description = "Key-value map of additional metadata to assign to the instances"
  default     = {}
}

variable "ephemeral_ip" {
  type        = bool
  description = "Set to true if an ephemeral external IP/DNS is required, must also set access_config if true"
  default     = false
}

variable "preemptible" {
  type        = bool
  description = "Allow the instance to be preempted"
  default     = false
}

variable "access_config" {
  description = "Access configs for network, nat_ip and DNS"
  type = list(object({
    network_tier           = string
    nat_ip                 = string
    public_ptr_domain_name = string
  }))
  default = [{
    nat_ip                 = "",
    network_tier           = "PREMIUM",
    public_ptr_domain_name = ""
  }]
}

variable "create_firewall_rule" {
  type        = bool
  description = "If we need to create the firewall rule or not."
  default     = true
}

variable "instance" {
  description = "Name of the example VM instance to create and allow SSH from IAP."
}
