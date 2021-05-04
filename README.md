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
  * Address: `NM7Aky765FG8NhhwtxjXRx7jEL1cnw7PBP`
    * ScriptHash: `69ecca587293047be4c59159bf8bc399985c160d`
    * Script: `0c21033a4d051b04b7fc0230d2b1aaedfd5a84be279a5361a7358db665ad7857787f1b4156e7b327`
    * PubKey: `033a4d051b04b7fc0230d2b1aaedfd5a84be279a5361a7358db665ad7857787f1b`
    * PrivKey: `84180ac9d6eb6fba207ea4ef9d2200102d1ebeb4b9c07e2c6a738a42742e27a5`
    * NEP-2 encrypted: `6PYM7jHL4GmS8Aw2iEFpuaHTCUKjhT4mwVqdoozGU6sUE25BjV4ePXDdLz`
    * WIF: `L1eV34wPoj9weqhGijdDLtVQzUpWGHszXXpdU9dPuh2nRFFzFa7E`
  * MultiSig Address (from the account above, 1/1): `NXXazKH39yNFWWZF5MJ8tEN98VYHwzn7g3`
    * Script: `110c21033a4d051b04b7fc0230d2b1aaedfd5a84be279a5361a7358db665ad7857787f1b11419ed0dc3a`
    * ScritpHash: `05859de95ccbbd5668e0f055b208273634d4657f`
  * JSON-RPC: `localhost:40332`
* **Client1**
  * Address: `NV1Q1dTdvzPbThPbSFz7zudTmsmgnCwX6c`
    * Script: `0c2102607a38b8010a8f401c25dd01df1b74af1827dd16b821fc07451f2ef7f02da60f4156e7b327`
    * ScripthHash: `88c48eaef7e64b646440da567cd85c9060efbf63`
    * PubKey: `02607a38b8010a8f401c25dd01df1b74af1827dd16b821fc07451f2ef7f02da60f`
    * PrivKey: `beae38739915555a75a9281a5928b10ebc265f9c881aa21e963610a6c606a3dc`
    * NEP-2 encrypted: `6PYWaAbWpf6oeH1VrqtdAGawYMsTfcN1GJyarhUFVEq1siNcRJwMpoo456`
    * WIF: `L3cNMQUSrvUrHx1MzacwHiUeCWzqK2MLt5fPvJj9mz6L2rzYZpok`
  * JSON-RPC: `localhost:10332`
* **Client2**
  * Address: `NhJX9eCbkKtgDrh1S4xMTRaHUGbZ5Be7uU`
    * Script: `0c21037279f3a507817251534181116cb38ef30468b25074827db34cbbc6adc88739324156e7b327`
    * ScriptHash: `b435bf4b8e34b28a73029eb42d0d99a775799eea`
    * PubKey: `037279f3a507817251534181116cb38ef30468b25074827db34cbbc6adc8873932`
    * PrivKey: `7d82c818dcc23f9312527b36c4959e5976f5df7a3dec7e1bbb24a45d64d131c1`
    * NEP-2 encrypted: `6PYNfKunYGT5sMMqmpkQLB3KRrgvdE2vTEhpXsjQBLFh9cTbRkWkTkz9Q1`
    * WIF: `L1RgqMJEBjdXcuYCMYB6m7viQ9zjkNPjZPAKhhBoXxEsygNXENBb`
  * JSON-RPC: `localhost:20332`

* **Wallet passphrase**: `neo`

* **List of native contract's addresses/hashes**:
  * ContractManagement: `0xfffdc93764dbaddd97c48f252a53ea4643faa3fd`
  * StdLib:             `0xacce6fd80d44e1796aa0c2c625e9e4e0ce39efc0`
  * CryptoLib:          `0x726cb6e0cd8628a1350a611384688911ab75f51b`
  * LedgerContract:     `0xda65b600f7124ce6c79950c1772a36403104f2be`
  * NeoToken:           `0xef4073a0f2b305a38ec4050e4d3d28bc40ea63f5`
  * GasToken:           `0xd2a4cff31913016155e38e474a2c06d08be276cf`
  * PolicyContract:     `0xcc5e4edd9f5f8dba8bb65734541df7a1c081c67b`
  * RoleManagement:     `0x49cf4e5378ffcd4dec034fd98a174c5491e395e2`
  * OracleContract:     `0xfe924b7cfe89ddd271abaf7210a80a7e11178758`
  * NameService:        `0x7a8fcf0392cd625647907afa8e45cc66872b596b`

* **Address Info**:
  * All the addresses have the `AddressVersion` set to `0x35` (which is the [default used in the neo-project](https://github.com/neo-project/neo/blob/402e9b19d80bb9093601f5ac57ff0cdc3c6cf6ab/src/neo/ProtocolSettings.cs#L50))

## :soon: Upcoming Features

- [ ] Pre-fund wallets of `neo-client1` and `neo-client2` with plenty of NEO and GAS
- [ ] Automatically deploy smart contracts specified in a given local directory

If you would like to see anything else, give us a shout and [open an issue](https://github.com/AxLabs/neo3-privatenet-docker/issues).

## :pray: Thanks

* We have to thank [hal0x2328](https://github.com/hal0x2328) for publishing [hal0x2328/neo3-privatenet-tutorial](https://github.com/hal0x2328/neo3-privatenet-tutorial) and inspire us to make things even simpler. :smiley: :wink:
* Thanks for [Tommo-L](https://github.com/Tommo-L) by providing the amazing [Tommo-L/NEO3-Development-Guide](https://github.com/Tommo-L/NEO3-Development-Guide) -- certainly, this development guide is complementary to the [AxLabs/neo3-privatenet-docker](https://github.com/AxLabs/neo3-privatenet-docker) repository.
