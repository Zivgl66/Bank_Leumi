#!/bin/bash

# Update the system
sudo apt update -y

# Install Java (Jenkins requires Java)
sudo apt install fontconfig openjdk-17-jre -y

# Install Jenkins
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt-get install jenkins -y

# Start and enable Jenkins service
sudo systemctl daemon-reload
sudo systemctl start jenkins
sudo systemctl enable jenkins


# Open Jenkins initial admin password location
echo "Jenkins is installed. You can access it on http://your-ec2-instance-public-ip:8080"
echo "The initial admin password is located at: /var/lib/jenkins/secrets/initialAdminPassword"
