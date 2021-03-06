Setlocal
set HOST_TAG=aarch64-linux-android
set NDK=%ANDROID_NDK%
set cuPath=%cd
set batPath=%~dp0
set TOOLCHAIN=%NDK%/toolchains/llvm/prebuilt/windows-x86_64
set AR=%TOOLCHAIN%/bin/%HOST_TAG%-ar.exe
set LINKER=%TOOLCHAIN%/bin/%HOST_TAG%28-clang.cmd
set CARGO_TARGET_AARCH64_LINUX_ANDROID_LINKER=%LINKER%
set CC=%TOOLCHAIN%/bin/%HOST_TAG%28-clang.cmd
set CXX=%TOOLCHAIN%/bin/%HOST_TAG%28-clang++.cmd
rustup default stable-gnu
%~d0
cd "%batPath%/.."
cargo build --target %HOST_TAG% --release
EndLocal

