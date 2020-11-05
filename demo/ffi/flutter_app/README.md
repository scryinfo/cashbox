# ffigen in window
1. add llvm in path: sample "set path=%path%;D:\Program Files\LLVM\bin"
2. flutter pub run ffigen:setup -I"d:/Program Files/LLVM/include" -L"d:/Program Files/LLVM/lib"
3. flutter pub run ffigen

#bindgen in window ( rust )
1. cargo install bindgen
2. bindgen generate_ffi/wallets_c.h -o generate_ffi/wallets_c.rs