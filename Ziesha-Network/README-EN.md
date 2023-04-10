<h1 align="center"> Ziesha Network | Tahdig Testnet </h1>

<div align="center">

![image](https://user-images.githubusercontent.com/108215275/230774400-08a2c51b-ee74-4884-95a9-de45d1bd8725.png)

#  [Twitter](https://twitter.com/ZieshaNetwork)|[Discord](https://discord.gg/zieshanetwork)|[Website](https://ziesha.network/)|[Telegram](https://t.me/ZieshaNetworkOfficial)|[Whitepaper](https://hackmd.io/_Sw5u2lUR9GfBV5vwtoMSQ)

</div>

> ### Ziesha's new testnet ***Tahdig*** ***Testnet*** has started.
> ### This testnet will use PoS (Proof-of-Stake) consensus mechanism unlike previous testnets.
> ### Tahdig Testnet is a no incentives testnet that will allow Ziesha community members to test the network and provide feedback.
#
#
> ### Minimum requirements to run a bazuka node: `2CPU 2GB RAM 50GB SSD`.
> ### You can join the testnet by using a single command with the script I have prepared.
> ### Enter the command and follow the instructions.
```
wget https://raw.githubusercontent.com/0xSocrates/Testnet-Rehberler/main/Ziesha-Network/zieshaEN.sh && chmod +x zieshaEN.sh && bash ./zieshaEN.sh
```
#
#
> ### After completing the installation, do not forget to follow Discord announcements for future updates.
> ### If you have any questions, you can ask them on discord.
#
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
bazuka wallet register-validator --commision <commision>
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

























