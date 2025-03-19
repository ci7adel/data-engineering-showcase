terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.25.0"
    }
  }
}

provider "google" {
  credentials = "./keys/terraform-demo-454211-70e156dc2676.json"
  project = "terraform-demo-454211"
  region  = "europe-west2"
}

resource "google_storage_bucket" "demo-bucket" {
  name          = "terraform-demo-454211-terra-bucket"
  location      = "US"
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