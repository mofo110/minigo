#!/bin/bash
eval $(minikube docker-env)

kubectl apply -f ./kube/ambassador-service.yaml

minikube service list   