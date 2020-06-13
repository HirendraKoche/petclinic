#!/bin/bash


docker run --rm --volumes-from=$(docker container ls -q --filter name=_jenkins)  -w $JENKINS_HOME/workspace/Pipeline_Petclinic maven:3-alpine "$@"
