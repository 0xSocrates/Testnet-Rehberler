#!/bin/bash
exec > /dev/null 2>&1
clear
apt install cmatrix
exec > /dev/tty 2>&1
cmatrix &
sleep 6
pkill -f cmatrix
clear
sleep 1
