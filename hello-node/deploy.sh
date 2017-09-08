#!/bin/bash

# Check out https://kubernetes.io/docs/concepts/workloads/controllers/deployment/
kubectl set image deployment hello-node hello-node=hello-node:2017-09-08_11-57-35

# Check on the rollout status
kubectl rollout status deployment hello-node

kubectl get pods
