# Build

## Compile in windows

- The compilation of the dynamic library on the `Android` platform, the compilation process needs to rely on the support of the adaptation library provided by [NDK](https://developer.android.com/ndk),
In order to use the subsequent compilation scripts normally, you need to set the `ANDROID_NDK` environment variable in advance. Here we use [NDK21](https://dl.google.com/android/repository/android-ndk-r21-windows-x86_64.zip )
Add rust target: `rustup target add aarch64-linux-android armv7-linux-androideabi`
- `IOS` platform compile, content to be improved;

Since `x86_64-pc-windows-gnu` and `x86_64-pc-windows-msvc` can be used in Windows, the corresponding operations are somewhat different;

### x86_64-pc-windows-gnu compile toolchain

If you use `x86_64-pc-windows-gnu`, you need to do the following

- rustup toolchain install x86_64-pc-windows-gnu
- rustup default gnu
- According to the Android target platform architecture, run `build_aarch64-linux-android.bat` or `build_armv7-linux-androideabi.bat` in the `script` directory

### x86_64-pc-windows-msvc to compile the toolchain

- `rustup toolchain install x86_64-pc-windows-msvc`
- `rustup default msvc`
- First install the vcpkg package (the following is what to do after installation),
- `vcpkg integrate install`
- `vcpkg install sqlite3:x64-windows-static`
- `vcpkg install sqlite3:x64-windows`
- According to the Android target platform architecture, run `build_aarch64-linux-android.bat` or `build_armv7-linux-androideabi.bat` in the `script` directory

**Note**: The installation of `sqlite3` is because the sqlite database is used in the project

## Compile in Linux

- Make sure that the `ANDROID_NDK` environment variable has been set,
- rustup toolchain install x86_64-unknown-linux-gnu
- rustup target add aarch64-linux-android armv7-linux-androideabi
- Configure linker and ar paths in `~/.cargo/config`, and configure them separately for the platform to be compiled. For example, the configuration file corresponding to the `aarch64-linux-android` platform needs to be compiled as

```
[target.aarch64-linux-android]
linker="/home/jeremy/work/sw/android-ndk-r21b/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android28-clang"
ar="/home/jeremy/work/sw/android-ndk-r21b/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android-ar"
```

- Run `build_aarch64-linux-android.sh` or `build_armv7-linux-androideabi.sh` under `script` directory according to the Android target platform architecture

**Description**: The current wallet version Android adapts to the target platform `targetSdkVersion 28`
