#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub


# Step 0:
# Docker build
docker build -t acidd/udacity-weather-app:latest -t acidd/udacity-weather-app:v1 .

# Step 1:
# Create dockerpath
dockerpath=acidd/udacity-weather-app:v1

# Step 2:
# Authenticate & tag
echo "Docker ID and Image: $dockerpath"

export DOCKER_ID_USER="acidd"
docker login
docker tag udacity-weather-app:v1 $DOCKER_ID_USER/udacity-weather-app:v1
docker tag udacity-weather-app:latest $DOCKER_ID_USER/udacity-weather-app:v1


# Step 3:
# Push image to a docker repository
docker push $DOCKER_ID_USER/udacity-weather-app:latest
