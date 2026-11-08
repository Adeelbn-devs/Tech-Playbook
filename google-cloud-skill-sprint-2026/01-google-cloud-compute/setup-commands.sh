#!/bin/bash
# Reusable gcloud setup: Compute Engine VM + Persistent Disk + VPC firewall + NGINX
set -euo pipefail

# 1. Defaults
gcloud config set compute/region us-central1
gcloud config set compute/zone us-central1-a

# 2. Create VM with HTTP tag
gcloud compute instances create web-server-vm \
  --machine-type=e2-medium \
  --image-family=debian-12 \
  --image-project=debian-cloud \
  --tags=http-server