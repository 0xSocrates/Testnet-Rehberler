<h1 align="center"> Gitshock Cartenz Chain </h1>
<div align="center">





![image](https://user-images.githubusercontent.com/108215275/229382287-58aae37d-cab5-4b8e-85c9-c6fc768e8e70.png)

## Gitshock official accounts: [Twitter](https://twitter.com/gitshock)|[Discord](https://discord.gg/Gu22k9cu)|[Github](https://github.com/gitshock-labs)|[Docs](https://docs.gitshock.com/)

</div>

# About Gitshock's Cartenz Chain
> ### Gitshock Cartenz is an testnet blockchain name of Gitshock Chain EVM. The blockchain is powered with Ethereum 2.0. SDKs and consist of 2 layers; the execution layer and consensus layer. The Cartenz Chain will be designed to follow the Security of Ethereum and support the development of Gitshock Finance ecosystem, connected to various EVMs and Cosmos Chain.
> ### Cartenz Chain is a fork of Ethereum Beaconchain built for Gitshock EVM testnet
> ### Client software is required to create a node and connect to the blockchain. Cartenz Chain is an EVM compatible blockchain and Ethereum clients are used to connect to the Cartenz Chain.
> ### In this guide, we will connect to the Cartenz Chain using Geth clients for the Execution layer and Lighthouse clients for the Consensus layer. (You can also join the network with other clients.)
> ### System requirements (recommended):
>  - 4CPU 4GB RAM 250-500 GB SSD

# Update Server
```
sudo apt-get update && sudo apt-get upgrade -y
```
# Libraries
```
sudo apt install curl tar wget tmux htop net-tools clang  libssl-dev jq micro build-essential git screen gcc g++ cmake pkg-config llvm-dev libclang-dev clang protobuf-compiley make ncdu -y 
```

# Go
```
cd
wget https://go.dev/dl/go1.19.1.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.19.1.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile
```
# Geth
```
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt update -y
sudo apt install ethereum -y
sudo apt install jq
go install github.com/protolambda/eth2-testnet-genesis@latest
go install github.com/protolambda/eth2-val-tools@latest
```

# Rust
```
cd 
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
``` 
# Lighthouse
```
git clone https://github.com/sigp/lighthouse.git
cd lighthouse
git checkout stable
make
```
## Save your name and wallet address in bash_profile
> ### You can create a new wallet from metamask for the wallet address
```
echo "export NAME="<yournameornick>"" >> $HOME/.bash_profile
echo "export WALLET="<walletaddress>"" >> $HOME/.bash_profile
source $HOME/.bash_profile
```
# Installing Repository
```
cd
git clone https://github.com/gitshock-labs/testnet-list
```
# Create log files
> ### Enter commands one by one.
```
mkdir beacon-1
mkdir beacon-2 
mkdir validator
mkdir logs
cd logs
touch erigon.log
touch beacon_1.log
touch beacon_2.log
touch validator.log
cd ..
```
# İnstalling Deposit-CLI
```
git clone https://github.com/gitshock-labs/staking-cli.git
cd staking-cli
git checkout main
sudo apt install python3-pip -y
pip3 install -r requirements.txt
sudo python3 setup.py install
./deposit.sh install
```
## Create deposit and staking address
```
./deposit.sh new-mnemonic
```
> ### After entering the command
> - Type `3` for the first question
> - Type `4` for the second question
> - Next question is how many validators will you run, type `1`
> - The question is which chain to run it on, type `cartenz` and enter.
> - Finally, it will ask you to create a password.
![image](https://user-images.githubusercontent.com/108215275/229634233-dcdd0f2c-79a1-4b98-bc04-598c40de188e.png)
> ### After entering your password, mnemonics will appear. Keep and save them in a safe place. Then press any key and it will ask you to enter the mnemonics again. And validator keys will be generated. 
> - ![image](https://user-images.githubusercontent.com/108215275/229634571-69ba507a-b2eb-41b5-be20-fb1b648f4b1f.png)
> 

# Create a JWT Secret
```
cd ..
openssl rand -hex 32 | tr -d "\n" > "jwt.hex"
```
# Write custom genesis block
```
geth --datadir /root/testnet-list/cartenz-data init /root/testnet-list/execution/genesis.json
```

# Create a new execution layer account
> ### Your new account is locked with a password. give a password and do not forget it.
```
geth account new --datadir "cartenz-data"
```

# Running Execution Layer
```
nohup geth \
--http --http.api="admin,eth,net,web3,txpool" \
--http.port 8545 \
--authrpc.port 8551 \
--discovery.port 30303 \
--port 30303 \
--http.addr 0.0.0.0 \
--authrpc.addr 0.0.0.0 \
--authrpc.jwtsecret /root/testnet-list/jwt.hex \
--datadir /root/testnet-list/cartenz-data \
--http.corsdomain=* \
--http.vhosts=* \
--networkid=1881 \
--syncmode=full \
--identity "$NAME" \
--cache 1024 \
--bootnodes "enode://0e2b41699b95e8c915f4f5d18962c0d2db35dc22d3abbebbd25fc48221d1039943240ad37a6e9d853c0b4ea45da7b6b5203a7127b5858c946fc040cace8d2d63@147.75.71.217:30303,enode://45b4fff6ab970e1e490deea8a5f960d806522fafdb33c8eaa38bc0ae970efc2256fc5746f0ecfec770af24c44864a3e6772a64f2e9f031f96fd4af7fd0483110@147.75.71.217:30304" \
> /root/testnet-list/logs/geth.log &
```

# Login to Geth Interactive Console
```
geth attach http://localhost:8545
``` 
> ### To find your peer address
>  - `admin.nodeInfo.enode`
>  ### To see the peers you are connected to
>  - `admin.peers`
>  ### If there is one or more of the names on this site among the peers you are connected to, you can proceed to the next step.
>   - For Example
>   ![image](https://user-images.githubusercontent.com/108215275/229636258-5697707d-d6c4-44d3-976d-868c8a330e9d.png) ![image](https://user-images.githubusercontent.com/108215275/229636278-81a3754c-a9d1-492e-80f8-55bf3099aa99.png)
> ### If you need to add peer;
> - `admin.addPeer("enode://0e2b41699b95e8c915f4f5d18962c0d2db35dc22d3abbebbd25fc48221d1039943240ad37a6e9d853c0b4ea45da7b6b5203a7127b5858c946fc040cace8d2d63@147.75.71.217:30303")`
> - `admin.addTrustedPeer("enode://0e2b41699b95e8c915f4f5d18962c0d2db35dc22d3abbebbd25fc48221d1039943240ad37a6e9d853c0b4ea45da7b6b5203a7127b5858c946fc040cace8d2d63@147.75.71.217:30303")`
> - Exit the console with `exit`.

# Running Consensus Layer
```
 nohup lighthouse \
--testnet-dir="/root/testnet-list/consensus" \
--datadir /root/testnet-list/beacon-1 \
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
--jwt-secrets="/root/testnet-list/jwt.hex" \
--graffiti "$NAME" \
--suggested-fee-recipient=$WALLET \
> /root/testnet-list/logs/beacon_1.log &
```

# Getting ENR Key
> ### Save the output.
```
curl http://localhost:5052/eth/v1/node/identity | jq
```
# Running Other Consensus Layer
```
nohup lighthouse beacon \
--testnet-dir="/root/testnet-list/consensus" \
--datadir /root/testnet-list/beacon-2 \
--http \
--eth1 \
--gui \
--http-address 127.0.0.1 \
--http-allow-origin="*" \
--http-allow-sync-stalled \
--execution-endpoints http://127.0.0.1:8551 \
--http-port 5053 \
--enr-udp-port=9001 \
--enr-tcp-port=9001 \
--discovery-port=9001 \
--port=9001 \
--jwt-secrets="/root/testnet-list/jwt.hex" \
--graffiti "$NAME" \
--suggested-fee-recipient="$WALLET" \
--boot-nodes="$(curl http://localhost:5052/eth/v1/node/identity | jq .data.enr),enr:-MS4QHXShZPtKwtexK2p9yCxMxDwQ-EvdH_VemoxyVyweuaBLOC_8cmOzyx7Gy-q6-X8KGT1d_rhAn_ekXnhpCkA_REHh2F0dG5ldHOIAAAAAAAAAACEZXRoMpBMfxReAmd2k___________gmlkgnY0gmlwhJNLR9mJc2VjcDI1NmsxoQJB10N42nK6rr7Q_NIJNkJFi2uo6itMTOQlPZDcCy09T4hzeW5jbmV0c4gAAAAAAAAAAIN0Y3CCIyiDdWRwgiMo,enr:-MS4QEw_RpORuoXgJ0279QuVLLFAiXevNdYtU7vR8S1CY7X9CS6tceMbaxdIIJYRmHN43ClqHtE2b0H0maSb18cm9D0Hh2F0dG5ldHOIAAAAAAAAAACEZXRoMpBMfxReAmd2k___________gmlkgnY0gmlwhJNLR9mJc2VjcDI1NmsxoQOkQIyCVHLbLjIFMjqNSJEUsbYMe4Tsv9blUWvN6Rsft4hzeW5jbmV0c4gAAAAAAAAAAIN0Y3CCIymDdWRwgiMp" \
> /root/testnet-list/logs/beacon_2.log
```

# If you've made it this far without any errors.
## Geth logs will look like this first
> ### `tail -f /root/testnet-list/logs/geth.log`
![image](https://user-images.githubusercontent.com/108215275/229638094-9fff98c5-1443-4420-9300-48a4a0c06661.png)

## Then it will look like this
![image](https://user-images.githubusercontent.com/108215275/229638381-478ef819-66f2-4c18-9cc2-4bb018c4a957.png)


## Beacon_1 logs
> ### `tail -f /root/testnet-list/logs/beacon_1.log`

![image](https://user-images.githubusercontent.com/108215275/229638522-b6c7fa8e-54dd-4e4b-8856-729e4912b09d.png)

## Beacon_2 logs
> ### `tail -f /root/testnet-list/logs/beacon_2.log`
![image](https://user-images.githubusercontent.com/108215275/229638665-5cc2c76b-8337-4f18-9ad3-74d7161afa26.png)

### Finally, send your ip address to `#cartenz-testnet-server` channel in discord. Your node will start appearing on [nodemoon](https://nodemoon.cartenz.works/).

