#!/bin/bash
# =============================================================================
# Step 7: Modify the code, rebuild, and redeploy
# =============================================================================

# Navigate to source folder
cd ~/clouddrive/docker-workshop/src

# --- TASK: Modify src/index.js using sed ---
# Example: Change the response message
sed -i "s/Hello from Dockerized Node.js app!/Hello from <yourname> - Updated API v2!/" index.js
cat index.js  # Verify the change

# Variables
# ACR_NAME="acrldev<yourname>"
ACR_NAME="acrldevkarthik"
RESOURCE_GROUP="LDEV-docker-workshop-karthik"
IMAGE_NAME="docker-workshop-api-image"
IMAGE_TAG="v2"
# CONTAINER_NAME="ldev-web-api-container-<yourname>"
CONTAINER_NAME="ldev-web-api-container-karthik"

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
  --ports 80 \
  --cpu 1 \
  --memory 1.5 \
  --environment-variables PORT=80 \
  --os-type Linux

# Verify the updated API response
FQDN=$(az container show --resource-group $RESOURCE_GROUP --name $CONTAINER_NAME --query "ipAddress.fqdn" --output tsv)
echo "Updated API available at: http://$FQDN"
curl http://$FQDN
