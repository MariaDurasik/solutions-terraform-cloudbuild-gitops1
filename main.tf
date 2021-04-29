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


provider "google" {
  project = "${var.project}"
}
module "project-factory" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 10.1"

  name                 = "pf-test-1"
  random_project_id    = true
  org_id               = "1234567890"
  usage_bucket_name    = "pf-test-1-usage-report-bucket"
  usage_bucket_prefix  = "pf/test/1/integration"
  billing_account      = "ABCDEF-ABCDEF-ABCDEF"
  svpc_host_project_id = "shared_vpc_host_name"

  shared_vpc_subnets = [
    "projects/base-project-196723/regions/us-east1/subnetworks/default",
    "projects/base-project-196723/regions/us-central1/subnetworks/default",
    "projects/base-project-196723/regions/us-central1/subnetworks/subnet-1",
  ]
}
module "sql-db" {
  source  = "GoogleCloudPlatform/sql-db/google//modules/mysql"
  version = "4.0.0"
}
