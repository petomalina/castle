module "clusters" {
  source = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster-update-variant"
  version = "23.1.0"

  for_each = toset(var.clusters)

  name       = "sandcastle"
  project_id = var.project_id
  region     = each.value.region
  zones      = each.value.zones

  release_channel = "RAPID"

  create_service_account = true
  # service_account        = data.google_compute_default_service_account.default.email

  authenticator_security_group = "gke-security-groups@kiwi.com"

  network_project_id = var.xpn_project_id
  network            = var.xpn_network_id
  subnetwork         = var.xpn_subnetwork_id

  ip_range_pods     = "${var.project_id}-pods"
  ip_range_services = "${var.project_id}-services"

  enable_private_endpoint = false
  enable_private_nodes    = true
  master_ipv4_cidr_block  = var.xpn_master_cidr

  datapath_provider = "ADVANCED_DATAPATH"

  //  master_authorized_networks = local.master_authorized_networks
  // logging_enabled_components = ["SYSTEM_COMPONENTS"]

  http_load_balancing        = true
  horizontal_pod_autoscaling = true
  network_policy             = false
  identity_namespace         = "enabled"

  remove_default_node_pool = true

  node_pools = [
    {
      name = "bailey"

      machine_type = "e2-standard-4"
      # image_type   = "cos_containerd"

      initial_node_count = 1
      min_count          = 1
      max_count          = 2

      local_ssd_count = 0
      disk_size_gb    = 100
      disk_type       = "pd-standard"

      auto_repair  = true
      auto_upgrade = true
      preemptible  = true
    },
  ]

  node_pools_tags = {
    all = [
      "lb-target",
      var.project_id,
      "bailey",
    ]
  }

  node_pools_oauth_scopes = {}
}

output "cli_access" {
  value = "gcloud container clusters get-credentials ${module.gke_sandcastle.name} --region ${var.gke_region} --project ${var.project_id}"
}
