#!/bin/bash
# =============================================================================
# Step 8: Cleanup resources (to avoid charges)
# =============================================================================

# Variables
# RESOURCE_GROUP="LDEV-docker-workshop-<yourname>"
RESOURCE_GROUP="LDEV-docker-workshop-karthik"

# Delete the entire resource group (removes ACR, ACI, and all resources)
az group delete --name $RESOURCE_GROUP --yes --no-wait

echo "Resource group deletion initiated. Resources will be removed shortly."
