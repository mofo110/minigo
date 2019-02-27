#!/bin/bash
eval $(minikube docker-env)

kubectl apply -f ./kube/ambassador-rbac.yaml

minikube service list   