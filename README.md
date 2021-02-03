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

* Get all NEP-17 balance of `neo-consensus`' address `NX8GreRFGFK5wpGMWetpX93HmtrezGogzk`, specifically:

```
curl http://127.0.0.1:40332 -d '{"jsonrpc":"2.0","method":"getnep17balances","params":["NX8GreRFGFK5wpGMWetpX93HmtrezGogzk"],"id":1}'
```

* Send 100 NEO from `neo-consensus`' address `NX8GreRFGFK5wpGMWetpX93HmtrezGogzk` to `neo-client1`'s address `NLnyLtep7jwyq1qhNPkwXbJpurC4jUT8ke`:

```
curl http://127.0.0.1:40332 -d '{"jsonrpc":"2.0","method":"sendfrom","params":["0xde5f57d430d3dece511cf975a8d37848cb9e0525","NX8GreRFGFK5wpGMWetpX93HmtrezGogzk","NLnyLtep7jwyq1qhNPkwXbJpurC4jUT8ke",100],"id":1}'
```

* Open the wallet of the `neo-client1` through JSON-RPC (**only for test purposes!**):

```
curl http://127.0.0.1:10332 -d '{"jsonrpc":"2.0","method":"openwallet","params":["wallet.json","neo"],"id":1}'
```

* Get all NEP-17 balance of `neo-client1`' address `NLnyLtep7jwyq1qhNPkwXbJpurC4jUT8ke`:

```
curl http://127.0.0.1:10332 -d '{"jsonrpc":"2.0","method":"getnep17balances","params":["NLnyLtep7jwyq1qhNPkwXbJpurC4jUT8ke"],"id":1}'
```

## :bulb: Info

The `docker-compose` file has 3 nodes, each with an account. The consensus node uses one public key for two accounts. One is a multisig account and the other a normal account. The multisig account is required as the validator account. Private keys are encrypted according to NEP-2.

* **Consensus**
  * Address: `NZNos2WqTbu5oCgyfss9kUJgBXJqhuYAaj`
    * ScriptHash: `0f46dc4287b70117ce8354924b5cb3a47215ad93`
    * Script: `0c2102163946a133e3d2e0d987fb90cb01b060ed1780f1718e2da28edf13b965fd2b600b4195440d78`
    * PubKey: `02163946a133e3d2e0d987fb90cb01b060ed1780f1718e2da28edf13b965fd2b60`
    * PrivKey: `c2b590be636cb7a2377d40bf13d948bed85fe45e155ecf839dba0df45e4a35f0`
    * NEP-2 encrypted: `6PYNxavNrrWiCNgLtd5WJjerGUwJD7LPp5Pzt85azUo4nLHL9dUkJaYtAo`
    * WIF: `L3kCZj6QbFPwbsVhxnB8nUERDy4mhCSrWJew4u5Qh5QmGMfnCTda`
  * MultiSig Address (from the above account, 1/1): `NX8GreRFGFK5wpGMWetpX93HmtrezGogzk`
    * Script: `110c2102163946a133e3d2e0d987fb90cb01b060ed1780f1718e2da28edf13b965fd2b60110b41138defaf`
    * ScritpHash: `ec2b32ed87e3747e826a0abd7229cb553220fd7a`
  * JSON-RPC: `localhost:40332`
* **Client1**
  * Address: `NLnyLtep7jwyq1qhNPkwXbJpurC4jUT8ke`
    * Script: `0c2102249425a06b5a1f8e6133fc79afa2c2b8430bf9327297f176761df79e8d8929c50b4195440d78`
    * ScripthHash: `d6c712eb53b1a130f59fd4e5864bdac27458a509`
    * PubKey: `02249425a06b5a1f8e6133fc79afa2c2b8430bf9327297f176761df79e8d8929c5`
    * PrivKey: `0f7d2f77f3229178650b958eb286258f0e6533d0b86ec389b862c440c6511a4b`
    * NEP-2 encrypted: `6PYVEi6ZGdsLoCYbbGWqoYef7VWMbKwcew86m5fpxnZRUD8tEjainBgQW1`
    * WIF: `KwjpUzqHThukHZqw5zu4QLGJXessUxwcG3GinhJeBmqj4uKM4K5z`
  * JSON-RPC: `localhost:10332`
* **Client2**
  * Address: `NWcx4EfYdfqn5jNjDz8AHE6hWtWdUGDdmy`
    * Script: `0c21031ccaaa46df7c494f442698c8c17c09311e3615c2dc042cbd3afeaba60fa407400b4195440d78`
    * ScriptHash: `3d255cc204f151498dcac95da244babb895e7175`
    * PubKey: `031ccaaa46df7c494f442698c8c17c09311e3615c2dc042cbd3afeaba60fa40740`
    * PrivKey: `3d7f55bf3fd8bfdaa8c8dd36bc5b4e003f8c90a39da9916fcecf38c5be94bd1c`
    * NEP-2 encrypted: `6PYSQWBqZE5oEFdMGCJ3xR7bz6ezz814oKE7GqwB9i5uhtUzkshe9B6YGB`
    * WIF: `KyHFg26DHTUWZtmUVTRqDHg8uVvZi9dr5zV3tQ22JZUjvWVCFvtw`
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

