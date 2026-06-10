#!/bin/bash
# =============================================================================
# Step 1: Login to Azure and verify subscription
# =============================================================================

# Login to Azure (opens browser for authentication)
az login

# List subscriptions and verify Visual Studio Professional subscription is active
az account list --output table

# Set the Visual Studio Professional subscription (replace with your subscription name/id)
az account set --subscription "Visual Studio Professional Subscription"

# Verify current subscription
az account show --output table