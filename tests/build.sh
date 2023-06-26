#!/usr/bin/env bash
sed -i "s~apt-get install openjdk-11-jdk~apt install default-jdk~g" ./Dockerfile
docker build . --tag elestio4test/metabase:latest