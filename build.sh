#!/bin/sh

set -e

go install ./...
go test ./...

for arch in arm amd64
do
  echo "Building $arch"
  CGO_ENABLED=0 GOOS=linux GOARCH=$arch go build -o hau-$arch
  docker build -t hau-$arch -f Dockerfile.$arch .
done
