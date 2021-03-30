Setlocal
set HOST_TAG=x86_64-pc-windows-gnu
set VCPKGRS_DYNAMIC=1
set cuPath=%cd
set batPath=%~dp0

rustup default stable-gnu
%~d0
cd "%batPath%/.."
cargo build --target %HOST_TAG%
EndLocal
