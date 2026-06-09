#!/bin/bash
# =============================================================================
# Step 4: Create Azure Container Registry (ACR)
# =============================================================================

# Variables
RESOURCE_GROUP="LDEV-docker-workshop-<yourname>"
ACR_NAME="acr-ldev-workshop-<yourname>"  # Must be globally unique, alphanumeric only

# Create ACR with Basic SKU (sufficient for workshop)
az acr create \
  --resource-group $RESOURCE_GROUP \
  --name $ACR_NAME \
  --sku Basic \
  --admin-enabled true

# Verify ACR creation
az acr show --name $ACR_NAME --output table

# Get the login server name (you'll need this later)
az acr show --name $ACR_NAME --query loginServer --output tsv
