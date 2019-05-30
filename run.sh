#!/bin/bash

BINARY=geth-alltools-linux-amd64-1.8.27-4bcc0a37.tar.gz
wget "https://gethstore.blob.core.windows.net/builds/$BINARY"
tar -xzvf $BINARY --strip 1
rm $BINARY

echo $password > ~/.accountpassword
echo $privatekey > ~/.privatekey

if test -f "/genesis/genesis.json"; then
  cp /genesis/genesis.json ./genesis.json
fi

exec geth init genesis.json
exec geth account import --password ~/.accountpassword  ~/.privatekey
exec geth --bootnodes "enode://$bootnodeId@$bootnodeIp:30301" --networkid="6969" --verbosity=4 --gasprice '0' --rpc --rpcaddr "0.0.0.0" --rpccorsdomain "*" --mine --etherbase $address --unlock $address --password ~/.accountpassword
