#!/bin/bash

# Update system packages
yum update -y

# Start and enable nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# Set proper permissions
sudo chown nginx:nginx /var/www/html
sudo chmod 644 /var/www/html

# Configure nginx to serve the health check
sudo cat > /etc/nginx/conf.d/health.conf << EOF
server {
    listen 80;
    server_name _;

    root /var/www/html;

    location / {
        index index.html;
    }

    location /health {
        access_log off;
        return 200 '{"status":"healthy"}';
        add_header Content-Type application/json;
    }
}

EOF

# Test nginx configuration and reload
sudo nginx -t && sudo systemctl reload nginx


# Log the completion
echo "User data script completed at $(date)" >> /var/log/user-data.log
