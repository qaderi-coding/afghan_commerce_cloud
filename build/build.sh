#!/bin/bash
set -e

echo "Building Afghan Commerce Cloud..."
dotnet build AfghanCommerceCloud.sln
echo "Build complete."
