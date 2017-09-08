#!/bin/bash

TAG=$(date '+%Y-%m-%d_%H-%M-%S')

# Setup the minikube docker environment
eval $(minikube docker-env)

echo "Building docker tag: ${TAG}"
docker build -t hello-node:${TAG} .

docker images hello-node
echo "Image hello-node:${TAG} ready"
