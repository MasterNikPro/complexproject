resource "google_compute_instance" "default" {
  name         = "devops-vm"
  machine_type = "e2-medium"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }
  
metadata = {
  ssh-keys = "ubuntu:${file("${path.module}/id_rsa.pub")}"
}

  metadata_startup_script = <<-EOT
    apt update
    apt install -y docker.io docker-compose ansible
    systemctl start docker
  EOT
}
