#!/bin/bash
echo $PWD
docker container run --rm -v $PWD:/app -v $JENKINS_HOME/.m2:/root/.m2 -w /app maven:3-alpine $@
