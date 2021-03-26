Setlocal
set cuPath=%cd%
set batPath=%~dp0
%~d0
cd "%batPath%/.."

cbindgen --config cbindgen.toml --crate wallets_cdl --output src/wallets_c.h

cd ../../packages/wallets/
set PUB_HOSTED_URL=https://pub.flutter-io.cn
set FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

flutter pub get
flutter pub run ffigen
flutter pub run build_runner build
cd "%cuPath%"
EndLocal
