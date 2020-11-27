#!/bin/bash
#
# provision.sh
#
# Need to sort out the versioning of the software installed, but that can be done later

sudo apt update && sudo apt upgrade

# Install nginx
sudo apt install nginx -y

# Set up the reverse proxy with nginx
# Unlink this default config file
sudo unlink /etc/nginx/sites-enabled/default

# Copy made nginx file to the correct place
sudo cp /home/vagrant/configs/proxy_config.conf /etc/nginx/sites-available/proxy_config.conf

# Sort out the activation with this soft link, so on by default
# Don't link from the configs file just cause this location is where
# one would look for it
sudo ln -s /etc/nginx/sites-available/proxy_config.conf /etc/nginx/sites-enabled/proxy_config.conf

# Restart Nginx.service
sudo systemctl restart nginx.service


# Install git
sudo apt install git -y

# Install nodejs
sudo apt install nodejs -y

# Install npm (needs to do separately)
sudo apt install npm -y

# Install pm2 with npm
sudo npm install pm2 -g

#  Setting bash env doesn't work with pm2 seemingly, so does manually later
 echo "export DB_HOST='192.168.33.20'" >> ~/.bashrc
# # have to do this otherwise doesn't seem to work
 export DB_HOST='192.168.33.20'
# # read .bashrc
# source ~/.bashrc
# go to app and run
cd /app

# Point to DB_HOST, need to find a way to take this from a Vagrantfile
# Works fine though
# Don't need DB_PORT since MongoDB assigned to 0.0.0.0 which listens across all ports
# DB_HOST=192.168.33.20 pm2 start app.js

# update-env updates environment variables to be used by vagrant
pm2 start app.js --update-env
