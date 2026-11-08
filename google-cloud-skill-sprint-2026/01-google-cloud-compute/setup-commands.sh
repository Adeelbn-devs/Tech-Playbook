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

  # 3. Create & attach a 50GB persistent disk
gcloud compute disks create data-disk --size=50GB --type=pd-balanced
gcloud compute instances attach-disk web-server-vm --disk=data-disk

# 4. Firewall rule allowing HTTP (port 80) to tagged instances
gcloud compute firewall-rules create allow-http \
  --direction=INGRESS \
  --allow=tcp:80 \