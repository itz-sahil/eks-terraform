resource "aws_instance" "ec2_instance" {
  depends_on = [
    local_file.key_file
  ]
	ami  = var.ami_ec2
 	instance_type = var.instance_type_ec2
	key_name = aws_key_pair.generated_key.key_name
  subnet_id = var.public_subnet_1_id
  vpc_security_group_ids = [var.security_group_ec2]

  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = local_file.key_file.content
    host     = self.public_ip
  }

  provisioner "file" {
    source      = "./ec2/files/script.sh"
    destination = "/home/ubuntu/script.sh"
  }

  provisioner "file" {
    source      = "./ec2/files/covid.yml"
    destination = "/home/ubuntu/covid.yml"
  }

  provisioner "file" {
    source      = "./ec2/files/ingress.yml"
    destination = "/home/ubuntu/ingress.yml"
  }

  provisioner "file" {
    source      = "./ec2/files/myapp.yml"
    destination = "/home/ubuntu/myapp.yml"
  }

  provisioner "remote-exec" {
    inline = [
      "cd ~",
      "chmod +x /home/ubuntu/script.sh",
      "bash script.sh",
    ]
  }

	tags = {
		Name = "Controller Node"
	}
}
