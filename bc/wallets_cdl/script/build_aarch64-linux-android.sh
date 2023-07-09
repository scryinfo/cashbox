#！/bin/bash

HOST_TAG=aarch64-linux-android
cuPath=$(pwd)
batPath=$(dirname $(readlink -f "$0"))

cd $batPath/../../../app/
mkdir -p dl/arm64-v8a
cd dl/arm64-v8a
outPath=$(pwd)

TOOLCHAIN=$ANDROID_NDK/toolchains/llvm/prebuilt/linux-x86_64
export AR=$TOOLCHAIN/bin/llvm-ar
export CC=$TOOLCHAIN/bin/${HOST_TAG}33-clang
export CXX=$TOOLCHAIN/bin/${HOST_TAG}33-clang++
export LINKER=$TOOLCHAIN/bin/${HOST_TAG}33-clang
export CARGO_TARGET_AARCH64_LINUX_ANDROID_LINKER=$LINKER

#rustup default stable-gnu
cd $batPath/..
cargo build --release --target $HOST_TAG

cd $batPath/../../target/$HOST_TAG/release
cp "libwallets_cdl.so" "$outPath/"

cd $cuPath
