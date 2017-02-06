provider "aws" {
  region = "${var.region}"
}

resource "aws_instance" "spaceship" {
  ami = "${var.image_id}"
  instance_type = "${var.instance_type}"
  associate_public_ip_address = "${var.enable_public_ip}"
  key_name = "${var.key_pair}"
  vpc_security_group_ids = ["${var.sg_id}"]

  provisioner "remote-exec" {
    inline = [
      "mkdir /tmp/puppet"
    ]
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file("${var.private_key_path}")}"
    }
  }

  provisioner "file" {
    source = "manifests/"
    destination = "/tmp/puppet/"
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file("${var.private_key_path}")}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply /tmp/puppet/site.pp --modulepath=/tmp/puppet/modules --hiera_config=/tmp/puppet/hiera.yaml"
    ]
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = "${file("${var.private_key_path}")}"
    }
  }
}
