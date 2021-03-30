#！/bin/bash

cuPath=$(pwd)
batPath=$(dirname $(readlink -f "$0"))

rustup default stable-gnu
cd $batPath/..
cargo build --release --target  x86_64-unknown-linux-gnu
cd $cuPath
