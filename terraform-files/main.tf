resource "google_compute_instance" "deployment_instance" {
  name         = "deployment-instance"
  machine_type = "e2-medium" # You can change the machine type as per your requirements
  zone         = "us-central1-c" # You can change the zone as per your requirements
  tags         = ["web", "dev"]

  boot_disk {
    initialize_params {
      image = "Ubuntu 20.04 LTS" # Change the image as per your requirements
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    ssh-keys = "akkuverma217:${file("~/.ssh/id_rsa.pub")}"
  }
  provisioner "local-exec" {
    command = "echo $(google_compute_instance.deployment_instance.External_IP)"
  }
  provisioner "local-exec" {
    command = "ansible-playbook /var/lib/jenkins/workspace/Banking-Project/terraform-files/ansibleplaybook.yml"
  }
}
