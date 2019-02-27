#!/bin/bash
eval $(minikube docker-env)

# Delete old kube
kubectl delete service auth-svc
kubectl delete deployment auth-svc

# Delete old image
docker images
docker rmi $(docker images | grep auth_svc | awk '{print $3}') -f
docker rmi $(docker images | grep \<none\> | awk '{print $3}') -f
docker images

# Rebuild
docker build -t auth_svc:v1 ./auth_svc/
kubectl apply -f ./kube/auth_svc.yaml

# List services
minikube service list