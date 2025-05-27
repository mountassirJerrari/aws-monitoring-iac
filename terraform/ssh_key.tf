
# Resource 1: Generate an RSA private key using the 'tls' provider.
resource "tls_private_key" "project_ssh_key" {
  algorithm = "RSA"

  rsa_bits = 4096
}

# Resource 2: Create an EC2 key pair in AWS using the 'aws' provider.
resource "aws_key_pair" "project_key_pair" {
  key_name = var.ssh_key_name

  public_key = tls_private_key.project_ssh_key.public_key_openssh
}

# Resource 3: Save the generated private key to a local file.
resource "local_file" "ssh_private_key_pem" {
  content         = tls_private_key.project_ssh_key.private_key_pem
  filename        = var.ssh_private_key_filename
  file_permission = "0600"
}
