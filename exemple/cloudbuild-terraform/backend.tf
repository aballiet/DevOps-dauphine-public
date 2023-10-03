terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.10"
    }
  }

  backend "gcs" {
    bucket = "testbucket-dauphine-devops"
  }

  required_version = ">= 1.0"
}


provider "google" {
    project = "devops-dauphine-psl"
}