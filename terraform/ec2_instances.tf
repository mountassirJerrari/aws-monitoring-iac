

# Data source to get the latest Ubuntu 22.04 LTS AMI ID in the current region
data "aws_ami" "ubuntu_jammy" {
  most_recent = true
  owners      = ["099720109477"] # Canonical's AWS account ID for official Ubuntu AMIs

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# 1. Monitoring Instance (Prometheus, Grafana)
resource "aws_instance" "monitoring_server" {
  ami           = data.aws_ami.ubuntu_jammy.id # Use the dynamically found Ubuntu AMI
  instance_type = var.instance_type_monitoring
  key_name      = aws_key_pair.project_key_pair.key_name

  subnet_id                   = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.monitoring_sg.id]

  tags = {
    Name        = "project-monitoring-server"
    Project     = "AWS Monitoring Project"
    Environment = "Dev"
    Role        = "Monitoring"
  }
}

# 2. Application Instance 1 (e.g., Nginx + Node Exporter)
resource "aws_instance" "app_server_1" {
  ami           = data.aws_ami.ubuntu_jammy.id
  instance_type = var.instance_type_app
  key_name      = aws_key_pair.project_key_pair.key_name

  subnet_id                   = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.app_sg.id] # Use the app security group

  tags = {
    Name        = "project-app-server-1"
    Project     = "AWS Monitoring Project"
    Environment = "Dev"
    Role        = "AppServer1"
    App         = "Nginx"
  }
}

# 3. Application Instance 2 (e.g., Apache + Node Exporter)
resource "aws_instance" "app_server_2" {
  ami           = data.aws_ami.ubuntu_jammy.id
  instance_type = var.instance_type_app
  key_name      = aws_key_pair.project_key_pair.key_name

  subnet_id                   = aws_subnet.public_subnet.id
  associate_public_ip_address = true
  security_groups             = [aws_security_group.app_sg.id] # Use the app security group

  tags = {
    Name        = "project-app-server-2"
    Project     = "AWS Monitoring Project"
    Environment = "Dev"
    Role        = "AppServer2"
    App         = "Apache"
  }
}
