#!/bin/bash
eval $(minikube docker-env)

# Delete old kube
kubectl delete service hello-svc
kubectl delete deployment hello-svc

# Delete old image
docker images
docker rmi $(docker images | grep hello_svc | awk '{print $3}') -f
docker rmi $(docker images | grep \<none\> | awk '{print $3}') -f
docker images

# Rebuild
docker build -t hello_svc:v1 ./hello_svc/
kubectl apply -f ./kube/hello_svc.yaml

# List services
minikube service list