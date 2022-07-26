provider "proxmox" {
    pm_api_url = "https://${var.proxmox_host}:8006/api2/json"
    pm_tls_insecure = true

    pm_api_token_id = "${var.api_token_id}"
    pm_api_token_secret = "${var.api_token_secret}"
}

resource "proxmox_lxc" "ubuntu" {
    vmid = 200
    count = 1
    target_node  = "pve"
    hostname     = "ubuntu"
    ostemplate   = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
    password     = "${var.ubuntu_password}"

    ssh_public_keys = <<-EOT
        ${var.ubuntu_ssh}
    EOT

    onboot = true
    start = true

    unprivileged = true

    cores = 8
    memory = 8192
    swap = 512

    features {
        nesting = true
    }

    // Terraform will crash without rootfs defined
    rootfs {
        storage = "local-lvm"
        size    = "32G"
    }

    network {
        name = "eth0"
        bridge = "vmbr0"
        ip = "${var.ubuntu_ip}/24"
        gw = "${var.ubuntu_gateway}"
    }
}

resource "proxmox_vm_qemu" "truenas" {
    count = 1
    name = "truenas"
    target_node = "pve"
    iso = "local:iso/TrueNAS-SCALE-22.02.2.1.iso"
    vmid = 100
    agent = 1

    cores = 2
    memory = 8192
    balloon = 0

    oncreate = false
    onboot = true

    disk {
        storage = "local-lvm"
        type = "scsi"
        size = "32G"
    }

    network {
        bridge    = "vmbr0"
        firewall  = false
        link_down = false
        model     = "e1000"
    }
}