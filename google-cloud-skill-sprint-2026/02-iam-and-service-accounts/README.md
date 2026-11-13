# 02 · Configure Service Accounts and IAM Roles for Google Cloud

## 🎯 Objective
Apply the **Principle of Least Privilege**: no hardcoded keys, dedicated service accounts attached to VMs, custom IAM roles written in YAML, and BigQuery queried from Python with inherited credentials.

## 🔐 Security Architecture

![IAM architecture](../assets/02-iam-security-architecture.png)

## 🧠 Key Concepts

| Concept | What I learned |
| :-- | :-- |
| Service Account | Non-human identity attached to a VM, replaces static JSON keys |
| Custom Role (YAML) | Pick only the permissions needed, e.g. `cloudsql.instances.get` + `connect` |
| Role stages | `ALPHA`, `BETA`, `GA`, `DISABLED`; deleted roles can be undeleted |
| etag | Concurrency token: read-modify-write policies without overwriting others' edits |
| Application Default Credentials | Client libraries pick up the VM's identity automatically |
