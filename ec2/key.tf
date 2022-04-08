// Creating Key
resource "tls_private_key" "tls_key" {
  algorithm = "RSA"
}

// Generating Key-Value Pair
resource "aws_key_pair" "generated_key" {
  key_name   = "eks-key"
  public_key = tls_private_key.tls_key.public_key_openssh

  depends_on = [
    tls_private_key.tls_key
  ]
}

### Private Key PEM File ###
resource "local_file" "key_file" {
  content  = tls_private_key.tls_key.private_key_pem
  filename = "eks-key.pem"

  depends_on = [
    tls_private_key.tls_key
  ]
}
