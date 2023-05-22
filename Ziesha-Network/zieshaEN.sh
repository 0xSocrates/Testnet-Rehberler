#!/bin/bash
clear 
sleep 1
echo -e '\e[0;35m'
echo -e ' '
echo -e '                  __                           _              '
echo -e '                 / _\  ___    ___  _ __  __ _ | |_  ___  ___  '
echo -e '                 \ \  / _ \  / __||  __|/ _  || __|/ _ \/ __| '
echo -e '                 _\ \| (_) || (__ | |  | (_| || |_|  __/\__ \ '
echo -e '                 \__/ \___/  \___||_|   \__,_| \__|\___||___/ ' 
echo -e ''
echo -e ''
echo -e '\e[0m'
echo -e ''
echo -e ''
sleep 4
echo -e "\e[0;34mZiesha Installation is Starting.\033[0m"
echo -e ''
cd /$HOME
rm -rf .bazuka
rm -rf .bazuka.yaml
rm -rf .bazuka-wallet
rm -rf bazuka
sleep 2
echo -e '\e[0;35m' && read -p "Enter your Discord Handle: " DISCORD 
echo -e "\033[035mYour Discord handle saved as\033[034m $DISCORD \033[035m"
echo -e '\e[0m'
echo -e ''
sleep 1
echo -e "\e[0;34mUpdating Server\033[0m"
echo -e ''
sleep 1
sudo apt-get update -y && sudo apt-get upgrade -y
echo -e ''
sleep 1
echo -e "\e[0;34mInstalling Libraries\033[0m"
echo -e ''
sleep 1
sudo apt install curl tar wget tmux htop net-tools clang pkg-config libssl-dev jq build-essential git screen make cmake ncdu -y
echo -e ''
echo -e ''
echo -e "\e[0;34mInstalling Rust\033[0m"
echo -e ''
echo -e ''
sleep 1
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
echo ""
echo ""
sleep 2
echo -e "\e[0;34mInstalling Bazuka"
echo ""
echo -e "\033[033mBazuka is a wallet and node software for the Ziesha Network\e[0m" 
echo ""
echo ""
sleep 2
git clone https://github.com/ziesha-network/bazuka
source "$HOME/.cargo/env"
cd bazuka
git pull origin master
cargo update
cargo install --path .
source "$HOME/.cargo/env"
echo -e ""
echo -e ""
echo -e ""
sleep 2

echo ""
echo -e "\033[0;34mBazuka will initialized"
echo ""
sleep 2
echo -e "\e[0;32mChoose your wallet\033[0m"
echo -e "\e[0;33m"
sleep 1
echo -e "1-) I want to use my old wallet."
echo -e "2-) Create a new wallet for me."
echo -e "\033[0;35m"
read -p "Your Answer (1/2): " CUZDAN
echo ""
echo -e '\e[0m'
while [[ $CUZDAN != "1" && $CUZDAN != "2" ]];
 do 
 echo "\033[031mYou Entered An Invalid Answer\033[0m"
 echo ""
 sleep 2
 echo -e "\e[0;32mChoose your wallet\033[0m"
 sleep 1
 echo -e "\e[0;33m"
 echo -e "1-) I want to use my old wallet."
 echo -e "2-) Create a new wallet for me."
 echo -e "\033[0;35m"
 read -p "Your Answer (1/2): " CUZDAN
 echo ""
 echo -e '\e[0m'
done 

if [ $CUZDAN == "1" ]; then
 sleep 1
 echo -e "\e[0;35m"
 read -p "Enter Mnemonics: " MNEMONIC
 echo ""
 echo -e '\e[0m'
 sleep 2
 echo -e "\e[0;34mBazuka is Initialized.\033[0m"
 echo ""
 sleep 2
 bazuka init --external $(wget -qO- eth0.me):8765 --bootstrap 31.210.53.186:8765 --mnemonic "$MNEMONIC"
 sleep 3
  elif [ $CUZDAN == "2" ]; then
   sleep 1
   echo -e "\033[32mNew wallet will be created.\033[0m"
   echo ""
   sleep 1
   echo -e "\e[0;34mBazuka is Initialized.\033[0m"
   echo ""
   sleep 1
   echo -e "    \033[031m+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+"
   echo -e "    Don't forget to save your mnemonics!!!"
   echo -e "    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+\e[0m"
   echo ""
   echo ""
   sleep 3
   bazuka init --external $(wget -qO- eth0.me):8765 --bootstrap 31.210.53.186:8765
   sleep 8
fi 

sudo tee /etc/systemd/system/bazuka.service > /dev/null <<EOF
[Unit]
Description=Bazuka
After=network.target
[Service]
User=root
ExecStart=/root/.cargo/bin/bazuka node start --discord-handle "$DISCORD"
Restart=on-failure
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl enable bazuka
sudo systemctl start bazuka
sudo systemctl restart bazuka
source "$HOME/.cargo/env"
echo -e ""
echo -e ""
echo -e "\e[0;34mNode Started.\e[0m"
echo -e ""
sleep 2
echo -e "\e[0;32mCheck Logs:\033[0;35m  sudo journalctl -u bazuka -fo cat\e[0m"
echo -e ""
echo -e ""
sleep 3
echo -e "\e[0;34mInstallation Complete\e[0m"
echo -e ""
sleep 1
echo -e "\033[33m"
echo -e "- You must wait to sync before making transactions."
echo -e "- Check your node in Explorer.  http://31.210.53.186:8000/"
echo -e "- Don't forget to follow Discord for updates. If you have any questions you can ask on discord."
sleep 2
echo -e ""
echo -e ""
echo -e ""
echo -e "\033[36m"
echo "███████╗██╗███████╗███████╗██╗  ██╗ █████╗     ███╗   ██╗███████╗████████╗██╗    ██╗ ██████╗ ██████╗ ██╗  ██╗"
echo "╚══███╔╝██║██╔════╝██╔════╝██║  ██║██╔══██╗    ████╗  ██║██╔════╝╚══██╔══╝██║    ██║██╔═══██╗██╔══██╗██║ ██╔╝"
echo "  ███╔╝ ██║█████╗  ███████╗███████║███████║    ██╔██╗ ██║█████╗     ██║   ██║ █╗ ██║██║   ██║██████╔╝█████╔╝ "
echo " ███╔╝  ██║██╔══╝  ╚════██║██╔══██║██╔══██║    ██║╚██╗██║██╔══╝     ██║   ██║███╗██║██║   ██║██╔══██╗██╔═██╗ "
echo "███████╗██║███████╗███████║██║  ██║██║  ██║    ██║ ╚████║███████╗   ██║   ╚███╔███╔╝╚██████╔╝██║  ██║██║  ██╗"
echo "╚══════╝╚═╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝    ╚═╝  ╚═══╝╚══════╝   ╚═╝    ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝"
echo "                                                                                                             "
echo "                                    Towards Lİghter Blockchains                                              "
echo -e '\e[0m'
