variable "location" {
    description = "location project"
    default = "US"
  
}

variable "bd_data_dataset" {
    description = "Big Query dataset"
    default = "demo_dataset"
}

variable "gcs_storage_class" {
    description = "Bucket Storage class"
    default = "STANDARD"
}

variable "gcs_bucket_name" {
    description = "My bucket"
    default = "terraform-demo-454211-terra-bucket"
  
}

variable "credentials_file" {
    default = "./keys/terraform-demo-454211-ea40e4ce4e81.json"
  
}