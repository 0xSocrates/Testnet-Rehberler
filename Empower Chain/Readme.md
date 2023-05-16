# Empower Chain Incentivized Testnet
## 31 Mayısta başlıyor

# Güncelleme ve Kütüphaneler
```
sudo apt-get update -y && sudo apt-get upgrade -y
``` 
```
sudo apt install curl tar wget tmux htop net-tools clang pkg-config libssl-dev jq build-essential git screen make ncdu -y
```
# Go
```
cd
wget https://go.dev/dl/go1.20.4.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.20.4.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile
rm -rf go1.20.4.linux-amd64.tar.gz
```

# Binary Kurulumu
```
git clone https://github.com/EmpowerPlastic/empowerchain.git
```
```
cd empowerchain/chain
make install
```
# İnit
```
empoverd init Socrates --chain-id circulus
```
# Config
```
genesis addrbook peer seed
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
  --moniker Socrates \
  --website "https://github.com/0xSocrates"
  --identity 52B4347D67822C \
  --details "Core Node Community" \
  --chain-id circulus
  --y
 ```
































