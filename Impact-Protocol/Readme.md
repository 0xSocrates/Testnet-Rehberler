<h1 align="center"> Impact Protocol </h1>

<div align="center">




  
</div>
  
# Güncelleme ve Kütüphaneler
```
sudo apt-get update -y && sudo apt-get upgrade -y
```
```
sudo apt install curl tar wget tmux htop net-tools clang libssl-dev jq micro build-essential git screen gcc g++ cmake pkg-config llvm-dev libclang-dev clang protobuf-compiler make ncdu software-properties-common -y 
```
```
sudo apt-get install protobuf-compiler -y
```

# Rust Kurulumu
> ### Komutları tek tek girin
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
rustc --version
rustup default stable
rustup update
rustup update nightly
rustup target add wasm32-unknown-unknown --toolchain nightly
rustup +nightly show
```
> ### Son komutu girdikten sonra çıktı bu şekilde :
> ![image](https://github.com/0xSocrates/Testnet-Rehberler/assets/108215275/befa99c3-8030-4728-a773-0c71e6f73c32)

# Impact Protocol Kurulumu
```
git clone https://github.com/GlobalBoost/impactprotocol
cd impactprotocol
cargo build --release
```
> ### Bu kısım uzun sürecek
```
sudo cp $HOME/impactprotocol/target/release/impact /usr/local/bin/
```
# Mining-Key Oluşturun
> ### Çıktısını kaydedip saklayın
```
impact generate-mining-key --chain=impact-testnet
```
#  Mining-Key Import Edin
> ### " " içinde `<seed_phrase>` yazan yere önceki komutta aldığınız kelimeleri girin.
```
impact import-mining-key "<seed_phrase>" \--base-path /tmp/impactnode \--chain=impact-testnet
```
# İsim ve pubkey değişkenlerini atayın
```
PUBKEY="pubkeyyazın"
NAME="nodeismi"
```
```
echo "export PUBKEY="$PUBKEY"" >> $HOME/.bash_profile
echo "export NAME="$NAME"" >> $HOME/.bash_profile
source $HOME/.bash_profile
```

# Service Oluşturun
```
sudo tee /etc/systemd/system/impact.service > /dev/null <<EOF
[Unit]
Description=impact-node
After=network.target
[Service]
User=$USER
Type=simple
ExecStart=$(which impact) --base-path /tmp/impactnode --chain=impact-testnet --port 30333 --ws-port 9945 --rpc-port 9933 --telemetry-url "wss://telemetry.polkadot.io/submit/ 0" --validator --author $PUBKEY  --rpc-methods Unsafe --name $NAME
Restart=on-failure
RestartSec=5
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
```
# Başlatın
```
sudo systemctl daemon-reload
sudo systemctl enable impact
sudo systemctl start impact
sudo systemctl restart impact
```
# Log Görüntüleme
```
sudo journalctl -u impact -fo cat
```






















