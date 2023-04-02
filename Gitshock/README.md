```
sudo apt-get update && sudo apt-get upgrade -y && sudo apt install curl tar wget tmux htop net-tools clang pkg-config libssl-dev jq build-essential git screen make ncdu -y
```
go 
```
cd
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
cd
wget https://github.com/gitshock-labs/testnet-list/releases/download/Iteration-70.a/cartenz-iteration-70.a.zip
unzip -d cartenz cartenz-iteration-70.a.zip
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
geth account new --datadir "/root/.cartenz"
```
init
```
geth --datadir /root/.cartenz/geth/geth-data init /root/cartenz/execution/genesis.json
```

loglar için klasör
```
cd
mkdir logs 
cd logs 
touch geth_1.log 
touch beacon_1.log
touch beacon_2.log
cd
```
execution layer
```
nohup geth \
--datadir "/root/.cartenz" \
--http --http.api="engine,eth,web3,net,admin" \
--ws --ws.api="engine,eth,web3,net" \
--http.port 8545 \
--http.addr 0.0.0.0 \
--http.corsdomain "*" \
--networkid=1881 \
--syncmode=full \
--authrpc.port 8551 \
--discovery.port 30303 \
--authrpc.jwtsecret="/root/cartenz/jwt.hex" \
> /root/logs/geth_1.log &
```
peer eklemek için konsola giriş yapın
```
geth attach http://localhost:8545
```
peer ekleyin
(komutları sırayla girin)
```
admin.addPeer("enode://0e2b41699b95e8c915f4f5d18962c0d2db35dc22d3abbebbd25fc48221d1039943240ad37a6e9d853c0b4ea45da7b6b5203a7127b5858c946fc040cace8d2d63@147.75.71.217:30303") 

admin.addTrustedPeer("enode://0e2b41699b95e8c915f4f5d18962c0d2db35dc22d3abbebbd25fc48221d1039943240ad37a6e9d853c0b4ea45da7b6b5203a7127b5858c946fc040cace8d2d63@147.75.71.217:30303")
```
eklenen peerları görmek için
```
admin.peers
```

`exit` ile konsoldan çıkın.
loglara bakmak için
```
tail -f /root/logs/geth_1.log
```

birinci consensus layeri

```
nohup lighthouse beacon \
--eth1 \
--http \
--testnet-dir /root/cartenz/consensus \
--datadir "/root/.cartenz" \
--http-allow-sync-stalled \
--execution-endpoints http://127.0.0.1:8551 \
--http-port=5052 \
--enr-udp-port=9000 \
--enr-tcp-port=9000 \
--discovery-port=9000 \
--graffiti "Platon" \
--execution-jwt "/root/cartenz/jwt.hex" \
--suggested-fee-recipient=0x118233E687fe8d4e04C45918E0369495852A46c6 \
> /$HOME/logs/beacon_1.log &
```

ENR key oluşturma
```
curl http://localhost:5052/eth/v1/node/identity | jq 
```


iknci consensus layer
```
nohup lighthouse \
--testnet-dir /root/cartenz/consensus \
bn \
--datadir "/root/.beacon2" \
--eth1 \
--http \
--http-allow-sync-stalled \
--execution-endpoints "http://127.0.0.1:8551" \
--eth1-endpoints "http://127.0.0.1:8545" \
--http-address 0.0.0.0 \
--http-port 5053 \
--http-allow-origin="*" \
--listen-address 0.0.0.0 \
--enr-udp-port 9001 \
--enr-tcp-port 9001 \
--port 9001 \
--enr-address 54.82.42.159 \
--execution-jwt "/root/cartenz/jwt.hex" \
--suggested-fee-recipient="0x118233E687fe8d4e04C45918E0369495852A46c6" \
--boot-nodes="enr:-LS4QGnk8Zno9yQ7LJF3xDXrkcAAWh74W7Tn8Z-GRBgwMIoDBP9Bofx1JMGOcvbNKWM6PBvTHCk26uLZB6TE441GwIMBh2F0dG5ldHOIAAAAAAAAAACEZXRoMpBMfxReAmd2k___gmlkgnY0iXNlY3AyNTZrMaED0hIIiBqEo19u2jrhpWVOBtjqMtvm-PQoWMDaUSs5sRSIc3luY25ldHMAg3RjcIIjKIN1ZHCCIyg,enr:-MS4QHXShZPtKwtexK2p9yCxMxDwQ-EvdH_VemoxyVyweuaBLOC_8cmOzyx7Gy-q6-X8KGT1d_rhAn_ekXnhpCkA_REHh2F0dG5ldHOIAAAAAAAAAACEZXRoMpBMfxReAmd2k___________gmlkgnY0gmlwhJNLR9mJc2VjcDI1NmsxoQJB10N42nK6rr7Q_NIJNkJFi2uo6itMTOQlPZDcCy09T4hzeW5jbmV0c4gAAAAAAAAAAIN0Y3CCIyiDdWRwgiMo,enr:-MS4QEw_RpORuoXgJ0279QuVLLFAiXevNdYtU7vR8S1CY7X9CS6tceMbaxdIIJYRmHN43ClqHtE2b0H0maSb18cm9D0Hh2F0dG5ldHOIAAAAAAAAAACEZXRoMpBMfxReAmd2k___________gmlkgnY0gmlwhJNLR9mJc2VjcDI1NmsxoQOkQIyCVHLbLjIFMjqNSJEUsbYMe4Tsv9blUWvN6Rsft4hzeW5jbmV0c4gAAAAAAAAAAIN0Y3CCIymDdWRwgiMp" \
> /root/logs/beacon_2.log &
```

































