#!/bin/bash

# Exit on error
set -e
docker stop react-application || true
docker rm react-application || true

Branch_Name=$1
echo "Current Branch: $Branch_Name"
if [ "$Branch_Name" == "dev" ]; then
    #docker login -u "kkacc19@hotmail.com" -p "34341983Umer!" docker.io
    docker pull unjilani24/dev:latest
    docker run -d --name react-application -p 80:80 unjilani24/dev:latest
    echo "Deployment finished successfully!"
elif [ "$Branch_Name" == "main" ]; then
    #docker login -u "kkacc19@hotmail.com" -p "34341983Umer!" docker.io
    docker pull unjilani24/prod:latest
    docker run -d --name react-application -p 80:80 unjilani24/prod:latest
    echo "Deployment finished successfully!"
else
    echo "Unknown branch: $Branch_Name. No action taken."
    exit 1
fi