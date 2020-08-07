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

* Get the NEO balance of all addresses in `neo-consensus` wallet:

```
curl http://127.0.0.1:40332 -d '{"jsonrpc":"2.0","method":"getbalance","params":["0xde5f57d430d3dece511cf975a8d37848cb9e0525"],"id":1}'
```

* Get all NEP-5 balance of `neo-consensus`' address `AGZLEiwUyCC4wiL5sRZA3LbxWPs9WrZeyN`, specifically:

```
curl http://127.0.0.1:40332 -d '{"jsonrpc":"2.0","method":"getnep5balances","params":["AGZLEiwUyCC4wiL5sRZA3LbxWPs9WrZeyN"],"id":1}'
```

* Send 100 NEO from `neo-consensus`' address `AGZLEiwUyCC4wiL5sRZA3LbxWPs9WrZeyN` to `neo-client1`'s address `AZt9DgwW8PKSEQsa9QLX86SyE1DSNjSbsS`:

```
curl http://127.0.0.1:40332 -d '{"jsonrpc":"2.0","method":"sendfrom","params":["0xde5f57d430d3dece511cf975a8d37848cb9e0525","AGZLEiwUyCC4wiL5sRZA3LbxWPs9WrZeyN","AZt9DgwW8PKSEQsa9QLX86SyE1DSNjSbsS",100],"id":1}'
```

* Open the wallet of the `neo-client1` through JSON-RPC (**only for test purposes!**):

```
curl http://127.0.0.1:10332 -d '{"jsonrpc":"2.0","method":"openwallet","params":["wallet.json","neo"],"id":1}'
```

* Get the NEO balance of `neo-client1` wallet:

```
curl http://127.0.0.1:10332 -d '{"jsonrpc":"2.0","method":"getbalance","params":["0xde5f57d430d3dece511cf975a8d37848cb9e0525"],"id":1}'
```

## :bulb: Info

The `docker-compose` file has 3 nodes, each with an account. The consensus node uses one public key for two accounts. One is a multisig account and the other a normal account. The multisig account is required as the validator account. Private keys are encrypted according to NEP-2.

* **Consensus**
  * Address: `AJunErzotcQTNWP2qktA7LgkXZVdHea97H`
    * ScriptHash: `cc45cc8987b0e35371f5685431e3c8eeea306722`
    * Script: `0c21026aa8fe6b4360a67a530e23c08c6a72525afde34719c5436f9d3ced759f939a3d0b4195440d78`
    * PubKey: `026aa8fe6b4360a67a530e23c08c6a72525afde34719c5436f9d3ced759f939a3d`
    * PrivKey: `7fe9d4b69f85c1fe15387a76e79d2b95c4c9e3fe756de3435afbc077d99d5346`
    * NEP-2 encrypted: `6PYLykbKcbwnCuTJiQQ5PYu5uH9NgwGYLoMyTUabRxRJUsiA9GP8NgorUV`
    * WIF: `L1WMhxazScMhUrdv34JqQb1HFSQmWeN2Kpc1R9JGKwL7CDNP21uR`
  * MultiSig Address (from the above account, 1/1): `AGZLEiwUyCC4wiL5sRZA3LbxWPs9WrZeyN`
    * Script: `110c21026aa8fe6b4360a67a530e23c08c6a72525afde34719c5436f9d3ced759f939a3d110b41138defaf`
    * ScritpHash: `afaed076854454449770763a628f379721ea9808`
  * JSON-RPC: `localhost:40332`
* **Client1**
  * Address: `AZt9DgwW8PKSEQsa9QLX86SyE1DSNjSbsS`
    * Script: `0c21030ba3f5cb0676ef4eadc89f4da74a6eade644b87aed9a123a117f144ff247052c0b4195440d78`
    * ScripthHash: `f7014e6d52fe8f94f7c57acd8cfb875b4ac2a1c6`
    * PubKey: `030ba3f5cb0676ef4eadc89f4da74a6eade644b87aed9a123a117f144ff247052c`
    * PrivKey: `cc78d926620ba76a5521aa0d373cf9ba4acf7f99bba48e459b8482104d1626f9`
    * NEP-2 encrypted: `6PYXCysTUt8kXppraRBk8aUwYGPqpxESxjSmbHDHjXXBRJnAbVZD6zdveL`
    * WIF: `L45BGYyybk91pvwH3Mj1CfDZ11GGQLVPr6qfzpWugeP4WeJZyfki`
  * JSON-RPC: `localhost:10332`
* **Client2**
  * Address: `ARhJPYxmizqheBQA2dSQAHWfQQsbTSba2S`
    * Script: `0c2102b0aa85eaf261b000947dd6a9753b91bfc7ab058951e2d838cf3ecdab81cc291d0b4195440d78`
    * ScriptHash: `b1e8f1ce80c81dc125e7d0e75e5ce3f7f4d4d36c`
    * PubKey: `02b0aa85eaf261b000947dd6a9753b91bfc7ab058951e2d838cf3ecdab81cc291d`
    * PrivKey: `a7038726c5a127989d78593c423e3dad93b2d74db90a16c0a58468c9e6617a87`
    * NEP-2 encrypted: `6PYSAe53CzgXq9yg7hmHQogZHxasVY2gYGB9rLXNbdggFyy2HBDdJhXZSp`
    * WIF: `L2pN4EbagTuk9Kiib8sjRmMQznxqCVEs1HR8DRaxmnPicjg9FdNc`
  * JSON-RPC: `localhost:20332`

* **Wallet passphrase**: `neo`

* **Asset addresses/hashes**:
  * NEO: `0xde5f57d430d3dece511cf975a8d37848cb9e0525`
  * GAS: `0x668e0c1f9d7b70a99dd9e06eadd4c784d641afbc`

## :soon: Upcoming Features

- [ ] Pre-fund wallets of `neo-client1` and `neo-client2` with plenty of NEO and GAS
- [ ] Automatically deploy smart contracts specified in a given local directory
- [ ] Option to start more consensus nodes, if desired

If you would like to see anything else, give us a shout and [open an issue](https://github.com/AxLabs/neo3-privatenet-docker/issues).

## :pray: Thanks

* We have to thank [hal0x2328](https://github.com/hal0x2328) for publishing [hal0x2328/neo3-privatenet-tutorial](https://github.com/hal0x2328/neo3-privatenet-tutorial) and inspire us to make things even simpler. :smiley: :wink:
* Thanks for [Tommo-L](https://github.com/Tommo-L) by providing the amazing [Tommo-L/NEO3-Development-Guide](https://github.com/Tommo-L/NEO3-Development-Guide) -- certainly, this development guide is complementary to the [AxLabs/neo3-privatenet-docker](https://github.com/AxLabs/neo3-privatenet-docker) repository.

