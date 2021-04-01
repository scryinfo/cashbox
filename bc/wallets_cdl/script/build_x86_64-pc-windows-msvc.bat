Setlocal
set HOST_TAG=x86_64-pc-windows-msvc
set cuPath=%cd%
set batPath=%~dp0
%~d0
cd "%batPath%/../../../packages/wallets"
set outPath=%cd%
cd "%batPath%/.."
cargo build --target %HOST_TAG%

cd "%batPath%../../target/%HOST_TAG%/debug"
copy /Y "wallets_cdl.dll" "%outPath%/"

EndLocal
