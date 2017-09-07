# Kubernetes

## Some Notes on K8S

```bash
# start minikube (single node kubernetes cluster)
$ minikube start

$ docker pull ghost:latest

# Runs new ghost container with assigned name "my-ghost", mapping
# host port 3001 to container port 2368
$ docker run -d --name my-ghost -p 3001:2368 ghost

# See what cluster I'm connected to
$ kubectl cluster-info

# Runs an app and assign name "my-ghost" from image "ghost:latest"
$ kubectl run my-ghost --image=ghost:latest --port=2368

# Start proxy to expose the cluster
$ kubectl proxy

# Hit the cluster to ensure it works
$ curl http://localhost:8001/api/v1/proxy/namespaces/default/pods/$POD_NAME/

# Delete a deployment. Will also delete pods and other fungi.
$ kubectl delete deployment my-ghost

# Runs NGINX using yaml file
$ kubectl create -f ./run-my-nginx.yaml

# Show deployments
$ kubectl get deployments

# Show events
$ kubectl get events

# Scale down to 1 pod
$ kubectl scale deployment/my-nginx --replicas=1

# Expose a service for the my-nginx deployment
$ kubectl expose deployment/my-nginx --type="NodePort" --port 8080

# Describe the service
$ kubectl describe services/my-nginx

# Describe the deployment
$ kubectl describe deployment/my-nginx



$ minikube stop
```

## Google Cloud Platform Notes

```bash
$ gcloud container clusters get-credentials cluster-1 --zone us-east1-b
$ gcloud container clusters list --zone us-east1-b

$ kubectl run kubernetes-bootcamp --image=docker.io/jocatalin/kubernetes-bootcamp:v1 --port=8080
```

## Minikube

Some useful minikube commands:

```bash
# start minikube
$ minikube start

# stop minikube
$ minikube stop

# ssh into the minikube
$ minikube ssh
```