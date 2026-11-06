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
