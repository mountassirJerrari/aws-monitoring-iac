# ------------------------------------------------------------------------------
# Security Groups
# ------------------------------------------------------------------------------

# --- Variables for Security Groups (add these to terraform/variables.tf) ---
# variable "ssh_access_cidr" {
#   description = "CIDR block allowed for SSH access. For learning, using 0.0.0.0/0. NOT FOR PRODUCTION without other controls."
#   type        = string
#   default     = "0.0.0.0/0"
# }
# --- End of Variables for Security Groups ---

# 1. Security Group for the Monitoring Instance
resource "aws_security_group" "monitoring_sg" {
  name        = "monitoring-instance-sg"
  description = "Allow SSH, Prometheus, and Grafana access"
  vpc_id      = aws_vpc.main_vpc.id # Associate with our VPC

  # Ingress (inbound) rules
  ingress {
    description = "SSH from anywhere (for learning purposes)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_access_cidr] # Uses the variable
  }

  ingress {
    description = "Prometheus access from anywhere"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Or restrict to your IP if stable, or VPC CIDR if only internal access needed initially
  }

  ingress {
    description = "Grafana access from anywhere"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Or restrict as above
  }

  # Egress (outbound) rules
  # Allow all outbound traffic by default. This is common but can be restricted further if needed.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # "-1" means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "project-monitoring-sg"
    Project     = "AWS Monitoring Project"
    Environment = "Dev"
  }
}

# 2. Security Group for the Application Instances (App1 & App2)
resource "aws_security_group" "app_sg" {
  name        = "app-instance-sg"
  description = "Allow SSH, HTTP/S (for web apps), and Node Exporter access"
  vpc_id      = aws_vpc.main_vpc.id # Associate with our VPC

  # Ingress (inbound) rules
  ingress {
    description = "SSH from anywhere (for learning purposes)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_access_cidr] # Uses the variable
  }

  ingress {
    description = "HTTP access for web applications"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow web traffic from anywhere
  }

  ingress {
    description = "HTTPS access for web applications (if you set up SSL)"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow web traffic from anywhere
  }

  ingress {
    description = "Node Exporter access from Monitoring Instance SG"
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    # This allows traffic specifically from any instance that is part of the 'monitoring_sg'
    security_groups = [aws_security_group.monitoring_sg.id]
  }

  # Egress (outbound) rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "project-app-sg"
    Project     = "AWS Monitoring Project"
    Environment = "Dev"
  }
}
