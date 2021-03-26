#！/bin/bash

cuPath=$(pwd)
batPath=$(dirname $(readlink -f "$0"))

cd $batPath/..
cbindgen --config cbindgen.toml --crate wallets_cdl --output src/wallets_c.h

cd ../../packages/wallets
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

flutter pub get
flutter pub run ffigen
flutter pub run build_runner build

cd $cuPath