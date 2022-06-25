#!/bin/bash

sudo apt-get update

sudo apt-get install \
 apt-transport-https \
 ca-certificates \
 curl \
 gnupg-agent \
 software-properties-common

sleep 60

 curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sleep 60

 sudo add-apt-repository \
 "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
 $(lsb_release -cs) \
 stable"

sleep 60
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

sleep 60

docker run -p 3000:3000 jaimesan/timeoff-management:v1.0.0