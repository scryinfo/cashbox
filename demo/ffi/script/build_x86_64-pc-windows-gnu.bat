Setlocal
set HOST_TAG=x86_64-pc-windows-gnu
set VCPKGRS_DYNAMIC=1
set cuPath=%cd
set batPath=%~dp0

set BUILD_DUMMY_WASM_BINARY=1

rustup default stable-gnu
%~d0
cd "%batPath%/.."
cargo build --target %HOST_TAG%
cd "%batPath%"
EndLocal
