# Golang microservices & Kubernetes Sample

This is my sample for golang microservices and kubernetes.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

* [Golang](https://golang.org/) - Open source programming language 
* [Docker](https://www.docker.com/) - Docker containers
* [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) - Kubernetes command line tool
* [Minikube](https://kubernetes.io/docs/setup/minikube/) - Run Kubernetes locally
* [Ambassador](https://www.getambassador.io/user-guide/getting-started/) - Open Source Kubernetes-Native API Gateway

### Setup

Get the golang depencies

```
cd ./auth_svc/
GOPATH=$(pwd) go get github.com/dgrijalva/jwt-go
GOPATH=$(pwd) go get gopkg.in/oauth2.v3/generates
```

Execute the following scripts.

```
./1_startup.sh # start minikube
./2_rbac.sh    # deploy ambassador with rbac
./3_service.sh # deploy ambassador service
./4_hello.sh   # deploy hello service
./5_auth.sh    # deploy auth service
minikube service list
|-------------|----------------------|-----------------------------|
|  NAMESPACE  |         NAME         |             URL             |
|-------------|----------------------|-----------------------------|
| default     | ambassador           | http://192.168.99.100:31314 |
| default     | ambassador-admin     | http://192.168.99.100:32443 |
| default     | auth-svc             | No node port                |
| default     | hello-svc            | No node port                |
| default     | kubernetes           | No node port                |
| kube-system | kube-dns             | No node port                |
| kube-system | kubernetes-dashboard | No node port                |
|-------------|----------------------|-----------------------------|
```

### Validate

Validate your pods.

```
kubectl get pods
NAME                          READY   STATUS        RESTARTS   AGE
ambassador-54dd6c469d-6hwkw   1/1     Running       0          2h
ambassador-54dd6c469d-9thjs   1/1     Running       0          2h
ambassador-54dd6c469d-pswsm   1/1     Running       0          2h
auth-svc-76cd487b9d-trdp5     1/1     Running       0          20m
hello-svc-7668d8d8d5-cmzgf    1/1     Running       0          1h
```

### Get your URI

Get your URI thru `ambassador`.  This will be unique every time (at least the port will).

```
minikube service ambassador --url
http://192.168.99.100:31314
```

### Test the API's

Use this [golang example](https://github.com/go-oauth2/oauth2/tree/master/example) to get JWT Bearer Token.
Then test the API's with the Bearer Token.

```
./6_test.sh
# Valid test
{
  "greeting": "Hello /mo"
}
# No Header
Authorization header is missing
 # Invalid Bearer
token contains an invalid number of segments
```

### Teardown

Execute the teardown script.

```
./7_teardown.sh
service "auth-svc" deleted
deployment.extensions "auth-svc" deleted
service "hello-svc" deleted
deployment.extensions "hello-svc" deleted
service "ambassador" deleted
service "ambassador-admin" deleted
deployment.extensions "ambassador" deleted
.
.
.
Stopping local Kubernetes cluster...
Machine stopped.
Deleting local Kubernetes cluster...
Machine deleted.
```

## Authors

* **mofo110** - *Initial work* - [mofo110](https://github.com/mofo110)