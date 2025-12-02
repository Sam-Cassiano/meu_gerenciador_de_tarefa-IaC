variable "do_token" {
description = "Token da DigitalOcean"
type        = string
sensitive   = true
}

variable "ssh_user" {
description = "Usuário para SSH"
type        = string
default     = "root"
}

variable "ssh_fingerprint" {
description = "Fingerprint da sua chave SSH pública registrada na DigitalOcean"
type        = string
}
