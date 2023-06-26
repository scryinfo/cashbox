#!/bin/sh

cbindgen --config cbindgen.toml --crate cdl --output src/cdl_c.h

cd ../flutter_app

#set PUB_HOSTED_URL=https://pub.flutter-io.cn
#set FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
flutter pub get
flutter pub run ffigen

cd ../cdl

