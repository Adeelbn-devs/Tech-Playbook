# 03 · Create Your First Gemini Enterprise Application

## 🎯 Objective
Built an enterprise-ready, grounded GenAI assistant with Gemini Enterprise: structured + unstructured data sources, Identity Provider (IdP) access control, metadata-driven RAG and Deep Research agents.

## 🏗️ Architecture

![Gemini Enterprise RAG](../assets/03-gemini-rag-architecture.png)

## 🧠 Key Components

| Component | Role | Takeaway |
| :-- | :-- | :-- |
| Cloud Storage + Drive connectors | Data sources | Connected with IdP so ACLs are preserved |
| IdP / ACL enforcement | Security | Users only get answers from documents they may access |
| Metadata-driven RAG | Retrieval | PDFs (semantic) + JSON `structData` (exact filters) |