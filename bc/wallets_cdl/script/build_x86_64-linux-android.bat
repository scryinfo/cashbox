Setlocal
set HOST_TAG=x86_64-linux-android
set NDK=%ANDROID_NDK%
set cuPath=%cd%
set batPath=%~dp0

set BUILD_DUMMY_WASM_BINARY=1

set TOOLCHAIN=%NDK%/toolchains/llvm/prebuilt/windows-x86_64
set AR=%TOOLCHAIN%/bin/%HOST_TAG%-ar.exe
set LINKER=%TOOLCHAIN%/bin/%HOST_TAG%28-clang.cmd
set CARGO_TARGET_X86_64_LINUX_ANDROID_LINKER=%LINKER%
set CC=%TOOLCHAIN%/bin/%HOST_TAG%28-clang.cmd
set CXX=%TOOLCHAIN%/bin/%HOST_TAG%28-clang++.cmd
rustup default stable-gnu
cd %batPath%/..
cargo build --target %HOST_TAG%  --release
cd %cuPath%
EndLocal
