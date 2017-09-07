# Create Node.js App and Deploy to Minikube

Check out https://kubernetes.io/docs/tutorials/stateless-application/hello-minikube/

## create server.js

```javascript
var http = require('http');

var handleRequest = function(request, response) {
  console.log('Received request for URL: ' + request.url);
  response.writeHead(200);
  response.end('Hello World!');
};
var www = http.createServer(handleRequest);
www.listen(8080);
```

## Create Dockerfile

```
FROM node:8.4.0
EXPOSE 8080
COPY server.js .
CMD node server.js
```

## Setup Minikube to become docker repository

```bash
$ eval $(minikube docker-env)
```

Later, when you no longer want to use the Minikube docker host, run the following:

```bash
eval $(minikube docker-env -u)
```

## Build Docker Image

```bash
$ docker build -t hello-node:v1 .
```

## Create K8S Deployment

```bash
$ kubectl run hello-node --image=hello-node:v1 --port=8080
```

## Create K8S Server

A service exposes the internal pods to the outside world

```bash
$ kubectl expose deployment hello-node --type=LoadBalancer
```

On Minikube, the LoadBalancer type makes the Service accessible through the minikube service command.

```bash
$ minikube service hello-node
```

## Update the Node.js App

Edit `server.js` like so:

```javascript
response.end('Hello World Again!');
```

Build a new version:

```bash
$ docker build -t hello-node:v2 .
```

Update the image of your Deployment:

```bash
$ kubectl set image deployment/hello-node hello-node=hello-node:v2
```

Run your app again to view the new message:

```bash
$ minikube service hello-node
```

## Clean Up

```bash
# delete the service
$ kubectl delete service hello-node

# delete the deployment
$ kubectl delete deployment hell-node
```
