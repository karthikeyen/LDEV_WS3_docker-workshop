#!/bin/bash
# =============================================================================
# Step 3: Create a Resource Group
# =============================================================================

# Variables - participants should use their own unique name
RESOURCE_GROUP="rg-docker-workshop-<yourname>"
LOCATION="southeastasia"

# Create the resource group
az group create --name $RESOURCE_GROUP --location $LOCATION

# Verify resource group creation
az group show --name $RESOURCE_GROUP --output table
