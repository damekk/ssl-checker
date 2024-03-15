#!/bin/bash

# Path to Apache configuration files
APACHE_CONFIG_PATH="/etc/apache2/sites-enabled"

# Function to get the expiration date in seconds and domain
get_ssl_expiry() {
    local domain=$1
    local expiry_date=$(openssl s_client -connect $domain:443 -servername $domain 2>/dev/null \
                        | openssl x509 -noout -enddate \
                        | cut -d= -f2)

    if [ -n "$expiry_date" ]; then
        date --date="$expiry_date" '+%s %F' # Outputs expiry date in seconds and in YYYY-MM-DD format
    fi
}

# Find all ServerName and ServerAlias from Apache configs
SERVER_NAMES=$(grep -h -E '^\s*(ServerName|ServerAlias)' $APACHE_CONFIG_PATH/* | awk '{print $2}' | sort -u)

# Check SSL certificate expiration date for each unique domain and sort them
for domain in $SERVER_NAMES; do
    echo "Checking $domain..."
    get_ssl_expiry $domain
done | sort -n | while read expiry_seconds expiry_date domain; do
    # Calculate days until expiration
    expiry_days=$(( (expiry_seconds - $(date +%s)) / 86400 ))
    echo "$domain expires on $expiry_date ($expiry_days days)"
done
