#!/bin/bash
# =============================================================================
# Step 6: Deploy as Azure Container Instance (ACI)
# =============================================================================

# Variables
# RESOURCE_GROUP="LDEV-docker-workshop-<yourname>"

RESOURCE_GROUP="LDEV-docker-workshop-karthik"
# ACR_NAME="acrldev<yourname>"
ACR_NAME="acrldevkarthik"
IMAGE_NAME="docker-workshop-api-image"
IMAGE_TAG="v1"
# CONTAINER_NAME="ldev-web-api-container-<yourname>"  # Must be unique within Azure region
CONTAINER_NAME="ldev-web-api-container-karthik"  # Must be unique within Azure region

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
  --ports 80 \
  --cpu 1 \
  --memory 1.5 \
  --environment-variables PORT=80 \
  --os-type Linux

# Get the public URL
az container show \
  --resource-group $RESOURCE_GROUP \
  --name $CONTAINER_NAME \
  --query "ipAddress.fqdn" \
  --output tsv

# Test the deployed API
FQDN=$(az container show --resource-group $RESOURCE_GROUP --name $CONTAINER_NAME --query "ipAddress.fqdn" --output tsv)
echo "Test your API at: http://$FQDN"
curl http://$FQDN
