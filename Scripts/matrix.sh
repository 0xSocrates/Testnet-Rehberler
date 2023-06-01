#!/bin/bash
exec > /dev/null 2>&1
clear
sudo apt-get install cmatrix -y
sleep 1
exec > /dev/tty 2>&1
cmatrix &
sleep 6
pkill -f cmatrix
clear
sleep 1
