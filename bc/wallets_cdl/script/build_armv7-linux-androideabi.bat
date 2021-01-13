Setlocal

set HOST_TAG=armv7-linux-androideabi
set HOST_TAG_NDK=armv7a-linux-androideabi
set NDK=%ANDROID_NDK%
set cuPath=%cd%
set batPath=%~dp0

cd %batPath%/../../../app/
mkdir dl/armeabi-v7a
cd dl/armeabi-v7a
set outPath=%cd%

set TOOLCHAIN=%NDK%/toolchains/llvm/prebuilt/windows-x86_64
set BUILD_DUMMY_WASM_BINARY=1
set AR=%TOOLCHAIN%/bin/arm-linux-androideabi-ar.exe
set CC=%TOOLCHAIN%/bin/%HOST_TAG_NDK%28-clang.cmd
set CXX=%TOOLCHAIN%/bin/%HOST_TAG_NDK%28-clang++.cmd
set LINKER=%TOOLCHAIN%/bin/%HOST_TAG_NDK%28-clang.cmd
set CARGO_TARGET_ARMV7_LINUX_ANDROIDEABI_LINKER=%LINKER%

#rustup default stable-gnu
cd %batPath%/..
cargo build --release --target %HOST_TAG%

cd $batPath/../../target/%HOST_TAG%/release
copy /Y "libwallets_cdl.so" "%outPath%/"

cd %cuPath%

EndLocal
