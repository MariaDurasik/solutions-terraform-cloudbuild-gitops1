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

provider "google" {
  version = "~> 3.22"
}

provider "null" {
  version = "~> 2.1"
}

provider "random" {
  version = "~> 2.2"
}

resource "random_id" "name" {
  byte_length = 2
}
module "iap_bastion_group" {
  source      = "../../modules/bastion-group"
  project     = var.project
  region      = var.region
  zone        = var.zone
  network     = google_compute_network.network.self_link
  subnet      = google_compute_subnetwork.subnet.self_link
  members     = var.members
  target_size = var.target_size
}

resource "google_compute_network" "network" {
  project                 = var.project
  name                    = "test-network-group"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  project                  = var.project
  name                     = "test-subnet-group"
  region                   = var.region
  ip_cidr_range            = "10.128.0.0/20"
  network                  = google_compute_network.network.self_link
  private_ip_google_access = true
}

resource "google_compute_firewall" "allow_access_from_bastion" {
  project = var.project
  name    = "allow-bastion-group-ssh"
  network = google_compute_network.network.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # Allow SSH only from IAP Bastion
  source_service_accounts = [module.iap_bastion_group.service_account]
}
module "mysql-db" {
  source               = "./modules/mysql"
  name                 = var.db_name
  random_instance_name = true
  database_version     = "MYSQL_5_6"
  project_id           = var.project_id
  zone                 = "us-central1-c"
  region               = "us-central1"
  tier                 = "db-n1-standard-1"

  deletion_protection = false

  ip_configuration = {
    ipv4_enabled        = true
    private_network     = null
    require_ssl         = true
    authorized_networks = var.authorized_networks
  }


  database_flags = [
    {
      name  = "log_bin_trust_function_creators"
      value = "on"
    },
  ]
}

