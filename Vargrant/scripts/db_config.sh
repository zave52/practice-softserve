#!/bin/bash

# Update package lists
sudo apt-get update -y

# Pre-configure MySQL root password
echo "mysql-server mysql-server/root_password password password" | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password password" | sudo debconf-set-selections

# Install MySQL Server
sudo apt-get install -y mysql-server

# Configure MySQL to listen on all interfaces
sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf

# Restart MySQL to apply changes
sudo systemctl restart mysql

# Create database and user
sudo mysql -u root -p"password" -e "CREATE DATABASE IF NOT EXISTS test_db;"
sudo mysql -u root -p"password" -e "CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY 'password';"
sudo mysql -u root -p"password" -e "GRANT ALL PRIVILEGES ON test_db.* TO 'root'@'%';"
sudo mysql -u root -p"password" -e "FLUSH PRIVILEGES;"

# Create table and insert data
sudo mysql -u root -p"password" -e "USE test_db; CREATE TABLE IF NOT EXISTS users (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255));"
sudo mysql -u root -p"password" -e "USE test_db; INSERT INTO users (id, name) VALUES (1, 'Alice'), (2, 'Bob');"

# Install MySQL exporter
wget https://github.com/prometheus/mysqld_exporter/releases/download/v0.14.0/mysqld_exporter-0.14.0.linux-amd64.tar.gz
tar xvfz mysqld_exporter-0.14.0.linux-amd64.tar.gz
sudo cp mysqld_exporter-0.14.0.linux-amd64/mysqld_exporter /usr/local/bin/
sudo chmod +x /usr/local/bin/mysqld_exporter

# Create a service for the MySQL exporter
sudo tee /etc/systemd/system/mysqld_exporter.service > /dev/null <<EOF
[Unit]
Description=Prometheus MySQL Exporter
After=network.target

[Service]
User=root
Group=root
Type=simple
ExecStart=/usr/local/bin/mysqld_exporter --config.my-cnf /root/.my.cnf

[Install]
WantedBy=multi-user.target
EOF

# Create the .my.cnf file for the MySQL exporter
sudo tee /root/.my.cnf > /dev/null <<EOF
[client]
user=root
password=password
EOF

# Start and enable the MySQL exporter service
sudo systemctl daemon-reload
sudo systemctl start mysqld_exporter
sudo systemctl enable mysqld_exporter

# Allow MySQL and MySQL Exporter ports through firewall
sudo ufw allow 3306/tcp
sudo ufw allow 9104/tcp
sudo ufw --force enable