#!/bin/bash
clear
sleep 1
echo -e '\e[0;35m'
echo " +-+-+-+-+-+-+-+-+"
echo " |S|o|c|r|a|t|e|s|"
echo " +-+-+-+-+-+-+-+-+"
echo -e '\e[0m'
sleep 2 
echo -e "\e[0;33mBAZUKA UPDATE SCRIPT\033[0m"
sleep 1
echo ""
echo ""
echo -e '\e[0;34m' && echo "Node Stopped" && echo -e '\e[0m'
exec > /dev/null 2>&1
sudo systemctl stop bazuka
cd bazuka
git pull origin master
cargo update
exec > /dev/tty 2>&1
echo -e '\e[0;34m' && echo "Updating Bazuka Version" && echo -e '\e[0m'
exec > /dev/null 2>&1
cargo install --path .
exec > /dev/tty 2>&1
sleep 1
echo -e '\e[0;34m' && echo "Bazuka Version Updated to $(bazuka --version)" && echo -e '\e[0m'
exec > /dev/null 2>&1
sudo systemctl start bazuka
sudo systemctl restart bazuka
source "$HOME/.cargo/env"
exec > /dev/tty 2>&1
sleep 1
echo -e '\e[0;34m' && echo "Node Started" && echo -e '\e[0m'
sleep 2
echo -e '\e[0;34m' && echo "Here are the logs" && echo -e '\e[0m'
sleep 1
sudo journalctl -u bazuka -fo cat
