# 04 · Store, Process, and Manage Data on Google Cloud – Console

## 🎯 Objective
Built a fully automated, event-driven image pipeline: every upload triggers thumbnail generation and an asynchronous Pub/Sub notification.

## 🏗️ Serverless Event-Driven Architecture

![Serverless pipeline](../assets/serverless-pipeline-architecture.png)

## 🧩 Components

| Service | Role | Config |
| :-- | :-- | :-- |
| Cloud Storage | Image ingress + thumbnail output | bucket in `us-central1` |
| Eventarc | Trigger | `google.cloud.storage.object.v1.finalized` |
| Cloud Run Functions | Processing | 2nd gen, Node.js 22, entry point `generateThumbnail` |
| `sharp` | Image resize | 64×64 |
| Pub/Sub | Notifications | topic `thumbnail-events` |
