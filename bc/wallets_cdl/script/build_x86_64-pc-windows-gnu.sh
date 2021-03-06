#！/bin/bash

HOST_TAG=x86_64-pc-windows-gnu
cuPath=$(pwd)
batPath=$(dirname $(readlink -f "$0"))

cd $batPath/../../../packages/wallets
outPath=$(pwd)

cd $batPath/..
cargo build --target $HOST_TAG

cd $batPath/../../target/$HOST_TAG/debug
cp "wallets_cdl.dll" "$outPath/"

cd $cuPath
