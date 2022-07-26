variable "proxmox_host" {
    default = ""
}

variable "api_token_id" {
    default = ""
    sensitive=true
}
variable "api_token_secret" {
    default = ""
    sensitive=true
}

variable "ubuntu_password" {
    default = ""
    sensitive=true
}

variable "ubuntu_ssh" {
    default = ""
}

variable "ubuntu_ip" {
    default = ""
}

variable "truenas_ip" {
    default = ""
}

variable "ubuntu_gateway" {
    default = ""
}