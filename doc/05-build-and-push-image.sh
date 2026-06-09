#!/bin/bash
# =============================================================================
# Step 5: Build Docker image and push to ACR
# =============================================================================

# Variables
ACR_NAME="acrworkshop<yourname>"
IMAGE_NAME="docker-workshop-api"
IMAGE_TAG="v1"

# Login to ACR
az acr login --name $ACR_NAME

# Get ACR login server
ACR_LOGIN_SERVER=$(az acr show --name $ACR_NAME --query loginServer --output tsv)
echo "ACR Login Server: $ACR_LOGIN_SERVER"

# Build the Docker image locally
docker build -t $IMAGE_NAME:$IMAGE_TAG .

# Tag the image for ACR
docker tag $IMAGE_NAME:$IMAGE_TAG $ACR_LOGIN_SERVER/$IMAGE_NAME:$IMAGE_TAG

# Push the image to ACR
docker push $ACR_LOGIN_SERVER/$IMAGE_NAME:$IMAGE_TAG

# Verify the image is in ACR
az acr repository list --name $ACR_NAME --output table
az acr repository show-tags --name $ACR_NAME --repository $IMAGE_NAME --output table
