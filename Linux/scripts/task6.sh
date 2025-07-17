#!/bin/bash

sudo useradd -s /bin/bash admin_user -p 1qazcde3

sudo mkdir -m 1777 /server
sudo mkdir -m 3770 /server/admin

sudo chown admin_user:admin_user /server
sudo chown admin_user:admin_user /server/admin


sudo useradd -s /bin/bash test1_user -p testpassword
sudo useradd -s /bin/bash test2_user -p testpassword

sudo mkdir -m 3750 /server/test1_user
sudo mkdir -m 3750 /server/test2_user

sudo chown test1_user:admin_user /server/test1_user
sudo chown test2_user:admin_user /server/test2_user

sudo ln -s /server/test1_user /server/admin/test1_user
sudo ln -s /server/test2_user /server/admin/test2_user


























# sudo useradd -m -s /bin/bash -G file_sharers admin_user

# # Create a test user and add to the group
# sudo useradd -m -s /bin/bash -G file_sharers test_user

# # Create the main server directory and the admin directory
# sudo mkdir -p /server/admin
# sudo mkdir -p /server/test_user

# # Set ownership and permissions for the admin directory
# sudo chown admin_user:file_sharers /server/admin
# sudo chmod 750 /server/admin

# # Set ownership and permissions for the user directory
# sudo chown test_user:file_sharers /server/test_user
# sudo chmod 770 /server/test_user

# # Set up ACLs for the admin directory
# sudo setfacl -d -m u::rwx,g::r-x,o::--- /server/admin
# sudo setfacl -m u:admin_user:rwx /server/admin

# # Set up ACLs for the user directory
# sudo setfacl -d -m u::rwx,g::---,o::--- /server/test_user
# sudo setfacl -m u:test_user:rwx /server/test_user


# # Configure SSH to chroot users
# echo "
# Match Group file_sharers
#     ChrootDirectory /server/%u
#     ForceCommand internal-sftp
# " | sudo tee -a /etc/ssh/sshd_config

# # Restart SSH service
# sudo service ssh restart
