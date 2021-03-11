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

* Get all NEP-17 balance of `neo-consensus`' address `NKvR5WeczCQMcVWQD9aaMqegfEoCBXGWpW`, specifically:

```
curl http://127.0.0.1:40332 -d '{"jsonrpc":"2.0","method":"getnep17balances","params":["NKvR5WeczCQMcVWQD9aaMqegfEoCBXGWpW"],"id":1}'
```

* Send 100 NEO from `neo-consensus`' address `NKvR5WeczCQMcVWQD9aaMqegfEoCBXGWpW` to `neo-client1`'s address `NdihqSLYTf1B1WYuzhM52MNqvCNPJKLZaz`:

```
curl http://127.0.0.1:40332 -d '{"jsonrpc":"2.0","method":"sendfrom","params":["0xef4073a0f2b305a38ec4050e4d3d28bc40ea63f5","NKvR5WeczCQMcVWQD9aaMqegfEoCBXGWpW", "NdihqSLYTf1B1WYuzhM52MNqvCNPJKLZaz",100],"id":1}'
```

* Open the wallet of the `neo-client1` through JSON-RPC (**only for test purposes!**):

```
curl http://127.0.0.1:10332 -d '{"jsonrpc":"2.0","method":"openwallet","params":["wallet.json","neo"],"id":1}'
```

* Get all NEP-17 balance of `neo-client1`' address `NdihqSLYTf1B1WYuzhM52MNqvCNPJKLZaz` (wait 15 seconds before executing the command, due to the block generation interval): 

```
curl http://127.0.0.1:10332 -d '{"jsonrpc":"2.0","method":"getnep17balances","params":["NdihqSLYTf1B1WYuzhM52MNqvCNPJKLZaz"],"id":1}'
```

## :bulb: Info

The `docker-compose` file has 3 nodes, each with an account. The consensus node uses one public key for two accounts. One is a multisig account and the other a normal account. The multisig account is required as the validator account. Private keys are encrypted according to NEP-2.

* **Consensus**
  * Address: `NUrPrFLETzoe7N2FLi2dqTvLwc9L2Em84K`
    * ScriptHash: `0336edcdb5bfe515685fab7aab26937f6f0e0c62`
    * Script: `0c21036cfcc5d0550d0481b66f58e25067280f042b4933fc013dc4930ce2a4194c9d9441747476aa`
    * PubKey: `036cfcc5d0550d0481b66f58e25067280f042b4933fc013dc4930ce2a4194c9d94`
    * PrivKey: ``
    * NEP-2 encrypted: `6PYRSp9YqwcNpUz4bgvFi74CNQBGRkx3snsy2og53a7NLrRwtYTXpBFfye`
    * WIF: `L24Qst64zASL2aLEKdJtRLnbnTbqpcRNWkWJ3yhDh2CLUtLdwYK2`
  * MultiSig Address (from the account above, 1/1): `NKvR5WeczCQMcVWQD9aaMqegfEoCBXGWpW`
    * Script: `110c21036cfcc5d0550d0481b66f58e25067280f042b4933fc013dc4930ce2a4194c9d9411417bce6ca5`
    * ScritpHash: `483fa7396b0c6a4886bb07364ba3f9ba249d1500`
  * JSON-RPC: `localhost:40332`
* **Client1**
  * Address: `NdihqSLYTf1B1WYuzhM52MNqvCNPJKLZaz`
    * Script: `0c2103a24144ca271aa3cec6516e3ac858138ece0a4d071c3868209d16681d0b3f3e9a41747476aa`
    * ScripthHash: `fb2b60c9ea35be51abf741981e7c4954eedf50c3`
    * PubKey: `03a24144ca271aa3cec6516e3ac858138ece0a4d071c3868209d16681d0b3f3e9a`
    * PrivKey: ``
    * NEP-2 encrypted: `6PYPK5YQkHyZP9aDPLunxMcuECxFaWJCVyDfjPJn29pMNmBStiKY6D81xv`
    * WIF: `L3gSLs2CSRYss1zoTmSB9hYAxqimn7Br5yDomH8FDb6NDsupeRVK`
  * JSON-RPC: `localhost:10332`
* **Client2**
  * Address: `NRxkBhm3yyWH8qZxPvVR27FiWcGwWxgGZN`
    * Script: `0c2102b21a75d33eaa705410bc50b103a9abe27651d431d03e97bc9a36a459b38fd38e41747476aa`
    * ScriptHash: `361d0a0d69b3f0c340dd01f28ca8052165265742`
    * PubKey: `02b21a75d33eaa705410bc50b103a9abe27651d431d03e97bc9a36a459b38fd38e`
    * PrivKey: ``
    * NEP-2 encrypted: `6PYVvtyxedhiBjYX9kvBkRUiDvy2HSsku87h5UYMazs1JmwMdo2DTnpg2R`
    * WIF: `L4oDbG4m9f7cnHyawQ4HWJJSrcVDZ8k3E4YxL7Ran89FL2t31hya`
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

