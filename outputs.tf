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


output "network" {
  value = "${module.vpc.network}"
}

output "subnet" {
  value = "${module.vpc.subnet}"
}

output "firewall_rule" {
  value = "${module.firewall.firewall_rule}"
}

output "instance_name" {
  value = "${module.http_server.instance_name}"
}

output "external_ip" {
  value = "${module.http_server.external_ip}"
}

# ------------------------------------------------------------------------------
# MASTER OUTPUTS
# ------------------------------------------------------------------------------

output "master_instance_name" {
  description = "The name of the database instance"
  value       = module.postgres.master_instance_name
}

output "master_ip_addresses" {
  description = "All IP addresses of the instance as list of maps, see https://www.terraform.io/docs/providers/google/r/sql_database_instance.html#ip_address-0-ip_address"
  value       = module.postgres.master_ip_addresses
}

output "master_private_ip" {
  description = "The private IPv4 address of the master instance"
  value       = module.postgres.master_private_ip_address
}

output "master_instance" {
  description = "Self link to the master instance"
  value       = module.postgres.master_instance
}

output "master_proxy_connection" {
  description = "Instance path for connecting with Cloud SQL Proxy. Read more at https://cloud.google.com/sql/docs/mysql/sql-proxy"
  value       = module.postgres.master_proxy_connection
}

# ------------------------------------------------------------------------------
# DB OUTPUTS
# ------------------------------------------------------------------------------

output "db_name" {
  description = "Name of the default database"
  value       = module.postgres.db_name
}

output "db" {
  description = "Self link to the default database"
  value       = module.postgres.db
}

