#!/bin/bash

# Stop all running containers
echo "Stopping all running containers..."
docker stop $(docker ps -aq)

# Remove all containers
echo "Removing all containers..."
docker rm $(docker ps -aq)

# Remove all volumes
echo "Removing all volumes..."
docker volume rm $(docker volume ls -q)

# Remove all images
echo "Removing all images..."
docker rmi $(docker images -q)

# Prune networks, containers, and images
echo "Pruning all unused networks, containers, and images..."
docker system prune -a -f --volumes

echo "Docker cleanup completed."

