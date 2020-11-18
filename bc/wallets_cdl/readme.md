# 生成一个文件说明（改为使用cbindgen）
bindgen在生成时，会把头文件包含的内容一起生成，每个文件生成一次，会产生大量重复的定义，所以最后选择生成一个文件
注：如果使用前置声明也不行，它会把前置声明的struct生成struct

# 使用rust生成c,dart定义
1. cargo install --force cbindgen  //[See](https://github.com/eqrion/cbindgen/)
2. cargo install --force dart-bindgen --features cli  //[See](https://github.com/sunshine-protocol/dart-bindgen)
    *. window
        1. install [llvm](https://releases.llvm.org/)
        2. 设置环境变量： LIBCLANG_PATH = D:\lang\LLVM\bin
3. cbindgen 