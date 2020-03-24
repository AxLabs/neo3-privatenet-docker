# neo3-privatenet-docker

:fire::fire::fire:
**Run Neo3 nodes for development in record time!**
:fire::fire::fire:

This is the **ultimate** GitHub repository to run your Neo3 blockchain node and start developing.

* :green_heart: This repository relies on [git sub-modules](https://git-scm.com/book/en/v2/Git-Tools-Submodules) pointing to the official [neo-node](https://github.com/neo-project/neo-modules/) and [neo-modules](https://github.com/neo-project/neo-node/). Then, you can adjust the reference if you want to rely on the latest or an specific commit! :wink:
* :rocket: The neo-cli image is built from the official `Dockerfile` from [neo-node](https://github.com/neo-project/neo-node/).
* :star: Includes **all** available plugins from [neo-modules](https://github.com/neo-project/neo-modules/)
* :boom: *It just fucking works.*

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

And test if `neo-client1` is receiving some blocks:

```
curl http://127.0.0.1:10332 -d '{"jsonrpc":"2.0","method":"getblockcount","params":[],"id":1}'
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

* Wallet passphrase: `one`

## :pray: Thanks

We have to thank [hal0x2328](https://github.com/hal0x2328) for publishing [hal0x2328/neo3-privatenet-tutorial](https://github.com/hal0x2328/neo3-privatenet-tutorial) and inspire us to make things even simpler. :smiley: :wink: