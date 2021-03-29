Setlocal
set cuPath=%cd%
set batPath=%~dp0
%~d0
cd "%batPath%/.."
cbindgen --config cbindgen.toml --crate wallets_cdl --output src/wallets_c.h
cd ../../packages/wallets/

set PUB_HOSTED_URL=https://pub.flutter-io.cn
set FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
call flutter.bat pub get
call flutter.bat pub run ffigen
call flutter.bat pub run build_runner build
EndLocal