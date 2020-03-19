#！/bin/bash
cuPath=$(pwd)
batPath=$(dirname $(readlink -f "$0"))
export AR=$ANDROID_NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin/arm-linux-androideabi-ar
export CC=$ANDROID_NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/armv7a-linux-androideabi24-clang
cd $batPath/..
cargo build --release --target armv7-linux-androideabi
cd $cuPath
