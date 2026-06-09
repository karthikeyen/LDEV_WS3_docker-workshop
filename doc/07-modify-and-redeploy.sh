#!/bin/bash
# =============================================================================
# Step 7: Modify the code, rebuild, and redeploy
# =============================================================================

# --- TASK: Open src/index.js and change the message ---
# Example: Change the response to:
#   res.json({ message: 'Hello from <yourname> - Updated API v2!' });

# Variables
# ACR_NAME="acrworkshop<yourname>"
ACR_NAME="acrworkshopkkb"
RESOURCE_GROUP="LDEV-docker-workshop-kkb"
IMAGE_NAME="docker-workshop-api-image"
IMAGE_TAG="v2"
CONTAINER_NAME="aci-workshop-kkb"

# Get ACR login server and credentials
ACR_LOGIN_SERVER=$(az acr show --name $ACR_NAME --query loginServer --output tsv)
ACR_PASSWORD=$(az acr credential show --name $ACR_NAME --query "passwords[0].value" --output tsv)

# Rebuild and push using ACR Tasks (no local Docker daemon required)
az acr build --registry $ACR_NAME --image $IMAGE_NAME:$IMAGE_TAG .

# Delete old container instance
az container delete --resource-group $RESOURCE_GROUP --name $CONTAINER_NAME --yes

# Redeploy with updated image
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

# Verify the updated API response
FQDN=$(az container show --resource-group $RESOURCE_GROUP --name $CONTAINER_NAME --query "ipAddress.fqdn" --output tsv)
echo "Updated API available at: http://$FQDN:3000"
# curl http://$FQDN:3000
