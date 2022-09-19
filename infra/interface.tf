variable "project_id" {
  type    = string
}

variable "clusters" {
  type = list(object({
    name   = string
    region = string
    zones  = list(string)

    xpn_network_id  = string
    xpn_subnet_id   = string
    xpn_master_cidr = string
  }))

  default = []
}