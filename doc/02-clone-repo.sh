#!/bin/bash
# =============================================================================
# Step 2: Clone the repository
# =============================================================================

# Work inside ~/clouddrive so files persist across Cloud Shell sessions
cd ~/clouddrive

# Clone the workshop repo
git clone https://github.com/karthikeyen/LDEV_WS3_docker-workshop docker-workshop
cd docker-workshop/src

# Verify project files
ls -la
cat index.js
