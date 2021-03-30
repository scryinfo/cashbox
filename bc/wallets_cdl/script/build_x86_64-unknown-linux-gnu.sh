#！/bin/bash

HOST_TAG=x86_64-unknown-linux-gnu
cuPath=$(pwd)
batPath=$(dirname $(readlink -f "$0"))
cd $batPath/../../../packages/wallets
outPath=$(pwd)

cd $batPath/..
cargo build --release --target $HOST_TAG

cd %batPath%../../target/$HOST_TAG/debug
cp "wallets_cdl.so" "%outPath%/"

cd $cuPath
