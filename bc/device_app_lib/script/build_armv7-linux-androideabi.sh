#！/bin/bash
cuPath=$(pwd)
batPath=$(dirname $(readlink -f "$0"))
export BUILD_DUMMY_WASM_BINARY=1

export AR=$ANDROID_NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin/arm-linux-androideabi-ar
export CC=$ANDROID_NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/armv7a-linux-androideabi28-clang
cd $batPath/..
cargo build --release --target armv7-linux-androideabi
cd $cuPath
