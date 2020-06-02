
set HOST_TAG=aarch64-linux-android
set NDK=%ANDROID_NDK%
set cuPath=%cd
set batPath=%~dp0

set TOOLCHAIN=%NDK%/toolchains/llvm/prebuilt/windows-x86_64
set AR=%TOOLCHAIN%/bin/%HOST_TAG%-ar.exe
set CC=%TOOLCHAIN%/bin/%HOST_TAG%28-clang.cmd
set CXX=%TOOLCHAIN%/bin/%HOST_TAG%-clang++.cmd
rustup default stable-gnu
cd %batPath%/..
cargo build --target %HOST_TAG%
cd %cuPath%

