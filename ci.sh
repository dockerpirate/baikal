#!/bin/bash

if [ "$TRAVIS_PULL_REQUEST" = "true" ] || [ "$TRAVIS_BRANCH" != "master" ]; then
  docker buildx build \
    --progress plain \
    --platform=linux/arm64,linux/arm/v7,linux/arm/v6 \
    .
  exit $?
fi
 - version="
echo $DOCKER_PASSWORD | docker login -u dockerpirate --password-stdin &> /dev/null
TAG="${TRAVIS_TAG:-latest}"
TAG="${TRAVIS_TAG}:${GIT_TAG}"
docker buildx build \
     --progress plain \
    --platform=linux/arm64,linux/arm/v7,linux/arm/v6 \
    -t $DOCKER_REPO:$TAG \
    --push \
    .
