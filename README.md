# AWS Monitoring Project

This project contains Infrastructure as Code (IaC) configurations to set up AWS infrastructure and monitoring stack using Terraform and Ansible.

## Project Structure

```
aws-monitoring-project/
├── terraform/           # AWS infrastructure provisioning
├── ansible/            # Configuration management
    ├── inventory/     # Server inventory
    ├── playbooks/     # Main playbooks
    └── roles/         # Ansible roles
        ├── common/    # Common server setup
        ├── nginx/     # Nginx configuration
        ├── apache/    # Apache configuration
        ├── node_exporter/     # Prometheus Node Exporter
        └── monitoring_stack/  # Prometheus & Grafana
```

## Prerequisites

- Terraform >= 1.0.0
- Ansible >= 2.9
- AWS CLI configured with appropriate credentials
- SSH key pair for EC2 instances

## Usage

1. Initialize Terraform:
   ```
   cd terraform
   terraform init
   ```

2. Apply Terraform configuration:
   ```
   terraform plan
   terraform apply
   ```

3. Run Ansible playbooks:
   ```
   cd ../ansible
   ansible-playbook -i inventory/hosts.ini playbooks/setup_app_instances.yml
   ansible-playbook -i inventory/hosts.ini playbooks/setup_monitoring_instance.yml
   ```

## Components

- Terraform configurations for AWS infrastructure
- Ansible playbooks for server configuration
- Monitoring stack (Prometheus + Grafana)
- Application servers (Nginx/Apache)
- Node Exporter for system metrics