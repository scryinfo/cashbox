Setlocal
set cuPath=%cd%
set batPath=%~dp0
%~d0
cd "%batPath%"

cbindgen --config cbindgen.toml --crate cdl --output src/wallets_c.h

dart-bindgen -i src/wallets_c.h -o ../flutter_app/generate_ffi/wallets_c.dart --name cdl --android libcdl.so --linux libcdl.so --windows cdl.dll

::modify the file, because the dart-bindgen is not support ffi 1.0.0
cd ../flutter_app/generate_ffi
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
move temp_.dart wallets_c.dart

cd "%cuPath%"
EndLocal
