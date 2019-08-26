set HOST_TAG=x86_64-pc-windows-msvc
set VCPKGRS_DYNAMIC=1
#set RUSTFLAGS=-Ctarget-feature=+crt-static
#set VCPKG_ROOT=D:/tools/vcpkg
rustup default stable-msvc
cargo build --target %HOST_TAG%

