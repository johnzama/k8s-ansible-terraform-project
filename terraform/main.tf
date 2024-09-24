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

output "instance_public_ip" {
  value = aws_instance.k8s_instance.public_ip
  description = "The public IP of the EC2 instance"
}

output "instance_public_dns" {
  value = aws_instance.k8s_instance.public_dns
  description = "The public DNS of the EC2 instance"
}
