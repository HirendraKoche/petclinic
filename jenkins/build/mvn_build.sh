#!/bin/bash

WORKSPACE=/var/lib/docker/volumes/jenkins_jenkins_home/_data/

docker container run --rm -v $WORKSPACE/workspace/Pipeline_Petclinic:/app -v $WORKSPACE/.m2:/root/.m2 -w /app maven:3-alpine $@
