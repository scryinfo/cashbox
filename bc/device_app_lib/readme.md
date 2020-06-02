
# build

## 在windows中编译
- `Android`平台的动态库的编译，编译过程都需要依赖[NDK](https://developer.android.com/ndk)提供的适配库支持，
为后续编译脚本能够正常使用需要提前设置 `ANDROID_NDK`环境变量，这里我们使用的是[NDK21](https://dl.google.com/android/repository/android-ndk-r21-windows-x86_64.zip)
添加rust target:`rustup target add aarch64-linux-android armv7-linux-androideabi`
- `IOS`平台的编译，内容待完善；
由于在windows中可以使用 `x86_64-pc-windows-gnu`、`x86_64-pc-windows-msvc`两种编译链，对应的操作有些区别； 
### 使用 x86_64-pc-windows-gnu 编译工具链
若是使用`x86_64-pc-windows-gnu`，需要进行如下操作
- rustup toolchain install x86_64-pc-windows-gnu
- rustup default gnu
- 根据android目标平台架构，运行`script`目录下 `build_aarch64-linux-android.bat` 或 `build_armv7-linux-androideabi.bat`
### 使用x86_64-pc-windows-msvc 编译工具链
- `rustup toolchain install x86_64-pc-windows-msvc`
- `rustup default msvc`
- 首先安装vcpkg包(下面是安装后要做的)，
- `vcpkg integrate install`
- `vcpkg install sqlite3:x64-windows-static`
- `vcpkg install sqlite3:x64-windows`
- 根据android目标平台架构，运行`script`目录下 `build_aarch64-linux-android.bat` 或 `build_armv7-linux-androideabi.bat`

**注意**：安装`sqlite3`是因为项目里面使用了sqlite数据库
## 在Linux中编译
- 确保已经设置`ANDROID_NDK`环境变量，
- rustup toolchain install x86_64-unknown-linux-gnu
- rustup target add aarch64-linux-android armv7-linux-androideabi
- 根据android目标平台架构，运行`script`目录下 `build_aarch64-linux-android.sh` 或 `build_armv7-linux-androideabi.sh`

**说明**：当前钱包版本Android适配目标平台`targetSdkVersion 28`
