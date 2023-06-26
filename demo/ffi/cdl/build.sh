#!/bin/sh

cargo build
cp "../target/debug/libcdl.so" "../flutter_app" -f

