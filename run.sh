#!/bin/bash

wget "$gethBaseUrl/$binary"
tar -xzvf $binary --strip 1
rm $binary

echo $password > ~/.accountpassword
echo $privatekey > ~/.privatekey

if test -f "/genesis/genesis.json"; then
  cp /genesis/genesis.json ./genesis.json
fi

echo "executing ls"
ls
echo "executing pwd"
pwd

chmod +x ./geth
./geth init genesis.json
echo "test"
./geth account import --password ~/.accountpassword  ~/.privatekey
exec ./geth --bootnodes "enode://$bootnodeId@$bootnodeIp:30301" --networkid="6969" --verbosity=4 --gasprice '0' --rpc --rpcaddr "0.0.0.0" --rpccorsdomain "*" --mine --etherbase $address --unlock $address --password ~/.accountpassword
