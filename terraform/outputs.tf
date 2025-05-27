
output "aws_key_pair_name_output" {
  value = aws_key_pair.project_key_pair.key_name

  description = "The name of the AWS EC2 key pair that was created/ensured in AWS."
}

output "private_key_filename_output" {
  value = local_file.ssh_private_key_pem.filename

  description = "The filename of the generated private SSH key. This file is located in your 'terraform/' directory. IMPORTANT: Keep this file secure and do not commit it to version control!"
}
output "monitoring_server_public_ip" {
  description = "Public IP address of the Monitoring server."
  value       = aws_instance.monitoring_server.public_ip
}

output "monitoring_server_private_ip" {
  description = "Private IP address of the Monitoring server."
  value       = aws_instance.monitoring_server.private_ip
}

output "app_server_1_public_ip" {
  description = "Public IP address of App Server 1."
  value       = aws_instance.app_server_1.public_ip
}

output "app_server_1_private_ip" {
  description = "Private IP address of App Server 1."
  value       = aws_instance.app_server_1.private_ip
}

output "app_server_2_public_ip" {
  description = "Public IP address of App Server 2."
  value       = aws_instance.app_server_2.public_ip
}

output "app_server_2_private_ip" {
  description = "Private IP address of App Server 2."
  value       = aws_instance.app_server_2.private_ip
}
