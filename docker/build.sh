#!/bin/bash
VERSION=`cat ./VERSION`
PROJECT=`cat ./PROJECT`
docker build --pull -t $PROJECT:$VERSION -t $PROJECT:latest -f Dockerfile ../
