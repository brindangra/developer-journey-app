/**
 * Copyright 2023 Google LLC
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


# cloud source repo
resource "google_sourcerepo_repository" "default" {
  project = var.project_id
  name = var.deployment_name
}

# artifact registry


# cloud build trigger

resource "google_cloudbuild_trigger" "web_new_build" {
  project     = var.project_id
  name        = "web-new-build"
  filename    = "build/cloudbuild.yaml"
  description = "Triggers on every change to main branch in website directory. Initiates website image build."
  included_files = [
    "src/*",
  ]
  trigger_template {
    repo_name = google_sourcerepo_repository.default.name
    branch_name = "main"
  }
}