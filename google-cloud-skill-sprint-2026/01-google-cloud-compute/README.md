# 01 · The Basics of Google Cloud Compute

## 🎯 Objective
Core IaaS operations on Google Cloud: provisioning Linux VMs from Console and `gcloud`, attaching persistent block storage, deploying NGINX and exposing it through a VPC firewall rule.

## 🏗️ Architecture

![Compute architecture](../assets/01-compute-architecture.png)

## 🧠 Hands-On Steps

| Step | What I did | Command / Setting |
| :-: | :-- | :-- |
| 1 | Set default zone | `gcloud config set compute/zone us-central1-a` |
| 2 | Created VM with network tag | `--machine-type=e2-medium --tags=http-server` |
| 3 | Created standalone disk | `gcloud compute disks create data-disk --type=pd-balanced` |
| 4 | Attached, formatted (ext4), mounted disk | `mkfs.ext4` → `mount /dev/sdb /mnt/disks/data` |
| 5 | Made mount persistent | entry in `/etc/fstab` |
| 6 | Installed NGINX over SSH | `apt-get install -y nginx` |
| 7 | Opened port 80 | firewall rule `allow-http` → target tag `http-server` |

Full reusable script: [`setup-commands.sh`](./setup-commands.sh)

## 🔍 Concepts at a Glance

| Concept | Why it matters |
| :-- | :-- |
| Persistent Disk | Data lives independently of the VM boot disk |
| Network tags | Firewall rules apply only to tagged VMs, not the whole VPC |
| Ingress firewall rule | VPC denies inbound traffic by default; must be explicitly allowed |
| `gcloud` defaults | Set region/zone once, shorter commands afterwards |

## 💡 Engineering Takeaways
- **Lifecycle decoupling:** keep data on a secondary disk so VM boot disks can be recreated or upgraded safely.
- **Tag-based exposure:** bind firewall rules to tags (`http-server`) so only intended web VMs are reachable.
- **Persist mounts:** without `/etc/fstab`, the disk is unmounted after reboot.