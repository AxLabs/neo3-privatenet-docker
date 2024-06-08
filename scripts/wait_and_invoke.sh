#!/bin/sh

set -e
echo "Starting script..."

echo "Checking if neo-node is up..."
until nc -z neo-consensus 40332; do
  echo "Waiting for neo-node..."
  sleep 5
done
echo "Neo-node is up!"

echo "Creating wallet.config file..."
echo "{
  \"Path\": \"/wallet.json\",
  \"Password\": \"${WALLET_PASSWORD}\"
}" > /wallet.config

echo "Starting block height check..."
TEMPFILE=$(mktemp)
trap "rm -f $TEMPFILE" EXIT
while true; do
  echo "Checking block height..."
  sleep 5
  curl -s -X POST http://neo-consensus:40332 \
    -H "Content-Type: application/json" \
    -d '{"jsonrpc":"2.0","method":"getblockcount","params":[],"id":1}' > $TEMPFILE
  RESPONSE=$(cat $TEMPFILE)
  echo "Curl response: $RESPONSE"
  if [ -z "$RESPONSE" ]; then
    echo "Error: No response from curl"
    continue
  fi
  HEIGHT=$(cat $TEMPFILE | jq ".result | tonumber" 2>/dev/null)
  echo "Parsed height: $HEIGHT"
  if [ -z "$HEIGHT" ] || [ "$HEIGHT" = "null" ]; then
    HEIGHT=0
  fi
  echo "Current block height: $HEIGHT"
  if [ "$HEIGHT" -ge 1 ]; then
    echo "Block height is $HEIGHT. Proceeding..."
    break
  fi
done

echo "Invoking 'RoleManagement' contract, method 'designateAsRole'..."

neo-go contract invokefunction --await --force -r http://neo-consensus:40332 \
  --wallet-config /wallet.config \
  --address NXXazKH39yNFWWZF5MJ8tEN98VYHwzn7g3 \
  49cf4e5378ffcd4dec034fd98a174c5491e395e2 \
  designateAsRole int:8 \
  [ key:02607a38b8010a8f401c25dd01df1b74af1827dd16b821fc07451f2ef7f02da60f \
  key:037279f3a507817251534181116cb38ef30468b25074827db34cbbc6adc8873932 ] \
  -- NXXazKH39yNFWWZF5MJ8tEN98VYHwzn7g3:Global

echo "Funding address NM7Aky765FG8NhhwtxjXRx7jEL1cnw7PBP (neo-consensus, normal wallet) with 10000000 GAS and 10000000 NEO..."
echo "Funding address NV1Q1dTdvzPbThPbSFz7zudTmsmgnCwX6c (neo-client1) with 10000000 GAS and 10000000 NEO..."
echo "Funding address NhJX9eCbkKtgDrh1S4xMTRaHUGbZ5Be7uU (neo-client2) with 10000000 GAS and 10000000 NEO..."

neo-go wallet nep17 multitransfer --await --force -r http://neo-consensus:40332 \
  --wallet-config /wallet.config \
  --from NXXazKH39yNFWWZF5MJ8tEN98VYHwzn7g3 \
  GAS:NM7Aky765FG8NhhwtxjXRx7jEL1cnw7PBP:10000000 \
  NEO:NM7Aky765FG8NhhwtxjXRx7jEL1cnw7PBP:10000000 \
  NEO:NXXazKH39yNFWWZF5MJ8tEN98VYHwzn7g3:0 \
  GAS:NV1Q1dTdvzPbThPbSFz7zudTmsmgnCwX6c:10000000 \
  NEO:NV1Q1dTdvzPbThPbSFz7zudTmsmgnCwX6c:10000000 \
  GAS:NhJX9eCbkKtgDrh1S4xMTRaHUGbZ5Be7uU:10000000 \
  NEO:NhJX9eCbkKtgDrh1S4xMTRaHUGbZ5Be7uU:10000000 \
  -- NXXazKH39yNFWWZF5MJ8tEN98VYHwzn7g3:Global