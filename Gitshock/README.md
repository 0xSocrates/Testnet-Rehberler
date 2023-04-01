```
sudo apt-get update && sudo apt-get upgrade -y && sudo apt install curl tar wget tmux htop net-tools clang pkg-config libssl-dev jq build-essential git screen make ncdu -y
```
go 
```
cd $HOME
wget https://go.dev/dl/go1.18.2.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.18.2.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile
```
geth indirin
```
sudo apt update -y && sudo apt upgrade -y
sudo apt install micro -y
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt update -y
sudo apt install ethereum -y
sudo apt install jq
``` 
geth kurun
```
go install github.com/protolambda/eth2-testnet-genesis@latest
go install github.com/protolambda/eth2-val-tools@latest
```

rust
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

source "$HOME/.cargo/env"
``` 

lighthouse

```
sudo apt install -y git gcc g++ make cmake pkg-config llvm-dev libclang-dev clang protobuf-compiler
```
```
git clone https://github.com/sigp/lighthouse.git
cd lighthouse

git checkout stable
make
``` 
cartenz chain kaynak dosyaları
```
cd /$HOME
wget https://github.com/gitshock-labs/testnet-list/releases/download/Iteration-70.a/cartenz-iteration-70.a.zip
unzip -d cartenz

```
cartenz kalsörüne inin
```
cd cartenz
```
JWT Secret oluşturun
```
openssl rand -hex 32 | tr -d "\n" > "jwt.hex" 
```
execution layerde bir hesap oluşturun
```
geth account new --datadir "/$HOME/.gitshock"
```
init
```
geth --datadir /$HOME/.gitshock/geth/geth-data init /$HOME/cartenz/execution/genesis.json
```

loglar için klasör
```
cd /$HOME
mkdir logs 
cd logs 
touch geth_1.log 
cd
```
execution layer
```
nohup geth \
--datadir "/$HOME/.gitshock" \
--http --http.api="engine,eth,web3,net,admin" \
--ws \
--ws.api="engine,eth,web3,net,debug" \
--http.corsdomain="*" \
--networkid=1881 \
--http.addr 0.0.0.0 \
--http.port 8545 \
--syncmode=full \
--authrpc.jwtsecret="/$HOME/cartenz/jwt.hex" \
> /$HOME/logs/geth_1.log &
```
peer eklemek için konsola giriş yapın
```
geth attach http://localhost:8545
```
peer ekleyin
(komutları sırayla girin)
```
admin.addPeer("enode://a478d3309e0dc1deb0e2a62e0b892e0d6d931b5dbf83d75c3811d48aa2d814b645567270b6ca220a34c0b9b417def6d5a6ea084dfa1e50e79f20a1808640e710@147.75.71.217:30303")

admin.addPeer("enode://de68503ed3aa6980fe38834c61be0e2b39e2291e9989e24f308904cbf8c0fb2864d30d5a814dda44aac1fe0626266864a9aa2d6a9f9e1635553c374ed75bb6cd@147.75.71.217:30304")

admin.addPeer("enode://03fc89e2035b52a609715a15dacad4179f57c0b1e51b3464a931f0fa913b9169d06df1b23515f41e4ed6d9be0e50f33175cbf836e7b6738c62eee00ad45250b0@212.47.241.173:30303")
```
eklenen peerları görmek için
```
admin.peers
```

`exit` ile konsoldan çıkın.
loglara bakmak için
```
tail -f /$HOME/logs/geth_1.log
```




































