# 02 · Configure Service Accounts and IAM Roles for Google Cloud

## 🎯 Objective
Apply the **Principle of Least Privilege**: no hardcoded keys, dedicated service accounts attached to VMs, custom IAM roles written in YAML, and BigQuery queried from Python with inherited credentials.

## 🔐 Security Architecture

![IAM architecture](../assets/02-iam-security-architecture.png)

## 🧠 Key Concepts

| Concept | What I learned |
| :-- | :-- |
| Service Account | Non-human identity attached to a VM, replaces static JSON keys |