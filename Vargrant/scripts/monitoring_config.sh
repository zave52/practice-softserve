#!/bin/bash

# Update package lists
sudo apt-get update -y

# Install Prometheus
sudo apt-get install -y prometheus

# Create Prometheus configuration file
sudo tee /etc/prometheus/prometheus.yml > /dev/null <<EOF
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'web'
    static_configs:
      - targets: ['192.168.56.10:9100']
  - job_name: 'db'
    static_configs:
      - targets: ['192.168.56.11:9104']
EOF

# Allow Prometheus port through firewall
sudo ufw allow 9090/tcp
sudo ufw --force enable

# Restart Prometheus to apply changes
sudo systemctl restart prometheus
