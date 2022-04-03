#!/bin/bash

sudo apt-get update
sudo apt-get upgrade
# TRY THIS NEXT TIME AND DONT DO THE EDIT BELOW: sudo apt-get install golang-1.14
sudo apt install golang-go
sudo apt install nodejs

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Make sure the daemon is running
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -a -G docker root

# Install Hyperledger Fabric samples, binaries, and Docker images
curl -sSL https://bit.ly/2ysbOFE | bash -s -- 2.2.2 1.4.9
export PATH=~/fabric-samples/bin:$PATH

# Tutorials - Using the Fabric test network
cd fabric-samples/test-network
./network.sh down
./network.sh up
./network.sh createChannel

# Starting a chaincode on the channel
# BEFORE RUNNING THE NEXT COMMAND! Edit asset-transfer-basic/chaincode-go/go.mod from "go 1.14" to "go 1.13"
./network.sh deployCC -ccn basic -ccp ../asset-transfer-basic/chaincode-go -ccl go
