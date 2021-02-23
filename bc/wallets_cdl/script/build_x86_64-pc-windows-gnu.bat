Setlocal
set HOST_TAG=x86_64-pc-windows-gnu
set VCPKGRS_DYNAMIC=1
set cuPath=%cd%
set batPath=%~dp0
%~d0
cd %batPath%/../../../packages/wallets
set outPath=%cd%

set BUILD_DUMMY_WASM_BINARY=1

#rustup target add wasm32-unknown-unknown --toolchain nightly-2020-10-05-x86_64-pc-windows-gnu

#rustup default 1.48.0-x86_64-pc-windows-gnu
cd %batPath%/..
cargo build --target %HOST_TAG%

cd %batPath%../../target/%HOST_TAG%/debug
copy /Y "wallets_cdl.dll" "%outPath%/"

cd %cuPath%
EndLocal
