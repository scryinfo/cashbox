#！/bin/bash
cuPath=$(pwd)
batPath=$(dirname $(readlink -f "$0"))
TOOLCHAIN=$ANDROID_NDK/toolchains/llvm/prebuilt/linux-x86_64
export BUILD_DUMMY_WASM_BINARY=1
export AR=$TOOLCHAIN/bin/aarch64-linux-android-ar
export CC=$TOOLCHAIN/bin/aarch64-linux-android28-clang
export LINKER=$TOOLCHAIN/bin/%HOST_TAG%28-clang.cmd
export CARGO_TARGET_AARCH64_LINUX_ANDROID_LINKER=$LINKER
cd $batPath/..
cargo build --release --target  aarch64-linux-android
cd $cuPath
