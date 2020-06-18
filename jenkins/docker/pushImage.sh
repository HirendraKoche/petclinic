#!/bin/bash

REPO_USER=$1
REPO_PASS=$2
REPO_HOST=$3

# Login to repo
docker login -u $REPO_USER -p $REPO_PASS $REPO_HOST

# push image
docker push hirendrakoche/petclinic:$BUILD_NUMBER
