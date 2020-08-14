set HOST_TAG=x86_64-pc-windows-msvc
set VCPKGRS_DYNAMIC=1
set cuPath=%cd
set batPath=%~dp0

#set RUSTFLAGS=-Ctarget-feature=+crt-static
#set VCPKG_ROOT=D:/tools/vcpkg
rustup default stable-msvc
cd %batPath%/..
cargo build --target %HOST_TAG% --release
cd %batPath%

