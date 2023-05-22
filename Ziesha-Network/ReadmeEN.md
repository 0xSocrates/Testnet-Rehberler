<h1 align="center">Ziesha Network | Deruny Testnet</h1>

<div align="center">

![image](https://user-images.githubusercontent.com/108215275/230774400-08a2c51b-ee74-4884-95a9-de45d1bd8725.png)

# [Twitter](https://twitter.com/ZieshaNetwork) | [Discord](https://discord.gg/zieshanetwork) | [Website](https://ziesha.network/) | [Telegram](https://t.me/ZieshaNetworkOfficial) | [Whitepaper](https://hackmd.io/_Sw5u2lUR9GfBV5vwtoMSQ)

</div>

# Hello friends! As you know, significant progress has been made in the development process of Ziesha Network, and we are closer than ever to the mainnet launch.
# The Deruny Testnet, which is planned to be the final and rewarding testnet before the mainnet, has begun.

> ## Testnet participation is open to everyone.
> ## End date is not specified.
> ## Requirements: `2CPU 2RAM 50GB SSD` (minimum)
> ## In this guide, we will set up a full node and then become a validator.
> ## If you want to participate as a prover, continue from [here](https://github.com/ziesha-network/zoro).
> ## After completing the installation, don't forget to follow the Discord announcements for further instructions and future updates.
> ## If you have any questions, feel free to ask on Discord.
# 
> ## You can complete the installation by running this command and following the instructions:
```
curl -sSL -o ziesha.sh https://raw.githubusercontent.com/0xSocrates/Testnet-Rehberler/main/Ziesha-Network/zieshaEN.sh && chmod +x ziesha.sh && bash ziesha.sh
```

> ## After completing the node installation, use this command to register your validator:
```
bazuka wallet register-validator --commission <commission>
```

> ## Then you will need to delegate tokens to your validator. To do this, first obtain tokens from the faucet in Discord.
```
bazuka wallet delegate --amount <amount> --fee <fee> --to <validatoraddress>
```
## That's all for now. Don't forget to stay tuned for announcements and updates.
#

# Usefull Commands
> ### Show logs
```
sudo journalctl -u bazuka -fo cat
```
> ### Restart the node
```
sudo systemctl restart bazuka
```
> ### Get status of the node
```
bazuka node status
```
> ### Show wallet info
```
bazuka wallet info
```
> ### Send money
```
bazuka wallet send --amount <amount> --fee <fee> --from <from> --to <to>
```
> ### Register validator
```
bazuka wallet register-validator --commission <commision>
```
> ### Delegate to a validator
```
bazuka wallet delegate --amount <amount> --fee <fee> --to <to>
```
> ### Reclaim funds inside an ended delegatation back to your account
```
bazuka wallet reclaim-delegate --amount <amount> --fee <fee> --from <from>
```
> ### Creates a new token
```
bazuka wallet new-token --decimals <decimals> --fee <fee> --name <name> --supply <supply> --symbol <symbol>
```
> ### Add a new token to the wallet
```
bazuka wallet add-token --id <id>
```
> ### Resend pending transactions
```
bazuka wallet resend-pending
```
> ### Reset wallet nonces
```
bazuka wallet reset
```
