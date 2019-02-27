#!/bin/bash
minikube start
eval $(minikube docker-env)

minikube service list