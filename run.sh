#!/bin/bash

wget "$gethBaseUrl/$binary"
tar -xzvf $binary --strip 1
rm $binary

if test -f "/genesis/genesis.json"; then
  cp /genesis/genesis.json ./genesis.json
fi

chmod +x ./geth
./geth init genesis.json --datadir "/data"
exec ./geth --datadir "/data" --bootnodes "enode://$bootnodeId@$bootnodeIp:$bootnodeport" --networkid=$networkid --verbosity=4 --gasprice $gasprice --rpc --rpcaddr "0.0.0.0" --rpccorsdomain "*" --rpcapi=$rpcapi --syncmode $syncmode --gcmode $gcmode --rpcvhosts=*
