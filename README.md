# neo3-privatenet-docker

![License](https://img.shields.io/github/license/AxLabs/neo3-privatenet-docker)
![GitHub stars](https://img.shields.io/github/stars/AxLabs/neo3-privatenet-docker?style=social)

<p></p>

<p align="center">
  :fire::zap::fire::zap::fire:
  <b>Run Neo3 nodes for development in record time!</b>
  :fire::zap::fire::zap::fire:
</p>

<p></p>

This is the **ultimate** GitHub repository to run your**Neo3 blockchain** nodes and start developing.

* :green_heart: This repository relies on [git sub-modules](https://git-scm.com/book/en/v2/Git-Tools-Submodules) pointing to the official [neo-node](https://github.com/neo-project/neo-modules/) and [neo-modules](https://github.com/neo-project/neo-node/). Then, you can adjust the reference if you want to rely on the latest or an specific commit! :wink:
* :rocket: The neo-cli image is built from the official `Dockerfile` from [neo-node](https://github.com/neo-project/neo-node/).
* :star: Includes **all** available plugins from [neo-modules](https://github.com/neo-project/neo-modules/)
* :boom: *It just fucking works.*

Ah, we love GitHub stars to keep our motivation up to the roof! :star: :wink:

## :rotating_light: Dependencies
 - [docker](https://docs.docker.com/install/): [MacOS](https://docs.docker.com/docker-for-mac/install/) or [Windows](https://docs.docker.com/docker-for-windows/install/)
 - [docker-compose](https://docs.docker.com/compose/install/)

## :running: How to Run

```
git clone https://github.com/AxLabs/neo3-privatenet-docker.git
cd neo3-privatenet-docker
git submodule update
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
curl http://127.0.0.1:40332 -d '{"jsonrpc":"2.0","method":"openwallet","params":["wallet.json","one"],"id":1}'
```

* List the addresses in `neo-consensus` wallet:

```
curl http://127.0.0.1:40332 -d '{"jsonrpc":"2.0","method":"listaddress","params":[],"id":1}'
```

* Get the NEO balance of all addresses in `neo-consensus` wallet:

```
curl http://127.0.0.1:40332 -d '{"jsonrpc":"2.0","method":"getbalance","params":["0x9bde8f209c88dd0e7ca3bf0af0f476cdd8207789"],"id":1}'
```

* Get all NEP-5 balance of `neo-consensus`' address `AHE5cLhX5NjGB5R2PcdUvGudUoGUBDeHX4`, specifically:

```
curl http://127.0.0.1:40332 -d '{"jsonrpc":"2.0","method":"getnep5balances","params":["AHE5cLhX5NjGB5R2PcdUvGudUoGUBDeHX4"],"id":1}'
```

* Send 100 NEO from `neo-consensus`' address `AHE5cLhX5NjGB5R2PcdUvGudUoGUBDeHX4` to `neo-client1`'s address `AcozGpiGDpp9Vt9RMyokWNyu7hh341T2bb`:

```
curl http://127.0.0.1:40332 -d '{"jsonrpc":"2.0","method":"sendfrom","params":["0x9bde8f209c88dd0e7ca3bf0af0f476cdd8207789","AHE5cLhX5NjGB5R2PcdUvGudUoGUBDeHX4","AcozGpiGDpp9Vt9RMyokWNyu7hh341T2bb",100],"id":1}'
```

## :bulb: Info

The `docker-compose` file has 3 nodes:

* **Consensus**
  * Multisig address (1/1): `AHE5cLhX5NjGB5R2PcdUvGudUoGUBDeHX4`
  * Address: `AK5AmzrrM3sw3kbCHXpHNeuK3kkjnneUrb`
  * PubKey: `03f1ec3c1e283e880de6e9c489f0f27c19007c53385aaa4c0c917c320079edadf2`
  * WIF: `6PYLVq2QgQqEdzP6cZRLSQyTbDzw1BqF2qCsE9duWEWj7bgmmPVAG9QQBn`
  * JSON-RPC: `localhost:40332`
* **Client1**
  * Address: `AcozGpiGDpp9Vt9RMyokWNyu7hh341T2bb`
  * PubKey: `0267f519c2fe06b4034b3611973ab8bd5f061c45fcc684768239358930e1d1b157`
  * WIF: `6PYRVgZXqyLuf35mbBbhMQYxismi1YXfCrxAUsaFckNgrc93REzEiWez2R`
  * JSON-RPC: `localhost:10332`
* **Client2**
  * Address: `AQwwB4Y6yvRhkuQ3ejHk8WRjKGGvkfoz8U`
  * PubKey: `020af46dc2fda6ac77cabf1e8004c84f42f16f31bcf715cfe6ad1c896b48d33ff5`
  * WIF: `6PYK2m7buefqZZK6GXHaEuKcWuNAD4vcUydYJ9vXhTpKYSp8JyQggxnL8b`
  * JSON-RPC: `localhost:20332`

* **Wallet passphrase**: `one`

* **Asset addresses/hashes**:
  * NEO: `0x9bde8f209c88dd0e7ca3bf0af0f476cdd8207789`
  * GAS: `0x8c23f196d8a1bfd103a9dcb1f9ccf0c611377d3b`

## :soon: Upcoming Features

* Pre-fund wallets of `neo-client1` and `neo-client2` with plenty of NEO and GAS
* Automatically deploy smart contracts specified in a given local directory
* Option to start more consensus nodes, if desired
* Wrapper API to specifically start, stop, and fetch specific info from nodes

If you would like to see anything else, give us a shout and [open an issue](https://github.com/AxLabs/neo3-privatenet-docker/issues).

## :pray: Thanks

* We have to thank [hal0x2328](https://github.com/hal0x2328) for publishing [hal0x2328/neo3-privatenet-tutorial](https://github.com/hal0x2328/neo3-privatenet-tutorial) and inspire us to make things even simpler. :smiley: :wink:
* Thanks for [Tommo-L](https://github.com/Tommo-L) by providing teh amazing [Tommo-L/NEO3-Development-Guide](https://github.com/Tommo-L/NEO3-Development-Guide) -- certainly, this development guide is a completent to the [AxLabs/neo3-privatenet-docker](https://github.com/AxLabs/neo3-privatenet-docker) repository.

