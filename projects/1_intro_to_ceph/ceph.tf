provider "google" {
  credentials = "${file("${var.credentials_file}")}"
  project     = "intro-to-ceph"
  region      = "us-west1"
}

resource "google_compute_instance" "ceph_admin" {
  name = "ceph-admin"
  machine_type = "n1-standard-1"
  zone = "us-west1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  provisioner "remote-exec" {
    inline = ["echo Hello World!"]

    connection {
      type = "ssh"
      user = "${var.gcp_remote_user}"
      private_key = "${file("${var.ssh_private_key}")}"
    }
  }
}

resource "google_compute_instance" "ceph_node" {
  name = "ceph-node"
  machine_type = "n1-standard-1"
  zone = "us-west1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }
}
