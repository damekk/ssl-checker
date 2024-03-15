# SSL Certificate Expiration Checker

This script checks the SSL certificate expiration dates for domains configured in Apache's configuration files. It outputs a list of domains and their certificate expiration dates, sorted by the closest expiration date.

## Features

- Parses Apache configuration files to find configured domains.
- Checks the expiration date of SSL certificates for each domain.
- Sorts domains by the certificate expiration date.
- Displays the number of days until each certificate expires.

## Prerequisites

- Linux environment with Bash
- `openssl` and `grep` commands available
- Access to Apache configuration files


## Usage

Run the script with sufficient permissions to access Apache's configuration files. Typically, this means running the script as root or using `sudo`:

```bash
sudo ./check_ssl_expiry.sh
