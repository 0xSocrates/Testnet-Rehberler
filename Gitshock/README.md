```
sudo apt-get update && sudo apt-get upgrade -y && sudo apt install curl tar wget tmux htop net-tools clang pkg-config libssl-dev jq build-essential git screen make ncdu -y
```
# Go
```
cd
wget https://go.dev/dl/go1.19.1.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.19.1.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile
```

# Erigon
```
git clone https://github.com/ledgerwatch/erigon 
cd erigon 
make erigon 
make rpcdaemon
sudo mv /root/erigon/build/bin/erigon /usr/local/bin
```

# Rust
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

source "$HOME/.cargo/env"
``` 

# Lighthouse

```
sudo apt install -y git gcc g++ make cmake pkg-config llvm-dev libclang-dev clang protobuf-compiler
```
```
git clone https://github.com/sigp/lighthouse.git
cd lighthouse

git checkout stable
make
```
# Cartenz chain kaynak dosyaları
```
cd
git clone https://github.com/gitshock-labs/testnet-list
```


# JWT Secret oluşturun
```
cd testnet-list
openssl rand -hex 32 | tr -d "\n" > "jwt.hex" 
```
# Loglar ve data için klasörler
```
mkdir beacon-1
mkdir beacon-2 
mkdir validator
mkdir logs
cd logs
touch erigon.log
touch beacon_1.log
touch beacon_2.log
cd ..
```
# İnit
```
erigon --datadir "cartenz-data" init execution/genesis.json
```

# Erigon başlatın
> identity kısmına kendi isminizi yazın.
```
nohup erigon \
--datadir "/root/cartenz-data"  \
--externalcl \
--networkid=1881 \
--authrpc.jwtsecret="/root/testnet-list/jwt.hex" \
--http --http.api=engine,net,eth,web3 \
--http.corsdomain="*" \
--http.vhosts="*" \
--http.addr 0.0.0.0 \
--private.api.addr 127.0.0.1:9091 \
--http.port 8545 \
--port 30303 \
--authrpc.port 8551 \
--metrics \
--metrics.addr 0.0.0.0 \
--metrics.port 6060 \
--identity "Platon" \
--bootnodes="enode://e3b6cbacb5b918ea46104ca295101a53f159d06769e4d5730b4edd95e0880b4ca84bccb5d0c7ca70cf95dfeccef92bb6caa0533be667e4bb0114fc12051989cb@212.47.241.173:30303,enode://45b4fff6ab970e1e490deea8a5f960d806522fafdb33c8eaa38bc0ae970efc2256fc5746f0ecfec770af24c44864a3e6772a64f2e9f031f96fd4af7fd0483110@147.75.71.217:30304,enode://0e2b41699b95e8c915f4f5d18962c0d2db35dc22d3abbebbd25fc48221d1039943240ad37a6e9d853c0b4ea45da7b6b5203a7127b5858c946fc040cace8d2d63@147.75.71.217:30303,enode://787282effee17f9a9da49b3376f475b1521846ee924c962595e672ee9b90290e39b9f2fb67a5f34fb1f4964353cd6ef2a989c110d53b8fd169d8481c44f93119@44.202.92.152:30303" \
--trustedpeers="enode://e3b6cbacb5b918ea46104ca295101a53f159d06769e4d5730b4edd95e0880b4ca84bccb5d0c7ca70cf95dfeccef92bb6caa0533be667e4bb0114fc12051989cb@212.47.241.173:30303,enode://45b4fff6ab970e1e490deea8a5f960d806522fafdb33c8eaa38bc0ae970efc2256fc5746f0ecfec770af24c44864a3e6772a64f2e9f031f96fd4af7fd0483110@147.75.71.217:30304,enode://0e2b41699b95e8c915f4f5d18962c0d2db35dc22d3abbebbd25fc48221d1039943240ad37a6e9d853c0b4ea45da7b6b5203a7127b5858c946fc040cace8d2d63@147.75.71.217:30303,enode://787282effee17f9a9da49b3376f475b1521846ee924c962595e672ee9b90290e39b9f2fb67a5f34fb1f4964353cd6ef2a989c110d53b8fd169d8481c44f93119@44.202.92.152:30303" \
> /root/testnet-list/logs/erigon.log &
```




loglara bakmak için
```
tail -f /root/testnet-list/logs/erigon.log
```
# bundan sonrasını yapma



birinci consensus layeri
```
nohup lighthouse \
--testnet-dir="/root/testnet-list/consensus" \
bn \
--datadir /root/.cartenz/beacon-1 \
--eth1 \
--http \
--gui \
--http-address 127.0.0.1 \
--http-allow-origin="*" \
--http-allow-sync-stalled \
--execution-endpoints http://127.0.0.1:8551 \
--http-port 5052 \
--enr-udp-port=9000 \
--enr-tcp-port=9000 \
--discovery-port=9000 \
--graffiti "Platon" \
--jwt-secrets="/root/testnet-list/jwt.hex" \
--suggested-fee-recipient=0xcC464A650e0697d3D5709aec7e9F83C994c0862e \
> /root/logs/beacon_1.log &
```



```
nohup lighthouse beacon \
--eth1 \
--http \
--testnet-dir /root/cartenz/consensus \
--datadir "/root/.cartenz/beacon" \
--http-allow-sync-stalled \
--execution-endpoints http://127.0.0.1:8551 \
--http-port=5052 \
--enr-udp-port=9000 \
--enr-tcp-port=9000 \
--discovery-port=9000 \
--graffiti "Platon" \
--execution-jwt "/root/cartenz/jwt.hex" \
--suggested-fee-recipient=0xcC464A650e0697d3D5709aec7e9F83C994c0862e \
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
--datadir "/root/.cartenz/beacon2" \
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
--suggested-fee-recipient="0xcC464A650e0697d3D5709aec7e9F83C994c0862e" \
--boot-nodes="enr:-LS4QGnk8Zno9yQ7LJF3xDXrkcAAWh74W7Tn8Z-GRBgwMIoDBP9Bofx1JMGOcvbNKWM6PBvTHCk26uLZB6TE441GwIMBh2F0dG5ldHOIAAAAAAAAAACEZXRoMpBMfxReAmd2k___gmlkgnY0iXNlY3AyNTZrMaED0hIIiBqEo19u2jrhpWVOBtjqMtvm-PQoWMDaUSs5sRSIc3luY25ldHMAg3RjcIIjKIN1ZHCCIyg,enr:-MS4QHXShZPtKwtexK2p9yCxMxDwQ-EvdH_VemoxyVyweuaBLOC_8cmOzyx7Gy-q6-X8KGT1d_rhAn_ekXnhpCkA_REHh2F0dG5ldHOIAAAAAAAAAACEZXRoMpBMfxReAmd2k___________gmlkgnY0gmlwhJNLR9mJc2VjcDI1NmsxoQJB10N42nK6rr7Q_NIJNkJFi2uo6itMTOQlPZDcCy09T4hzeW5jbmV0c4gAAAAAAAAAAIN0Y3CCIyiDdWRwgiMo,enr:-MS4QEw_RpORuoXgJ0279QuVLLFAiXevNdYtU7vR8S1CY7X9CS6tceMbaxdIIJYRmHN43ClqHtE2b0H0maSb18cm9D0Hh2F0dG5ldHOIAAAAAAAAAACEZXRoMpBMfxReAmd2k___________gmlkgnY0gmlwhJNLR9mJc2VjcDI1NmsxoQOkQIyCVHLbLjIFMjqNSJEUsbYMe4Tsv9blUWvN6Rsft4hzeW5jbmV0c4gAAAAAAAAAAIN0Y3CCIymDdWRwgiMp" \
> /root/logs/beacon_2.log &
```

































