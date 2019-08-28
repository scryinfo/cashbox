#！/bin/bash
cuPath=$(pwd)
batPath=$(dirname $(readlink -f "$0"))
export AR=$ANDROID_NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android-ar
export CC=$ANDROID_NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android23-clang
cd $batPath/..
cargo build --target aarch64-linux-android
cd $cuPath