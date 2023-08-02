#!/bin/bash
clear
echo -e "\e[0;34mRemove Ziesha\033[0m"
sleep 2
clear
cmatrix &
sleep 5
pkill -f cmatrix
exec > /dev/null 2>&1
sudo systemctl stop bazuka
sudo systemctl disable bazuka
rm -rf /etc/systemd/system/bazuka.service
sudo systemctl daemon-reload
sudo killall bazuka
screen -XS ziesha kill
screen -XS bazuka kill
rm -rf /root/.cargo/bin/bazuka
cd /$HOME
rm -rf .bazuka
rm -rf .bazuka.yaml
rm -rf .bazuka-wallet
rm -rf bazuka
rm -rf .cargo
rm -rf .rustup
rm -rf ziesha.sh
sudo rm -rf $(which bazuka)
exec > /dev/tty 2>&1
clear
echo -e "\e[0;34mCompleted\033[0m"
sleep 3
clear
