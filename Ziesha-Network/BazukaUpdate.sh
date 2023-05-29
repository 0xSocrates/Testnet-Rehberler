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
sudo systemctl stop bazuka
rm -rf /root/.bazuka
bazuka wallet reset
echo -e '\e[0;34m' && echo "Bazuka Node Stopped" && echo -e '\e[0m'
cd bazuka
git pull origin master
cargo update
sleep 1 
echo -e '\e[0;34m' && echo "Updating Bazuka Version" && echo -e '\e[0m'
cargo install --path .
sleep 1
echo -e '\e[0;34m' && echo "Bazuka Version Updated" && echo -e '\e[0m'
sudo systemctl start bazuka
sudo systemctl restart bazuka
source "$HOME/.cargo/env"
sleep 1
echo -e '\e[0;34m' && echo "Node Started" && echo -e '\e[0m'
sleep 2
echo -e '\e[0;34m' && echo "Here are the logs" && echo -e '\e[0m'
sleep 1
sudo journalctl -u bazuka -fo cat
