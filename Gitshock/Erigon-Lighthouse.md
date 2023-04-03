<h1 align="center"> Gitshock Cartenz Chain </h1>
<div align="center">





![image](https://user-images.githubusercontent.com/108215275/229382287-58aae37d-cab5-4b8e-85c9-c6fc768e8e70.png)

## Gitshock resmi hesapları: [Twitter](https://twitter.com/gitshock)|[Discord](https://discord.gg/Gu22k9cu)|[Github](https://github.com/gitshock-labs)|[Docs](https://docs.gitshock.com/)

</div>

# Gitshock Chain EVM Testnet
> ### Cartenz Chain, Gitshock EVM testneti için oluşturulmuş bir Ethereum Beaconchain forkudur.

> ### Bir node oluşturup blok zincire bağlanabilmek için Client yazılımları kullanmak gerekir. Cartenz Chain, EVM uyumlu bir blok zincir olduğundan Ethereum clientleri  Cartenz Chaine bağlanmak için kullanılır. 
> ### Bu rehberde Execution layer için ***Erigon***, Consensus layer için ***Lighthouse*** clientlerini kullanarak Cartenz Chaine bağlanacağız. (başka clientler ile de ağa katılınabilir.)

> ### Kısaca bu rehberde yapacaklarınız:
> - Sunucu güvenlik ayarları (opsiyonel)
> - Go, Erion, Rust, Lighthouse yazılımları ve tüm bunlar için gerekli kütüphanelerin kurulumu.
> - Cartenz chain kaynak dosyalarının kurulumu
> - Execution layer çalıştırma
> - Birinci ve ardından ikinci consensus layerlerini çalıştırma
> - Validatör node başlatmak







# Sunucu
```
sudo apt-get update && sudo apt-get upgrade -y && sudo apt install curl tar wget tmux htop net-tools clang pkg-config libssl-dev jq build-essential git screen make ncdu -y
```
# Güvenlik
> ### Bu kısım isteğe bağlı.

> ### Nodu korumak ve güvenceye almak için bazı temel güvenlik ayarları yapılması gerekir. Burada basit olan ssh portunu değiştirme ve firewal yapılandırmasını anlatacağım. Gitshockun tavsiye ettiği daha kapsamlı güvenlik ayarlarını yapmak isterseniz: [Link](https://docs.gitshock.com/gitshock-testnet-overview/gitshock-chain-evm-testnet/secure-the-server#secure-the-server)

## SSH portunu değiştirin
> `1024–49151` arasında bir port seçin `8545,30303,5052,5053,9000,8550,8551` portları haricinde. Seçtiğiniz portun boşta olduğunu öğrenmek için `sudo netstat -tnlp | grep :<PortNumarası>` komutunu kullanabilirsiniz. Komut bir çıktı vermiyorsa bu portu kullanan bir şey yok demektir.

> SSH yapılandırmasını değiştirin
> - `sudo nano /etc/ssh/sshd_config` komutu ile dosya içine girin.
> - Yön tuşları ile `#Port 22` yazan kısıma gelin `#` işarteini silip `22` yerine değiştirmek istediğiniz port numarasını girin.
> - `CTRL+X` ardından `y` ardından `Enter` ile kaydedip çıkın.

> SSH servisi yeniden başlatın
> - `sudo systemctl restart ssh`
> - Oturumu kapatın ardından yeniden bağlanın. Bağlanırken ssh için değiştirdiğiniz portu kullanmayı unutmayın.

## Firewall yapılandırması
> Default olarak tüm gelen trafiği reddedip giden trafiğe izin verin
> - `sudo ufw default deny incoming`
> - `sudo ufw default allow outgoing`

> SSH portuna izin verin
> - `sudo ufw allow <SSHPort>/tcp`
> - `SSHPort` yazan yeri kendi belirlediğiniz port numarası ile değiştirmeyi unutmayın.

> Kullanılacak portları açın
> - `sudo ufw allow 42069`
> - `sudo ufw allow 42069/tcp`
> - `sudo ufw allow 42069/udp`
> - `sudo ufw allow 8545/tcp`
> - `sudo ufw allow 8550/tcp`
> - `sudo ufw allow 8551/tcp`
> - `sudo ufw allow 5052/tcp` 
> - `sudo ufw allow 5053/tcp` 
> - `sudo ufw allow 9000/tcp`
> - `sudo ufw allow 30303/tcp`
> - `sudo ufw allow 30303/udp`
> - `sudo ufw allow 3000`

> Firewall etkinleştirin
> - `sudo ufw enable`
> - `ufw status` komutu ile ayarları görüntüleyebilirsiniz.


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
cd 
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
# Cartenz Chain kaynak dosyaları
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
> ### Komutları tek tek girin.
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

# İnit
```
erigon --datadir "cartenz-data" init execution/genesis.json
```

# Execution layer çalıştırın
> identity kısmına kendi isminizi yazın.
```
nohup erigon \
--datadir "/root/testnet-list/cartenz-data"  \
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

## Loglara bakmak için
```
tail -f /root/testnet-list/logs/erigon.log
```

# Consensus layer çalıştırın
> ### `graffiti`kısmına kendi isminizi yazın. `CüzdanAdresi` değiştirmeyi unutmayın.
```
nohup lighthouse \
--testnet-dir="/root/testnet-list/consensus" \
bn \
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
--graffiti "Platon" \
--jwt-secrets="/root/testnet-list/jwt.hex" \
--suggested-fee-recipient=CüzdanAdresi \
> /root/testnet-list/logs/beacon_1.log &
```

# ENR key oluşturma
> ### Çıktısını kaydedip saklayın.
```
curl http://localhost:5052/eth/v1/node/identity | jq 
```
## Loglara bakmak için
```
tail -f /root/testnet-list/logs/beacon_1.log
```

# İkinci consensus layeri çalıştırın
> ### `CüzdanAdresi` yazan yeri değiştirmeyi unutmayın.

```
nohup lighthouse \
--testnet-dir /root/testnet-list/consensus \
bn \
--datadir "/root/testnet-list/beacon-2" \
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
--enr-address $(wget -qO- eth0.me) \
--execution-jwt "/root/testnet-list/jwt.hex" \
--suggested-fee-recipient="0xE99B2338E5DD4aCAbEC589003Acc6f80b1a9235a" \
--boot-nodes="$(curl http://localhost:5052/eth/v1/node/identity | jq .data.enr),enr:-MS4QHXShZPtKwtexK2p9yCxMxDwQ-EvdH_VemoxyVyweuaBLOC_8cmOzyx7Gy-q6-X8KGT1d_rhAn_ekXnhpCkA_REHh2F0dG5ldHOIAAAAAAAAAACEZXRoMpBMfxReAmd2k___________gmlkgnY0gmlwhJNLR9mJc2VjcDI1NmsxoQJB10N42nK6rr7Q_NIJNkJFi2uo6itMTOQlPZDcCy09T4hzeW5jbmV0c4gAAAAAAAAAAIN0Y3CCIyiDdWRwgiMo,enr:-MS4QEw_RpORuoXgJ0279QuVLLFAiXevNdYtU7vR8S1CY7X9CS6tceMbaxdIIJYRmHN43ClqHtE2b0H0maSb18cm9D0Hh2F0dG5ldHOIAAAAAAAAAACEZXRoMpBMfxReAmd2k___________gmlkgnY0gmlwhJNLR9mJc2VjcDI1NmsxoQOkQIyCVHLbLjIFMjqNSJEUsbYMe4Tsv9blUWvN6Rsft4hzeW5jbmV0c4gAAAAAAAAAAIN0Y3CCIymDdWRwgiMp" \
> /root/testnet-list/logs/beacon_2.log &
```

## Log kontrolü
```
tail -f /root/testnet-list/logs/beacon_2.log
```


<h1 align="center"> Sonraki İşlemler İçin Güncelleme Bekliyoruz </h1>

























