terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.25.0"
    }
  }
}

provider "google" {
  credentials = var.credentials_file
  project     = "terraform-demo-454211"
  region      = "europe-west2"
}

resource "google_storage_bucket" "demo-bucket" {
  name          = var.gcs_bucket_name
  location      = var.location
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

resource "google_bigquery_dataset" "demo_dataset" {
  dataset_id                  = "demo_dataset"
  delete_contents_on_destroy = true
  # friendly_name               = "test"
  # description                 = "This is a test description"
  # location                    = "EU"
  # default_table_expiration_ms = 3600000

  # labels = {
  #   env = "default"
  # }

  # access {
  #   role          = "OWNER"
  #   user_by_email = google_service_account.bqowner.email
  # }

  # access {
  #   role   = "READER"
  #   domain = "hashicorp.com"
  # }
}

# resource "google_service_account" "bqowner" {
#   account_id = "bqowner"
# }