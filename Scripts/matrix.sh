#!/bin/bash
clear
echo -e "\e[0;34mStarting\033[0m"
sleep 1
exec > /dev/null 2>&1
sudo apt-get update -y
sudo apt-get install cmatrix -y
sleep 1
exec > /dev/tty 2>&1
cmatrix &
sleep 6
pkill -f cmatrix
clear
sleep 1
