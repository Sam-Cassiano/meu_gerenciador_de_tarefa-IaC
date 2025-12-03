terraform {
  backend "s3" {
    bucket = "seu-nome-do-bucket"
    key    = "prod/terraform.tfstate"
    region = "us-east-1"  # obrigatório, mas ignorado pela DO

    endpoints = {
      s3 = "https://nyc3.digitaloceanspaces.com"
    }

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    use_path_style              = true
  }
}
