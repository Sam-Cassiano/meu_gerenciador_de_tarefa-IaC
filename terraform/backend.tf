terraform {
  backend "s3" {
    bucket = "meu-gerenciador-de-tarefas-sam"
    key    = "terraform.tfstate"
    region = "us-east-1"

    # Endpoint do DigitalOcean Spaces
    endpoints = {
      s3 = "https://sfo3.digitaloceanspaces.com"
    }

    # Configurações de validação/estilo de path
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    use_path_style              = true
  }
}
