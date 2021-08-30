#!/bin/sh

export DOCKER_BUILDKIT=1

TAG=$(git tag --points-at HEAD)

[[ -f protoc-3.17.3-linux-aarch_64.zip ]] || curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v3.17.3/protoc-3.17.3-linux-aarch_64.zip
[[ -f protoc-3.17.3-linux-x86_64.zip ]] || curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v3.17.3/protoc-3.17.3-linux-x86_64.zip
mkdir -p linux/arm64 && unzip -o -d linux/arm64 protoc-3.17.3-linux-aarch_64
mkdir -p linux/amd64 && unzip -o -d linux/amd64 protoc-3.17.3-linux-x86_64

docker buildx build --push --platform=linux/amd64,linux/arm64 -t $TAG .

rm *.zip
rm -rf linux