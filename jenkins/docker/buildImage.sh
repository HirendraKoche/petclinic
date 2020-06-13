#!/bin/bash

sleep 5

docker build -t hirendrakoche/petclinic:$BUILD_TAG $PWD
