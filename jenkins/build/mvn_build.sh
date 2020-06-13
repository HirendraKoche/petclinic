#!/bin/bash

JENKINS_CONTAINER=$(docker container ls -q --filter name=_jenkins)

docker container run --rm --volume-from=$JENKINS_CONTAINER -w $JENKINS_HOME/workspace/Pipeline_Petclinic $HOME/.m2:/root/.m2 -w /app maven:3-alpine $@
