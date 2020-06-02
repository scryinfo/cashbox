
set HOST_TAG=armv7-linux-androideabi
set NDK=%ANDROID_NDK%
set cuPath=%cd
set batPath=%~dp0

set TOOLCHAIN=%NDK%/toolchains/llvm/prebuilt/windows-x86_64
set AR=%TOOLCHAIN%/bin/arm-linux-androideabi-ar.exe
set CC=%TOOLCHAIN%/bin/armv7a-linux-androideabi28-clang.cmd
set CXX=%TOOLCHAIN%/bin/armv7a-linux-androideabi24-clang++.cmd
rustup default stable-gnu
cd %batPath%/..
cargo build --target %HOST_TAG%
cd %cuPath%
