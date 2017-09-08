# How to Install RabbitMQ

## Via YAML

```yaml
kind: Deployment
apiVersion: extensions/v1beta1
metadata:
  name: rabbitmq
spec:
  replicas: 1
  selector:
    matchLabels:
      app: rabbitmq
  template:
    metadata:
      labels:
        app: rabbitmq
    spec:
      containers:
      - name: rabbitmq
        image: rabbitmq:3-management
        ports:
        - name: epmd
          containerPort: 4369
          protocol: TCP
        - name: amqp
          containerPort: 5672
          protocol: TCP
        - name: dist
          containerPort: 25672
          protocol: TCP
        - name: stats
          containerPort: 15672
          protocol: TCP
        env:
        - name: RABBITMQ_DEFAULT_USER
          value: rabbit
        - name: RABBITMQ_DEFAULT_PASS
          value: rabbit
        - name: RABBITMQ_MANAGER_PORT_NUMBER
          value: '15672'
  strategy:
    type: Recreate
---
kind: Service
apiVersion: v1
metadata:
  name: rabbitmq
  labels:
    app: rabbitmq
spec:
  ports:
  - name: epmd
    protocol: TCP
    port: 4369
    targetPort: epmd
  - name: amqp
    protocol: TCP
    port: 5672
    targetPort: amqp
  - name: dist
    protocol: TCP
    port: 25672
    targetPort: dist
  - name: stats
    protocol: TCP
    port: 15672
    targetPort: stats
  selector:
    app: rabbitmq
  clusterIP: None
```

Port forwarding example:

```bash
$ kubectl port-forward $POD_NAME 5672:5672 15672:15672
```

## Using Helm

```bash
# install RabbitMQ with management console
$ helm install --name rabbitmq \
  --set rabbitmqUsername=rabbit,rabbitmqPassword=rabbit \
    stable/rabbitmq
```

output of the previous command:

```
NOTES:

** Please be patient while the chart is being deployed **

  Credentials:

    echo Username      : rabbit
    echo Password      : $(kubectl get secret --namespace default rabbitmq-rabbitmq -o jsonpath="{.data.rabbitmq-password}" | base64 --decode)
    echo ErLang Cookie : $(kubectl get secret --namespace default rabbitmq-rabbitmq -o jsonpath="{.data.rabbitmq-erlang-cookie}" | base64 --decode)

  RabbitMQ can be accessed within the cluster on port 5672 at rabbitmq-rabbitmq.default.svc.cluster.local

  To access for outside the cluster execute the following commands:

    export POD_NAME=$(kubectl get pods --namespace default -l "app=rabbitmq-rabbitmq" -o jsonpath="{.items[0].metadata.name}")
    kubectl port-forward $POD_NAME 5672:5672 15672:15672

  To Access the RabbitMQ AMQP port:

    echo amqp://127.0.0.1:5672/

  To Access the RabbitMQ Management interface:

    echo URL : http://127.0.0.1:15672
```
