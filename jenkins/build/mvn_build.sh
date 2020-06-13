#!/bin/bash



docker container run --rm -v $JENKINS_HOME/workspace/Pipeline_Petclinic:/app -v $JENKINS_HOME/.m2:/root/.m2 -w /app maven:3-alpine $@
