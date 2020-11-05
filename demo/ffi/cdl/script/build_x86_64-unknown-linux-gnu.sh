#！/bin/bash

cuPath=$(pwd)
batPath=$(dirname $(readlink -f "$0"))

export BUILD_DUMMY_WASM_BINARY=1

rustup default stable-gnu
cd $batPath/..
cargo build --release --target  x86_64-unknown-linux-gnu
cd $cuPath
