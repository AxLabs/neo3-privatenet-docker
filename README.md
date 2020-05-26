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
curl http://127.0.0.1:40332 -d '{"jsonrpc":"2.0","method":"getbalance","params":["0x9bde8f209c88dd0e7ca3bf0af0f476cdd8207789"],"id":1}'
```

* Get all NEP-5 balance of `neo-consensus`' address `AFs8hMHrS8emaPP4oyTuf5uKPuAW6HZ2DF`, specifically:

```
curl http://127.0.0.1:40332 -d '{"jsonrpc":"2.0","method":"getnep5balances","params":["AFs8hMHrS8emaPP4oyTuf5uKPuAW6HZ2DF"],"id":1}'
```

* Send 100 NEO from `neo-consensus`' address `AFs8hMHrS8emaPP4oyTuf5uKPuAW6HZ2DF` to `neo-client1`'s address `Aa1rZbE1k8fXTwzaxxsPRtJYPwhDQjWRFZ`:

```
curl http://127.0.0.1:40332 -d '{"jsonrpc":"2.0","method":"sendfrom","params":["0x9bde8f209c88dd0e7ca3bf0af0f476cdd8207789","AFs8hMHrS8emaPP4oyTuf5uKPuAW6HZ2DF","Aa1rZbE1k8fXTwzaxxsPRtJYPwhDQjWRFZ",100],"id":1}'
```

* Open the wallet of the `neo-client1` through JSON-RPC (**only for test purposes!**):

```
curl http://127.0.0.1:10332 -d '{"jsonrpc":"2.0","method":"openwallet","params":["wallet.json","neo"],"id":1}'
```

* Get the NEO balance of `neo-client1` wallet:

```
curl http://127.0.0.1:10332 -d '{"jsonrpc":"2.0","method":"getbalance","params":["0x9bde8f209c88dd0e7ca3bf0af0f476cdd8207789"],"id":1}'
```

## :bulb: Info

The `docker-compose` file has 3 nodes, each with an account. The consensus node uses one public key for two accounts. One is a multisig account and the other a normal account. The multisig account is required as the validator account. Private keys are encrypted according to NEP-2.

* **Consensus**
  * Address: `AVGpjFiocR1BdYhbYWqB6Ls6kcmzx4FWhm`
    * ScriptHash: `969a77db482f74ce27105f760efa139223431394`
    * Script: `0c2102c0b60c995bc092e866f15a37c176bb59b7ebacf069ba94c0ebf561cb8f9562380b418a6b1e75`
    * PubKey: `02c0b60c995bc092e866f15a37c176bb59b7ebacf069ba94c0ebf561cb8f956238`
    * PrivKey: `e6e919577dd7b8e97805151c05ae07ff4f752654d6d8797597aca989c02c4cb3`
    * NEP-2 encrypted: `6PYV39zSDnpCb9ecybeL3z6XrLTpKy1AugUGd6DYFFNELHv9aLj6M7KGD2`
    * WIF: `L4xa4S78qj87q9FRkMQDeZsrymQG6ThR5oczagNNNnBrWRjicF36`
  * MultiSig Address (from the above account): `AFs8hMHrS8emaPP4oyTuf5uKPuAW6HZ2DF`
    * Script: `110c2102c0b60c995bc092e866f15a37c176bb59b7ebacf069ba94c0ebf561cb8f956238110b41c330181e`
    * ScritpHash: `55b842d631f43f23257a27992ac2b53169a4fe00`
  * JSON-RPC: `localhost:40332`
* **Client1**
  * Address: `Aa1rZbE1k8fXTwzaxxsPRtJYPwhDQjWRFZ`
    * Script: `0c2102200284598c6c1117f163dd938a4c8014cf2cf1164c4b7197f347109db50eae7c0b418a6b1e75`
    * ScripthHash: `df133e846b1110843ac357fc8bbf05b4a32e17c8`
    * PubKey: `02200284598c6c1117f163dd938a4c8014cf2cf1164c4b7197f347109db50eae7c`
    * PrivKey: `6PYVydad4kpTjpkUcQXgrqtHnAWxgHYpAHGfCjBreBZkbTBhDXDqv9d8BG`
  * JSON-RPC: `localhost:10332`
* **Client2**
  * Address: `ATpVyfpFwE2SzNGSvXDNrtRyfVLajhn7yN`
    * Script: `0c2102bba9fddcc32f1edc613202bd9fafeaed79122909dfa6161fdd27d0d5a28854c10b418a6b1e75`
    * ScriptHash: `f6da07cd9331429487e9406255d93d9225ab2084`
    * PubKey: `02bba9fddcc32f1edc613202bd9fafeaed79122909dfa6161fdd27d0d5a28854c1`
    * PrivKey: `6PYKRJCApfmkkXd8deyAzWpagBBqT5Wob7mfdXTDVh14FdcJ9qBTaLyQUx`
  * JSON-RPC: `localhost:20332`

* **Wallet passphrase**: `neo`

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
* Thanks for [Tommo-L](https://github.com/Tommo-L) by providing the amazing [Tommo-L/NEO3-Development-Guide](https://github.com/Tommo-L/NEO3-Development-Guide) -- certainly, this development guide is complementary to the [AxLabs/neo3-privatenet-docker](https://github.com/AxLabs/neo3-privatenet-docker) repository.

