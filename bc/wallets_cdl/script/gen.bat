Setlocal
set cuPath=%cd%
set batPath=%~dp0
%~d0
cd %batPath%/..

cbindgen --config cbindgen.toml --crate wallets_cdl --output src/wallets_c.h

dart-bindgen -i src/wallets_c.h -o ../../packages/wallets/lib/wallets_c.dart --name wallets_cdl --android libwallets_cdl.so --linux libwallets_cdl.so --windows wallets_cdl.dll

cd ../../packages/wallets
#flutter pub get
flutter pub run build_runner build

cd %cuPath%
EndLocal
