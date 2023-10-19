#!/bin/bash

IMAGE_NAME="simpler-deployer-image"
CONTAINER_NAME="simpler-deployer-container"

# Check if the Docker image exists
if docker image inspect $IMAGE_NAME &>/dev/null; then
    # Check if a container based on the image is running
    if docker ps -q -f "ancestor=$IMAGE_NAME" &>/dev/null; then
        # Stop and remove the running container
        echo "Stopping and removing the running container..."
        docker stop $CONTAINER_NAME
        docker rm $CONTAINER_NAME
    fi

    # Delete the existing image
    echo "Deleting the existing image..."
    docker rmi $IMAGE_NAME
fi

# Build a new Docker image
echo "Building a new Docker image..."
docker build -t $IMAGE_NAME .

echo "Image build completed. Container created"

echo "Starting the container with port binding..."
docker run -p 1213:1213 -d --name $CONTAINER_NAME $IMAGE_NAME

echo "Image build completed. Container created and started with port 1213"