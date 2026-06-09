#!/bin/bash
# =============================================================================
# Step 5: Build Docker image and push to ACR
# =============================================================================

# Variables
#ACR_NAME="acrldev<yourname>"
ACR_NAME="acrldevkkb"
IMAGE_NAME="docker-workshop-api-image"
IMAGE_TAG="v1"

# Navigate to the src folder where Dockerfile and code are located
cd src

# Build and push the image directly in ACR (no local Docker daemon required)
# This uses ACR Tasks to build the image in the cloud
# The "." sends the current directory (src/) as build context to ACR
az acr build --registry $ACR_NAME --image $IMAGE_NAME:$IMAGE_TAG .

# Verify the image is in ACR
az acr repository list --name $ACR_NAME --output table
az acr repository show-tags --name $ACR_NAME --repository $IMAGE_NAME --output table
