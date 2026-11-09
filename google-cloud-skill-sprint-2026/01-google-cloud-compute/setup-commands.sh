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
  --target-tags=http-server \
  --description="Allow incoming HTTP traffic"

  # 5. Connect, then run the commands below INSIDE the VM
gcloud compute ssh web-server-vm

# ---- inside the VM ----
# sudo mkfs.ext4 -m 0 -E lazy_itable_init=0,lazy_journal_init=0,discard /dev/sdb
# sudo mkdir -p /mnt/disks/data
# sudo mount -o discard,defaults /dev/sdb /mnt/disks/data
# echo "UUID=$(sudo blkid -s UUID -o value /dev/sdb) /mnt/disks/data ext4 discard,defaults,nofail 0 2" | sudo tee -a /etc/fstab
# sudo apt-get update && sudo apt-get install -y nginx
# sudo systemctl enable --now nginx