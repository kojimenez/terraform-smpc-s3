provider "aws" {
  region = var.aws_region
}

data "aws_ami" "ubuntu_22-04" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "main-server" {
  ami           = data.aws_ami.ubuntu_22-04.id
  instance_type = var.main-server_instance_type
  subnet_id     = aws_subnet.public[0].id
  security_groups = [aws_security_group.ec2_main-server.id]
  key_name      = var.key_pair_name

  # Root storage
  root_block_device {
    volume_type = "gp3"
    volume_size = 20        # Recommended for Airflow (default AMI is only 8GB)
    iops        = 3000      # Default gp3 IOPS
    throughput  = 125       # Default gp3 throughput (MB/s)
    encrypted   = true
  }

  tags = {
    Name = "main-server"
    Environment = var.environment
  }
}

resource "aws_instance" "app-server" {
  ami           = data.aws_ami.ubuntu_22-04.id
  instance_type = var.app-server_instance_type
  subnet_id     = aws_subnet.public[1].id
  security_groups = [aws_security_group.ec2_main-server.id]
  key_name      = var.key_pair_name

  # Root storage
  root_block_device {
    volume_type = "gp3"
    volume_size = 20        # Recommended for Airflow (default AMI is only 8GB)
    iops        = 3000      # Default gp3 IOPS
    throughput  = 125       # Default gp3 throughput (MB/s)
    encrypted   = true
  }

  tags = {
    Name = "app-server"
    Environment = var.environment
  }
}

resource "aws_instance" "airflow" {
  ami           = data.aws_ami.ubuntu_22-04.id
  instance_type = var.airflow_instance_type
  subnet_id     = aws_subnet.public[1].id
  security_groups = [aws_security_group.ec2_main-server.id]
  key_name      = var.key_pair_name

  # Root storage
  root_block_device {
    volume_type = "gp3"
    volume_size = 20        # Recommended for Airflow (default AMI is only 8GB)
    iops        = 3000      # Default gp3 IOPS
    throughput  = 125       # Default gp3 throughput (MB/s)
    encrypted   = true
  }

  tags = {
    Name = "airflow"
    Environment = var.environment
  }
}

