#!/bin/bash
clear
# matrix (optional)
# Logo
# set variables
binary-name = noded
node-name = project
binary-version = v.1.1
chainid = chainid.l
custom-port = 111
# get moniker
echo -e '\e[0;35m' && read -p "Moniker isminizi girin: " MONIKER 
echo -e "\033[035mMoniker isminiz\033[034m $MONIKER \033[035molarak kaydedildi"
echo -e '\e[0m'
echo "export MONIKER=$MONIKER" >> $HOME/.bash_profile
echo -e ''

# remove old
# prepare server
# install go
# install binary
# init
# config
# service
# start
# print info
# Logo
