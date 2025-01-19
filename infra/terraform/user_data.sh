#!/bin/bash

set -e
LOG_FILE="/var/log/installation.log"

# Ensure the log file exists and is writable
sudo touch $LOG_FILE
sudo chmod 666 $LOG_FILE

echo "Starting installation process..." | tee -a $LOG_FILE

# Update packages
echo "Updating packages..." | tee -a $LOG_FILE
if sudo apt update &>> $LOG_FILE; then
  echo "Package update completed successfully." | tee -a $LOG_FILE
else
  echo "Package update failed. Check the log at $LOG_FILE for details." | tee -a $LOG_FILE
  exit 1
fi

# Install Git, Docker, and Docker Compose
echo "Installing Git, Docker, and Docker Compose..." | tee -a $LOG_FILE
if sudo apt install -y git docker.io docker-compose &>> $LOG_FILE; then
  echo "Git, Docker, and Docker Compose installed successfully." | tee -a $LOG_FILE
else
  echo "Installation of Git, Docker, or Docker Compose failed. Check the log at $LOG_FILE for details." | tee -a $LOG_FILE
  exit 1
fi

# Verify Git installation
if git --version &>> $LOG_FILE; then
  echo "Git is installed: $(git --version)" | tee -a $LOG_FILE
else
  echo "Git installation verification failed." | tee -a $LOG_FILE
  exit 1
fi

# Add Docker group and assign user
echo "Configuring Docker group..." | tee -a $LOG_FILE
sudo groupadd docker &>> $LOG_FILE || echo "Docker group already exists." | tee -a $LOG_FILE
sudo usermod -aG docker $USER &>> $LOG_FILE
newgrp docker
echo "Docker group configuration completed successfully." | tee -a $LOG_FILE

# Verify Docker installation
if docker --version &>> $LOG_FILE; then
  echo "Docker is installed: $(docker --version)" | tee -a $LOG_FILE
else
  echo "Docker installation verification failed." | tee -a $LOG_FILE
  exit 1
fi

# Install Minikube
echo "Downloading and installing Minikube..." | tee -a $LOG_FILE
if curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64 &>> $LOG_FILE &&
   sudo install minikube-linux-amd64 /usr/local/bin/minikube &>> $LOG_FILE &&
   rm minikube-linux-amd64; then
  echo "Minikube installed successfully." | tee -a $LOG_FILE
else
  echo "Minikube installation failed. Check the log at $LOG_FILE for details." | tee -a $LOG_FILE
  exit 1
fi

# Verify Minikube installation
if minikube version &>> $LOG_FILE; then
  echo "Minikube is installed: $(minikube version)" | tee -a $LOG_FILE
else
  echo "Minikube installation verification failed." | tee -a $LOG_FILE
  exit 1
fi

# Install Kubectl
echo "Installing Kubectl..." | tee -a $LOG_FILE
if sudo snap install kubectl --classic &>> $LOG_FILE; then
  echo "Kubectl installed successfully." | tee -a $LOG_FILE
else
  echo "Kubectl installation failed. Check the log at $LOG_FILE for details." | tee -a $LOG_FILE
  exit 1
fi

# Verify Kubectl installation
if kubectl version --client &>> $LOG_FILE; then
  echo "Kubectl is installed: $(kubectl version --client --short)" | tee -a $LOG_FILE
else
  echo "Kubectl installation verification failed." | tee -a $LOG_FILE
  exit 1
fi

echo "Installation process completed successfully!" | tee -a $LOG_FILE
