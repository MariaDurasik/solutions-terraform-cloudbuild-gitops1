# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.65.0"
    }
  }
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}


resource "random_id" "db_name_suffix" {
byte_length = 4
}

resource "google_sql_database_instance" "master" {
name = "master-instance-${random_id.db_name_suffix.hex}"

settings {
tier = "db-f1-micro"
}
}

resource "google_sql_database" "database" {
name     = "my-database"
instance = google_sql_database_instance.master.name
}

resource "google_sql_user" "users" {
name     = "user"
instance = google_sql_database_instance.master.name
password = "Eey3ar8fz343uciy"
}


data "google_cloud_run_locations" "available" {
}
