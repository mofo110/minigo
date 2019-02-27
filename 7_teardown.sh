#!/bin/bash
eval $(minikube docker-env)

kubectl delete service auth-svc
kubectl delete deployment auth-svc

kubectl delete service hello-svc
kubectl delete deployment hello-svc

kubectl delete service ambassador
kubectl delete service ambassador-admin
kubectl delete deployment ambassador

docker kill $(docker ps -q)
docker rmi $(docker images -a -q) -f

minikube stop
eval $(minikube docker-env -u)
minikube delete