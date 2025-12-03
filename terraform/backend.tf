terraform {
  backend "s3" {
    bucket = "meu-gerenciador-de-tarefas-sam"   # Nome do seu Space
    key    = "terraform.tfstate"                # Caminho do arquivo de estado
    region = "us-east-1"                        # Região (pode ser qualquer, DigitalOcean ignora)

    endpoints = {
      s3 = "https://sfo3.digitaloceanspaces.com"  # Endpoint do Space
    }

    # Ignora algumas validações para funcionar melhor com DigitalOcean Spaces
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true

    use_path_style = true   # Necessário para DigitalOcean Spaces
  }
}
