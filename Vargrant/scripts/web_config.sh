#!/bin/bash

# Update package lists
sudo apt-get update -y

# Install Nginx and Node Exporter
sudo apt-get install -y nginx prometheus-node-exporter

# Create web directory
sudo mkdir -p /var/www/html

# Move the index.html to the web directory
sudo mv /tmp/index.html /var/www/html/index.html

# Move the nginx.conf to the correct location
sudo mv /tmp/nginx.conf /etc/nginx/sites-available/default

# Restart Nginx to apply changes
sudo systemctl start nginx
sudo systemctl enable nginx

# Install MySQL client to query the database
sudo apt-get install -y mysql-client

# Allow HTTP and Node Exporter ports through firewall
sudo ufw allow 80/tcp
sudo ufw allow 9100/tcp
sudo ufw --force enable

# Wait for the database to be ready
until mysql -h 192.168.56.11 -u root -p"password" -e "SELECT 1" &> /dev/null; do
    sleep 1
done

# Query the database and log the output
mysql -h 192.168.56.11 -u root -p"password" -e "SELECT * FROM test_db.users;" > /var/log/db_query.log
