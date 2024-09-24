provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "k8s_instance" {
  ami           = "ami-0e86e20dae9224db8"  # Amazon Linux 2 AMI (find the latest for your region)
  instance_type = "t2.micro"

  tags = {
    Name = "K8s-Instance"
  }

  user_data = <<-EOF
  #!/bin/bash
  # Install Docker
  sudo yum update -y
  sudo yum install docker -y
  sudo systemctl start docker
  sudo systemctl enable docker

  # Install Kubernetes tools
  sudo curl -Lo /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
  sudo chmod +x /usr/bin/kubectl
  EOF
}

