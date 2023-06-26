#!/bin/bash
sudo apt-get update -y && sudo apt-get upgrade -y
sleep 1
sudo apt install curl tar wget tmux htop net-tools clang pkg-config libssl-dev jq build-essential git screen make ncdu -y
