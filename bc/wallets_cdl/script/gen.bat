Setlocal
set cuPath=%cd%
set batPath=%~dp0

cd %batPath%/..

cbindgen --config cbindgen.toml --crate wallets_cdl --output src/wallets_c.h

dart-bindgen -i src/wallets_c.h -o ../../packages/wallets/lib/wallets_c.dart --name wallets_cdl --android libwallets_cdl.so --linux libwallets_cdl.so --windows wallets_cdl.dll

cd %cuPath%
EndLocal
