# ffigen in window
1. add llvm in path: sample "set path=%path%;D:\Program Files\LLVM\bin"
2. flutter pub run ffigen:setup -I"d:/Program Files/LLVM/include" -L"d:/Program Files/LLVM/lib"
3. flutter pub run ffigen

#bindgen in window ( rust )
1. cargo install bindgen
2. bindgen generate_ffi/wallets_c.h -o generate_ffi/wallets_c.rs

# ffi_test.dart 运行说明 (window)
1. 运行 demo/ffi/cdl/script/build_x86_64-pc-windows-gnu.bat
2. 把 demo/ffi/cdl/target/x86_64-pc-windows-gnu/debug/cdl.dll 文件复制到 demo/ffi/flutter_app下面
3. 运行ffi_test单元测试