#!/bin/bash
# =============================================================================
# Step 6: Deploy as Azure Container Instance (ACI)
# =============================================================================

# Variables
RESOURCE_GROUP="rg-docker-workshop-<yourname>"
ACR_NAME="acrworkshop<yourname>"
IMAGE_NAME="docker-workshop-api"
IMAGE_TAG="v1"
CONTAINER_NAME="aci-workshop-<yourname>"

# Get ACR credentials
ACR_LOGIN_SERVER=$(az acr show --name $ACR_NAME --query loginServer --output tsv)
ACR_PASSWORD=$(az acr credential show --name $ACR_NAME --query "passwords[0].value" --output tsv)

# Create Azure Container Instance
az container create \
  --resource-group $RESOURCE_GROUP \
  --name $CONTAINER_NAME \
  --image $ACR_LOGIN_SERVER/$IMAGE_NAME:$IMAGE_TAG \
  --registry-login-server $ACR_LOGIN_SERVER \
  --registry-username $ACR_NAME \
  --registry-password $ACR_PASSWORD \
  --dns-name-label $CONTAINER_NAME \
  --ports 3000 \
  --os-type Linux

# Get the public URL
az container show \
  --resource-group $RESOURCE_GROUP \
  --name $CONTAINER_NAME \
  --query "ipAddress.fqdn" \
  --output tsv

# Test the deployed API (replace FQDN with the output above)
echo "Test your API at: http://<FQDN>:3000"
# curl http://<FQDN>:3000
