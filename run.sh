#!/bin/bash

wget "$gethBaseUrl/$binary"
tar -xzvf $binary --strip 1
rm $binary

echo $password > ~/.accountpassword
echo $privatekey > ~/.privatekey

if test -f "/genesis/genesis.json"; then
  cp /genesis/genesis.json ./genesis.json
fi

chmod +x ./geth
./geth init genesis.json --datadir "/data"
./geth account import --password ~/.accountpassword --datadir "/data" ~/.privatekey
exec ./geth --datadir "/data" --bootnodes "enode://$bootnodeId@$bootnodeIp:$bootnodeport" --networkid=$networkid --verbosity=4 --gasprice $gasprice --rpc --rpcaddr "0.0.0.0" --rpccorsdomain "*" --etherbase $address --unlock $address --password ~/.accountpassword --rpcapi=$rpcapi --syncmode $syncmode --gcmode $gcmode --allow-insecure-unlock
