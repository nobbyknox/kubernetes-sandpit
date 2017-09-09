# How to Install MQTT

## Via YAML

```yaml
kind: Deployment
apiVersion: extensions/v1beta1
metadata:
  name: mqtt
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mqtt
  template:
    metadata:
      labels:
        app: mqtt
    spec:
      containers:
      - name: mqtt
        image: eclipse-mosquitto:latest
        ports:
        - name: plain
          containerPort: 1883
          protocol: TCP
        - name: secure
          containerPort: 8883
          protocol: TCP
        - name: ws
          containerPort: 9001
          protocol: TCP
  strategy:
    type: Recreate
---
kind: Service
apiVersion: v1
metadata:
  name: mqtt
  labels:
    app: mqtt
spec:
  ports:
  - name: plain
    protocol: TCP
    port: 1883
    targetPort: plain
  - name: secure
    protocol: TCP
    port: 8883
    targetPort: secure
  - name: ws
    protocol: TCP
    port: 9001
    targetPort: ws
  selector:
    app: mqtt
  clusterIP: None
```

Port forwarding example:

```bash
$ kubectl port-forward $POD_NAME 1883:1883 9001:9001
```
