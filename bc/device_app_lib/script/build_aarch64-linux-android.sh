#！/bin/bash
cuPath=$(pwd)
batPath=$(dirname $(readlink -f "$0"))
export BUILD_DUMMY_WASM_BINARY=1
export AR=$ANDROID_NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android-ar
export CC=$ANDROID_NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android28-clang
cd $batPath/..
cargo build --release --target  aarch64-linux-android
cd $cuPath
