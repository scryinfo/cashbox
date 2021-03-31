Setlocal
set HOST_TAG=x86_64-pc-windows-gnu
set CC_%HOST_TAG%=gcc
::把“-”替换为"_"
set HOST_TAG_=%HOST_TAG:-=_%
set CARGO_TARGET_%HOST_TAG_%_LINKER=%RUSTUP_HOME%/toolchains/stable-x86_64-pc-windows-gnu/lib/rustlib/x86_64-pc-windows-gnu/bin/self-contained/x86_64-w64-mingw32-gcc.exe
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
