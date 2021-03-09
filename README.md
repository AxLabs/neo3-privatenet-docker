[![License](https://img.shields.io/github/license/AxLabs/neo3-privatenet-docker)](https://github.com/AxLabs/neo3-privatenet-docker/blob/master/LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/AxLabs/neo3-privatenet-docker?style=social)](https://github.com/AxLabs/neo3-privatenet-docker/stargazers)

<div align="center" style="margin-top: 50pt; margin-bottom: 50px;">  
<h1>neo3-privatenet-docker</h1>
<p align="center" style="margin-top: 30pt;">
  :fire::zap::fire::zap::fire:
  <b>Run Neo3 blockchain nodes for development in record time!</b>
  :fire::zap::fire::zap::fire:
</p>

<p>You're <b>3 commands away</b> to set up a Neo3 blockchain private network.</p>
</div>

## :tada: Highlights

* :green_heart: This repository relies on [git sub-modules](https://git-scm.com/book/en/v2/Git-Tools-Submodules) pointing to the official [neo-node](https://github.com/neo-project/neo-modules/) and [neo-modules](https://github.com/neo-project/neo-node/). Then, you can adjust the reference if you want to rely on the latest or an specific commit!
* :rocket: The neo-cli image is built from the official `Dockerfile` from [neo-node](https://github.com/neo-project/neo-node/).
* :100: Includes **all** available plugins from [neo-modules](https://github.com/neo-project/neo-modules/)
* :boom: *It just fucking works.*

 :star: Ah, we love GitHub stars to keep our motivation up to the roof! :wink:

## :rotating_light: Dependencies
 - [docker](https://docs.docker.com/install/): [MacOS](https://docs.docker.com/docker-for-mac/install/) or [Windows](https://docs.docker.com/docker-for-windows/install/)
 - [docker-compose](https://docs.docker.com/compose/install/)

## :running: How to Run

```
git clone --recurse-submodules https://github.com/AxLabs/neo3-privatenet-docker.git
cd neo3-privatenet-docker
docker-compose up
```

Then, check the running privatenet:

```
docker ps
```

If you want to stop everything and start from **scratch**:

```
docker-compose down -v
```

After you change something in the config files and want to rebuild everything, without docker cache, run the following:

```
docker-compose build --no-cache

```

## :zap: Test a bit through JSON-RPC

* Get the latest block index of `neo-client1`:

```
curl http://127.0.0.1:10332 -d '{"jsonrpc":"2.0","method":"getblockcount","params":[],"id":1}'
```

* Open the wallet of the `neo-consesus` through JSON-RPC (**only for test purposes!**):

```
curl http://127.0.0.1:40332 -d '{"jsonrpc":"2.0","method":"openwallet","params":["wallet.json","neo"],"id":1}'
```

* List the addresses in `neo-consensus` wallet:

```
curl http://127.0.0.1:40332 -d '{"jsonrpc":"2.0","method":"listaddress","params":[],"id":1}'
```

* Get all NEP-17 balance of `neo-consensus`' address `NenSmoMsddbu1GPho4PaQ6JyutsrCiMErN`, specifically:

```
curl http://127.0.0.1:40332 -d '{"jsonrpc":"2.0","method":"getnep17balances","params":["NenSmoMsddbu1GPho4PaQ6JyutsrCiMErN"],"id":1}'
```

* Send 100 NEO from `neo-consensus`' address `NenSmoMsddbu1GPho4PaQ6JyutsrCiMErN` to `neo-client1`'s address `Nh68D3LxUnNyXd5GXDoSrWxwwMRPZvQfcf`:

```
curl http://127.0.0.1:40332 -d '{"jsonrpc":"2.0","method":"sendfrom","params":["0xef4073a0f2b305a38ec4050e4d3d28bc40ea63f5","NX8GreRFGFK5wpGMWetpX93HmtrezGogzk","Nh68D3LxUnNyXd5GXDoSrWxwwMRPZvQfcf",100],"id":1}'
```

* Open the wallet of the `neo-client1` through JSON-RPC (**only for test purposes!**):

```
curl http://127.0.0.1:10332 -d '{"jsonrpc":"2.0","method":"openwallet","params":["wallet.json","neo"],"id":1}'
```

* Get all NEP-17 balance of `neo-client1`' address `Nh68D3LxUnNyXd5GXDoSrWxwwMRPZvQfcf`:

```
curl http://127.0.0.1:10332 -d '{"jsonrpc":"2.0","method":"getnep17balances","params":["NLnyLtep7jwyq1qhNPkwXbJpurC4jUT8ke"],"id":1}'
```

## :bulb: Info

The `docker-compose` file has 3 nodes, each with an account. The consensus node uses one public key for two accounts. One is a multisig account and the other a normal account. The multisig account is required as the validator account. Private keys are encrypted according to NEP-2.

* **Consensus**
  * Address: `NWe7QPpyQEs4hn2ERrpYhYKtTmnrgGyRTA`
    * ScriptHash: `9aa087800d1692c1a5a7bc6fe3fb59de9396a975`
    * Script: `0c2102ed6a5a41133de5cfd72aa58c03c4744851177d1bcacdf4a989864ed1a5ca307a41747476aa`
    * PubKey: `02ed6a5a41133de5cfd72aa58c03c4744851177d1bcacdf4a989864ed1a5ca307a`
    * PrivKey: ``
    * NEP-2 encrypted: `6PYQBmoBLW6aMhsk6o6HwLXX1b8ZRMmDERgeqdixq1jgRw5s4fRGLKX3v7`
    * WIF: `L3Bzy2gbdZhg19jwtUjrFTEoK27MQYuUetw3ZrYEhfs5UZVc1ZzN`
  * MultiSig Address (from the account above, 1/1): `NenSmoMsddbu1GPho4PaQ6JyutsrCiMErN`
    * Script: `110c2102ed6a5a41133de5cfd72aa58c03c4744851177d1bcacdf4a989864ed1a5ca307a11417bce6ca5`
    * ScritpHash: `d3e7a3499a3e5efe21ae939485677c1f3417fece`
  * JSON-RPC: `localhost:40332`
* **Client1**
  * Address: `Nh68D3LxUnNyXd5GXDoSrWxwwMRPZvQfcf`
    * Script: `0c2102a6b25bd017f893bf1b19493004f221d5c6c2838f8e8414beddead8e1fe3ca9cd41747476aa`
    * ScripthHash: `e955e46cf825ebe2a1f8d0e4ae0995fa175546e8`
    * PubKey: `02a6b25bd017f893bf1b19493004f221d5c6c2838f8e8414beddead8e1fe3ca9cd`
    * PrivKey: ``
    * NEP-2 encrypted: `6PYMoERNCmTZkHGYFfdbg146GbrLUdm6CEQTeQpeDzz9Pk6xdwMkL7BFvx`
    * WIF: `Kzmp85HYYTB5CFVrJw4bTWVXFFzJskumQrnPXoJAhLu3S1MjpR25`
  * JSON-RPC: `localhost:10332`
* **Client2**
  * Address: `NdnKc2egNfxD1FgJeVmh1itpWRo6AmLZvb`
    * Script: `0c2103506f7c44e07cf2750a440aba5fe5619a8c686a28f2707a4342fd8d5e8c87753141747476aa`
    * ScriptHash: `f6a9192686173445bd5860209f918bce1dfbffc3`
    * PubKey: `03506f7c44e07cf2750a440aba5fe5619a8c686a28f2707a4342fd8d5e8c877531`
    * PrivKey: ``
    * NEP-2 encrypted: `6PYVPGffan6MzQt6vmapUfLg8w6GAk8e2SSosUgpWshcvhTJTWmXWdtvbZ`
    * WIF: `KzpH6emqMpPDtbqYNubvixmjkBvn4z93z4oTX1VDhvDHyd3eBDFB`
  * JSON-RPC: `localhost:20332`

* **Wallet passphrase**: `neo`

* **Asset addresses/hashes**:
  * NEO: `0x0a46e2e37c9987f570b4af253fb77e7eef0f72b6`
  * GAS: `0xa6a6c15dcdc9b997dac448b6926522d22efeedfb`

* **Address Info**:
  * All the addresses have the `AddressVersion` set to `0x35` (which is the [default used in the neo-project](https://github.com/neo-project/neo/blob/402e9b19d80bb9093601f5ac57ff0cdc3c6cf6ab/src/neo/ProtocolSettings.cs#L50))

## :soon: Upcoming Features

- [ ] Pre-fund wallets of `neo-client1` and `neo-client2` with plenty of NEO and GAS
- [ ] Automatically deploy smart contracts specified in a given local directory
- [ ] Option to start more consensus nodes, if desired

If you would like to see anything else, give us a shout and [open an issue](https://github.com/AxLabs/neo3-privatenet-docker/issues).

## :pray: Thanks

* We have to thank [hal0x2328](https://github.com/hal0x2328) for publishing [hal0x2328/neo3-privatenet-tutorial](https://github.com/hal0x2328/neo3-privatenet-tutorial) and inspire us to make things even simpler. :smiley: :wink:
* Thanks for [Tommo-L](https://github.com/Tommo-L) by providing the amazing [Tommo-L/NEO3-Development-Guide](https://github.com/Tommo-L/NEO3-Development-Guide) -- certainly, this development guide is complementary to the [AxLabs/neo3-privatenet-docker](https://github.com/AxLabs/neo3-privatenet-docker) repository.

