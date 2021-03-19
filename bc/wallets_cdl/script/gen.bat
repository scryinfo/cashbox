Setlocal
set cuPath=%cd%
set batPath=%~dp0
%~d0
cd "%batPath%/.."

cbindgen --config cbindgen.toml --crate wallets_cdl --output src/wallets_c.h

dart-bindgen -i src/wallets_c.h -o ../../packages/wallets/lib/wallets_c.dart --name wallets_cdl --android libwallets_cdl.so --linux libwallets_cdl.so --windows wallets_cdl.dll

::modify the file, because the dart-bindgen is not support ffi 1.0.0
cd ../../packages/wallets/lib
@echo off
chcp 65001
set search=ffi.allocate
set replace=ffi.calloc
setlocal enabledelayedexpansion
(
::"eol== delims="
::"delims="""
::"tokens=*"
    for /f "delims="""  %%i in (wallets_c.dart) do (
        set "line=%%i"
        set "line=!line:%search%=%replace%!"
        if "%%i" NEQ "  " (
            echo !line!
        )
    )
) > temp_.dart
EndLocal
@echo on
move temp_.dart wallets_c.dart
cd ../
::flutter pub get
flutter pub run build_runner build
cd "%cuPath%"
EndLocal
