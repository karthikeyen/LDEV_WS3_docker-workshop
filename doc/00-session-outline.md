# Learning Session: Containerize & Deploy a Node.js API to Azure Container Registry

## Format: Connect → Concept → Concrete

### Connect (10 min)
- Why containers? Discussion on "works on my machine" problem
- Real-world scenario: Your team builds a Web API, how do you ship it consistently?
- Quick poll: Who has used Docker? Who has deployed to Azure?

### Concept (15 min)
- Docker image vs container
- Dockerfile anatomy (using our sample app)
- Azure Container Registry (ACR) – private Docker registry in Azure
- Workflow: Code → Build Image → Push to ACR → Host as Container Instance

### Concrete Practice (45 min)
Participants follow scripts 01–07 to:
1. Login to Azure (Visual Studio Professional subscription)
2. Clone this repo
3. Create a Resource Group
4. Create an Azure Container Registry
5. Build & push the Docker image to ACR
6. Deploy as Azure Container Instance
7. Modify the code, rebuild, redeploy & verify changes

---

## Prerequisites
- Azure subscription (Visual Studio Professional)
- Azure CLI installed (`az --version`)
- Docker Desktop installed
- Git installed
