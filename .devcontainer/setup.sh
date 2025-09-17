#!/bin/bash
set -e

echo "🔧 Starting environment setup..."

# Update & install prerequisites
sudo apt-get update && sudo apt-get install -y \
    gnupg \
    software-properties-common \
    wget \
    unzip \
    apt-transport-https \
    lsb-release \
    tree

echo "✅ Basic packages installed."

########################
# Install Terraform
########################
echo "📦 Installing Terraform..."

wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt-get update && sudo apt-get install -y terraform

echo "✅ Terraform installed."

########################
# Install PowerShell
########################
echo "⚡ Installing PowerShell..."

source /etc/os-release

wget -q https://packages.microsoft.com/config/ubuntu/$VERSION_ID/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

sudo apt-get update && sudo apt-get install -y powershell

echo "✅ PowerShell installed."

########################
# Install AWS CLI
########################
echo "☁️ Installing AWS CLI..."

cd /tmp
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip -q awscliv2.zip
sudo ./aws/install
rm -rf aws awscliv2.zip

echo "✅ AWS CLI installed."

echo "🎉 All tools are set up and ready to go!"
