Setlocal
set cuPath=%cd%
set batPath=%~dp0
%~d0
cd "%batPath%"

cbindgen --config cbindgen.toml --crate cdl --output src/cdl_c.h

cd ../flutter_app

set PUB_HOSTED_URL=https://pub.flutter-io.cn
set FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
call flutter.bat pub get
call flutter.bat pub run ffigen

EndLocal
