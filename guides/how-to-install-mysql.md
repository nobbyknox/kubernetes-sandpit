# How to Install MySQL

## Via YAML

```yaml
apiVersion: apps/v1beta1
kind: Deployment
metadata:
  name: mysql
spec:
  replicas: 1
  strategy:
    type: Recreate
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
      - name: mysql
        image: mysql:5.7.14
        env:
        - name: MYSQL_ROOT_PASSWORD
          value: password
        - name: MYSQL_USER
          value: rabbit
        - name: MYSQL_PASSWORD
          value: rabbit
        ports:
        - name: mysql
          containerPort: 3306
          protocol: TCP
---
apiVersion: v1
kind: Service
metadata:
  name: mysql
spec:
  ports:
  - port: 3306
  selector:
    app: mysql
  clusterIP: None
```

## Using Helm:

```bash
$ ./helm install \
  --name mysql \
  --set mysqlRootPassword=password,mysqlUser=rabbit,mysqlPassword=rabbit \
  stable/mysql
```

output of the previous command:

```
NOTES:
MySQL can be accessed via port 3306 on the following DNS name from within your cluster:
mysql-mysql.default.svc.cluster.local

To get your root password run:

    kubectl get secret --namespace default mysql-mysql -o jsonpath="{.data.mysql-root-password}" | base64 --decode; echo

To connect to your database:

1. Run an Ubuntu pod that you can use as a client:

    kubectl run -i --tty ubuntu --image=ubuntu:16.04 --restart=Never -- bash -il

2. Install the mysql client:

    $ apt-get update && apt-get install mysql-client -y

3. Connect using the mysql cli, then provide your password:
    $ mysql -h mysql-mysql -p
```
