Setlocal
set HOST_TAG=i686-linux-android
set NDK=%ANDROID_NDK%
set cuPath=%cd%
set batPath=%~dp0

cd %batPath%/../../../app/dl
set outPath=%cd%

set BUILD_DUMMY_WASM_BINARY=1

set TOOLCHAIN=%NDK%/toolchains/llvm/prebuilt/windows-x86_64
set AR=%TOOLCHAIN%/bin/%HOST_TAG%-ar.exe
set LINKER=%TOOLCHAIN%/bin/%HOST_TAG%28-clang.cmd
# HOST_TAG 中的"-"要改为下划线
set CARGO_TARGET_I686_LINUX_ANDROID_LINKER=%LINKER%
set CC=%TOOLCHAIN%/bin/%HOST_TAG%28-clang.cmd
set CXX=%TOOLCHAIN%/bin/%HOST_TAG%28-clang++.cmd

rustup default stable-gnu
cd %batPath%/..
cargo build --target %HOST_TAG%  --release

cd %batPath%../../target/aarch64-linux-android/release
copy /Y "libwallets_cdl.so" "%outPath%/x86"

cd %cuPath%
EndLocal
