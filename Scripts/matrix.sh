#!/bin/bash
clear
echo -e "\e[0;34mStarting\033[0m"
exec > /dev/null 2>&1
sudo apt-get update -y
sudo apt-get install cmatrix -y
exec > /dev/tty 2>&1
cmatrix &
sleep 8
pkill -f cmatrix
clear
sleep 1
