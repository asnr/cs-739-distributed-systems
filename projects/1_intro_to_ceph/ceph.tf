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
    inline = ["echo ssh is up and accepting connections!"]

    connection {
      type = "ssh"
      user = "${var.gcp_remote_user}"
      private_key = "${file("${var.ssh_private_key}")}"
    }
  }

  provisioner "local-exec" {
    command = "ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook -u ${var.gcp_remote_user} -i '${self.network_interface.0.access_config.0.nat_ip},' --private-key ${var.ssh_private_key} --extra-vars 'hosts_var=all' ansible/ceph_admin.yaml"
  }
}

variable "ceph_node_names" {
  default = {
    "0" = "ceph-node1"
    "1" = "ceph-node2"
    "2" = "ceph-node3"
  }
}

resource "google_compute_instance" "ceph_node" {
  count = 3
  name = "${lookup(var.ceph_node_names, count.index)}"
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

  provisioner "local-exec" {
    command = "ANSIBLE_CONFIG=ansible/ansible.cfg ansible-playbook -u ${var.gcp_remote_user} -i '${self.network_interface.0.access_config.0.nat_ip},' --private-key ${var.ssh_private_key} --extra-vars 'hosts_var=all' ansible/ceph_node.yaml"
  }
}
