#!/bin/sh

# Exit script if any commands fail.
set -e

# Make sure the directory for individual app logs exists.
mkdir -p /var/log/shiny-server
chown shiny.shiny /var/log/shiny-server

# Create htpasswd.
htpasswd -bc /etc/nginx/.htpasswd $HT_USER $HT_PSWD

# Get the maximum upload file size for Nginx, default to 0: unlimited
USE_NGINX_MAX_UPLOAD=${NGINX_MAX_UPLOAD:-0}

# Generate Nginx config for maximum upload file size
echo "client_max_body_size $USE_NGINX_MAX_UPLOAD;" > /etc/nginx/conf.d/upload.conf

# Execute the arguments to this script as commands themselves.
exec "$@"
