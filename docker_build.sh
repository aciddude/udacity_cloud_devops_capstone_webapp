#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

export BUILDID=$1

# Step 0:
# Docker build
docker build -t acidd/udacity-weather-app:latest  -t acidd/udacity-weather-app:$BUILDID .


# Step 1:
# Create dockerpath
dockerpath=acidd/udacity-weather-app:$BUILDID

# Step 2:
# Authenticate & tag
echo "Docker ID and Image: $dockerpath"

export DOCKER_ID_USER="acidd"
docker login


# Step 3:
# Push image to a docker repository
docker tag $DOCKER_ID_USER/udacity-weather-app:latest $DOCKER_ID_USER/udacity-weather-app:$BUILDID
docker push $DOCKER_ID_USER/udacity-weather-app:latest
docker push $DOCKER_ID_USER/udacity-weather-app:$BUILDID
