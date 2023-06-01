# Güncelleme ve Kütüphaneler
```
sudo apt-get update -y && sudo apt-get upgrade -y
``` 
```
sudo apt install curl tar wget tmux htop net-tools clang pkg-config libssl-dev jq build-essential git screen make ncdu -y
```
# Go
```
cd $HOME
wget https://go.dev/dl/go1.20.4.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.20.4.linux-amd64.tar.gz
echo 'export GOROOT=/usr/local/go' >> $HOME/.bash_profile
echo 'export GOPATH=$HOME/go' >> $HOME/.bash_profile
echo 'export GO111MODULE=on' >> $HOME/.bash_profile
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile && . $HOME/.bash_profile
rm -rf go1.20.4.linux-amd64.tar.gz
```

# Binary Kurulumu
```
git clone https://github.com/EmpowerPlastic/empowerchain.git
cd empowerchain/chain
git checkout v1.0.0-rc1
make install
```
# İnit
```
empowerd init MONIKER --chain-id circulus-1
```
# Genesis
```
curl -Ls https://raw.githubusercontent.com/0xSocrates/Testnet-Rehberler/main/Empower%20Chain/genesis.json > $HOME/.empowerchain/config/genesis.json
```
# Addrbook
```
curl -Ls https://raw.githubusercontent.com/0xSocrates/Testnet-Rehberler/main/Empower%20Chain/addrbook.json > $HOME/.empowerchain/config/addrbook.json
```
# Seeds-Peers
```
seeds="d6a7cd9fa2bafc0087cb606de1d6d71216695c25@51.159.161.174:26656"
```
```
peers="e8b3fa38a15c426e046dd42a41b8df65047e03d5@95.217.144.107:26656,89ea54a37cd5a641e44e0cee8426b8cc2c8e5dfb@51.159.141.221:26656,0747860035271d8f088106814a4d0781eb7b2bc7@142.132.203.60:27656,3c758d8e37748dc692621a0d59b454bacb69b501@65.108.224.156:26656,41b97fced48681273001692d3601cd4024ceba59@5.9.147.185:26656"
```
```
sed -i -e 's|^seeds *=.*|seeds = "'$seeds'"|; s|^persistent_peers *=.*|persistent_peers = "'$peers'"|' $HOME/.empowerchain/config/config.toml
```
# Min Gas Price
```
sed -i.bak -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.025umpwr\"/" $HOME/.empowerchain/config/app.toml
```

# Puruning
```
pruning="custom"
pruning_keep_recent="100"
pruning_keep_every="0"
pruning_interval="50"
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/.empowerchain/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/.empowerchain/config/app.toml
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/.empowerchain/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/.empowerchain/config/app.toml
```

# İndexer
```
indexer="null"
sed -i -e "s/^indexer *=.*/indexer = \"$indexer\"/" $HOME/.empowerchain/config/config.toml
```


# Service
```
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
```
# Başlat
```
sudo systemctl daemon-reload
sudo systemctl enable empowerd
sudo systemctl restart empowerd
```
# Log Kontrolü
```
sudo journalctl -u empowerd -fo cat
```
# Cüzdan oluştuma
```
empowerd keys add wallet
``` 
> ### Mnemonic kaydetmeyi ve saklamayı unutmayın
 
> ## Cüzdanınızı recover etmek için
```
empowerd keys add wallet --recover
``` 

# Validatör
```
empowerd tx staking create-validator \
  --amount 8000000umpwr \
  --from wallet \
  --commission-max-change-rate "0.01" \
  --commission-max-rate "0.2" \
  --commission-rate "0.06" \
  --min-self-delegation "1" \
  --pubkey  $(empowerd tendermint show-validator) \
  --moniker <MONIKER> \
  --website "<WEBSITENIZ"
  --identity <KEYBASE.IO-ID> \
  --details "Core Node Community" \
  --chain-id circulus-1
  --y
  ```

# Silmek İçin
```
sudo systemctl stop empowerd && \
sudo systemctl disable empowerd && \
rm /etc/systemd/system/empowerd.service && \
sudo systemctl daemon-reload && \
cd $HOME && \
rm -rf .empowerchain && \
rm -rf empowerchain && \
rm -rf $(which empowerd)
```
