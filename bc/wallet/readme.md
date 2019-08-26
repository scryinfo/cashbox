
# build
## 在window中编译
    设置环境变最 ANDROID_NDK， 使用的是ndk20
    rustup toolchain install x86_64-pc-windows-gnu
    rustup target add aarch64-linux-android armv7-linux-androideabi
    
### 要交叉编译出android的库，要使用 x86_64-pc-windows-gnu 编译工具链
    rustup default gnu
    运行 build_aarch64-linux-android.bat 或 build_armv7-linux-androideabi.bat
### 如果使用x86_64-pc-windows-msvc 编译window的版本，要安装vcpkg包(下面是安装后要做的)，
    vcpkg integrate install
    vcpkg install sqlite3:x64-windows-static
    vcpkg install sqlite3:x64-windows
## 在Linux中编译
    设置环境变最 ANDROID_NDK， 使用的是ndk20
    rustup toolchain install x86_64-unknown-linux-gnu
    rustup target add aarch64-linux-android armv7-linux-androideabi
    都安装好后，就可以运行对应的sh文件进行编译