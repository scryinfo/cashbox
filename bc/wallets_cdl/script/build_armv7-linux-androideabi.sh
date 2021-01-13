#！/bin/bash

HOST_TAG=armv7-linux-androideabi
HOST_TAG_NDK=armv7a-linux-androideabi
cuPath=$(pwd)
batPath=$(dirname $(readlink -f "$0"))

cd $batPath/../../../app/
mkdir dl/armeabi-v7a
cd dl/armeabi-v7a
outPath=$(pwd)

TOOLCHAIN=$ANDROID_NDK/toolchains/llvm/prebuilt/linux-x86_64
export BUILD_DUMMY_WASM_BINARY=1
export AR=$TOOLCHAIN/bin/arm-linux-androideabi-ar
export CC=$TOOLCHAIN/bin/${HOST_TAG_NDK}28-clang
export CXX=$TOOLCHAIN/bin/${HOST_TAG}28-clang++
export LINKER=$TOOLCHAIN/bin/${HOST_TAG_NDK}28-clang
export CARGO_TARGET_ARMV7_LINUX_ANDROIDEABI_LINKER=$LINKER

#rustup default stable-gnu
cd $batPath/..
cargo build --release --target $HOST_TAG

cd $batPath/../../target/$HOST_TAG/release
cp "libwallets_cdl.so" "$outPath/"

cd $cuPath
