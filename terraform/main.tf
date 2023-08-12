terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.9.14"
    }
  }
}

provider "proxmox" {
  pm_api_url      = var.pm_api_url
  pm_tls_insecure = true

  pm_api_token_id     = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
}

resource "proxmox_lxc" "ct-sliver" {
  features {
    nesting = true
  }
  cores    = 2
  memory   = 2048
  swap     = 512
  hostname = "ct-sliver"
  network {
    name   = "eth0"
    bridge = "vmbr3"
    ip     = "172.31.0.10/24"
    gw     = "172.31.0.1"
  }
  rootfs {
    replicate = false
    storage   = "local-lvm"
    size      = "32G"
  }
  ostemplate   = "local:vztmpl/debian-12-standard_12.0-1_amd64.tar.zst"
  password     = var.root_password
  target_node  = "pve"
  unprivileged = true
  start        = true

  ssh_public_keys = <<EOF
  ${var.ssh_key}
  EOF
}