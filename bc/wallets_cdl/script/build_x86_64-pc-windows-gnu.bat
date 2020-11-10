set HOST_TAG=x86_64-pc-windows-gnu
set VCPKGRS_DYNAMIC=1
set cuPath=%cd
set batPath=%~dp0

set BUILD_DUMMY_WASM_BINARY=1

rustup default stable-gnu
cd %batPath%/..
cargo build --target %HOST_TAG% --release
cd %batPath%

