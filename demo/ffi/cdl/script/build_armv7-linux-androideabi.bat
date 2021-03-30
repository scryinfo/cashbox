Setlocal
set HOST_TAG=armv7-linux-androideabi
set HOST_TAG_NDK=armv7a-linux-androideabi
set NDK=%ANDROID_NDK%
set cuPath=%cd
set batPath=%~dp0

set TOOLCHAIN=%NDK%/toolchains/llvm/prebuilt/windows-x86_64
set AR=%TOOLCHAIN%/bin/arm-linux-androideabi-ar.exe
set LINKER=%TOOLCHAIN%/bin/%HOST_TAG_NDK%28-clang.cmd
set CARGO_TARGET_ARMV7_LINUX_ANDROIDEABI_LINKER=%LINKER%
set CC=%TOOLCHAIN%/bin/%HOST_TAG_NDK%28-clang.cmd
set CXX=%TOOLCHAIN%/bin/%HOST_TAG_NDK%28-clang++.cmd

rustup default stable-gnu
%~d0
cd "%batPath%/.."
cargo build --target %HOST_TAG%
EndLocal
