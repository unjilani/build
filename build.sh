#!/bin/bash 
# Exit on error
set -e

Branch_Name=$1
echo "Current Branch: $Branch_Name"

if [ "$Branch_Name" == "dev" ]; then
    echo "Building image from Dockerfile for Developer"
    docker build -t unjilani24/dev:latest .
    echo "Pushing image to Docker Hub (Developer)"
    #docker login -u "kkacc19@hotmail.com" -p "34341983Umer!" docker.io
    docker push unjilani24/dev:latest

elif [ "$Branch_Name" == "main" ]; then
    echo " Building image from Dockerfile for Production"
    docker build -t unjilani24/prod:latest .
    echo " Pushing image to Docker Hub (Production)"
    #docker login -u "kkacc19@hotmail.com" -p "34341983Umer!" docker.io
    docker push unjilani24/prod:latest

else
    echo "Unknown branch: $Branch_Name. No action taken."
    exit 1
fi