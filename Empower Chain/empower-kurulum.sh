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
echo -e "\e[0;34mEmpower Kurulumu Başlatılıyor\033[0m"
echo -e ''
echo -e ''
sleep 2
echo -e '\e[0;35m' && read -p "Moniker isminizi girin: " MONIKER 
echo -e "\033[035mMoniker isminiz\033[034m $MONIKER \033[035molarak kaydedildi"
echo -e '\e[0m'
echo "export MONIKER=$MONIKER" >> $HOME/.bash_profile
echo -e ''
exec > /dev/null 2>&1
cd /$HOME
rm -rf empowerchain
sudo rm -rf .empowerchain
sudo rm -rf /usr/local/bin/empowerd
sudo rm -rf /root/go/bin/empowerd
sudo rm -rf $(which empowerd)
exec > /dev/tty 2>&1
echo -e "\e[0;34mEski Veriler Silindi\033[0m"
echo -e '\e[0;32m✔'
echo -e ''
echo -e ''
sleep 1
echo -e "\e[0;34mSunucu Güncelleniyor\033[0m"
sleep 1
exec > /dev/null 2>&1
sudo apt-get update -y && sudo apt-get upgrade -y
exec > /dev/tty 2>&1
echo -e '\e[0;32m✔'
echo -e ''
sleep 1
echo -e "\e[0;34mKütüphaneler Kuruluyor\033[0m"
sleep 1
exec > /dev/null 2>&1
sudo apt install curl tar wget tmux htop net-tools clang pkg-config libssl-dev jq build-essential git screen make ncdu -y
exec > /dev/tty 2>&1
echo -e '\e[0;32m✔'
echo -e ''
echo -e ''
sleep 1
echo -e "\e[0;34mGo Yükleniyor\033[0m"
exec > /dev/null 2>&1
cd
wget https://go.dev/dl/go1.20.4.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.20.4.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile
echo 'export GOROOT=/usr/local/go' >> $HOME/.bash_profile
echo 'export GOPATH=$HOME/go' >> $HOME/.bash_profile
echo 'export GO111MODULE=on' >> $HOME/.bash_profile &&  . $HOME/.bash_profile
rm -rf go1.20.4.linux-amd64.tar.gz
exec > /dev/tty 2>&1
echo -e '\e[0;32m✔'
echo -e ''
echo -e "\e[0;36m$(go version) Kuruldu\033[0m"
echo -e ''
sleep 1
echo -e "\e[0;34mEmpowerchain Kuruluyor\033[0m"
sleep 1
exec > /dev/null 2>&1
cd /$HOME
git clone https://github.com/EmpowerPlastic/empowerchain.git
cd empowerchain/chain
git checkout v0.0.3
make install 
exec > /dev/tty 2>&1
echo -e '\e[0;32m✔'
echo -e "\e[0;36mEmpowerd $(empowerd version) Kuruldu\033[0m"
sleep 1
echo -e ''
echo -e ''

echo -e "\e[0;34mEmpowerd İnitalize\033[0m"
empowerd config chain-id circulus-1
empowerd config keyring-backend test
empowerd config node tcp://localhost:15057
echo -e '\e[0;32m✔\033[0m'
echo -e ''
empowerd init $MONIKER --chain-id circulus-1
sleep 2
echo -e ''
echo -e ''

echo -e "\e[0;34mYapılandırma Dosyası Ayarları Yapılıyor\033[0m"
sleep 1
exec > /dev/null 2>&1
curl -Ls https://raw.githubusercontent.com/0xSocrates/Testnet-Rehberler/main/EmpowerChain/genesis.json > $HOME/.empowerchain/config/genesis.json
sleep 1
curl -Ls https://raw.githubusercontent.com/0xSocrates/Testnet-Rehberler/main/EmpowerChain/addrbook.json > $HOME/.empowerchain/config/addrbook.json
sleep 1
seeds=" "
peers=" "
sed -i -e 's|^seeds *=.*|seeds = "'$seeds'"|; s|^persistent_peers *=.*|persistent_peers = "'$peers'"|' $HOME/.empowerchain/config/config.toml
sed -i.bak -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.025umpwr\"/" $HOME/.empowerchain/config/app.toml
exec > /dev/tty 2>&1
echo -e '\e[0;32m'
echo -e "Min gas price ✔"
sleep 1
echo -e "Seeds ✔"
sleep 1
echo -e "Peers ✔"
sleep 1
echo -e "Genesis ✔"
sleep 1
echo -e "Addrbook ✔"
echo -e '\e[0m'

exec > /dev/null 2>&1
sudo systemctl stop empowerd
sudo systemctl disable empowerd
sudo rm -rf /etc/systemd/system/empowerd.service
exec > /dev/tty 2>&1
echo -e "\e[0;34mService Dosyası Oluşturuldu\033[0m"
exec > /dev/null 2>&1
sudo tee /etc/systemd/system/empowerd.service > /dev/null <<EOF
[Unit]
Description=EmpowerChain Node
After=network-online.target
[Service]
User=$USER
ExecStart=$(which empowerd) start --home $HOME/.empowerchain
Restart=on-failure
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
sleep 1
sudo systemctl daemon-reload
sudo systemctl enable empowerd
sudo systemctl start empowerd
sudo systemctl restart empowerd
exec > /dev/tty 2>&1
echo -e ' '
echo -e "\e[0;34mNode Başlatıldı\033[0m"
sleep 1
echo -e ""
echo -e "\e[0;32mLogları Görüntülemek İçin:\033[0;35m           sudo journalctl -u empowerd -fo cat\e[0m"
echo -e ""
echo -e ""
echo -e "\e[0;34mKurulum Tamamlandı\e[0m\u2600"

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
