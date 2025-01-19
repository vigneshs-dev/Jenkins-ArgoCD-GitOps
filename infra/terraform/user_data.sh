#!/bin/bash

set -e

sudo apt update
sudo apt install -y git docker.io docker-compose
sudo groupadd docker
sudo usermod -aG docker $USER
