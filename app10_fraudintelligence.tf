resource "google_bigquery_dataset" "fraudintelligence" {
  dataset_id                  = "fraud_intelligence_core"
  friendly_name               = "Fraud Intelligence Core"
  description                 = "Dataset of Fraud Intelligence, the basis for advanced fraud detection and prevention"
  location                    = "EU"
  default_table_expiration_ms = 3600000

  access {
    role          = "OWNER"
    user_by_email = google_service_account.bqowner.email
  }
}

resource "google_service_account" "bqowner" {
  account_id = "bqowner"
}
