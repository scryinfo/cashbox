#！/bin/bash
cuPath=$(pwd)
batPath=$(dirname $(readlink -f "$0"))
export BUILD_DUMMY_WASM_BINARY=1

export AR=$ANDROID_NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android-ar

export CC=$ANDROID_NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android28-clang

export LINKER=$ANDROID_NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android28-clang

# HOST_TAG 中的"-"要改为下划线
export CARGO_TARGET_AARCH64_LINUX_ANDROID_LINKER=$LINKER

cd $batPath/..

cargo build --target  aarch64-linux-android --release

cd $cuPath
