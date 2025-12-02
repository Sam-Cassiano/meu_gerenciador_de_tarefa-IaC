terraform {
required_providers {
digitalocean = {
source  = "digitalocean/digitalocean"
version = "~> 2.69.0"
}
}
}

provider "digitalocean" {
token = var.do_token
}

resource "digitalocean_droplet" "app_server" {
name   = "meu-gerenciador-de-tarefas"
region = "nyc3"
size   = "s-1vcpu-1gb"
image  = "ubuntu-22-04-x64"

ssh_keys = [var.ssh_fingerprint]

user_data = <<-EOF
#cloud-config
packages:
- docker.io
- docker-compose
runcmd:
- ["usermod", "-aG", "docker", "${var.ssh_user}"]
EOF
}
