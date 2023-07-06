# 生成文件说明（改用cbindgen）

bindgen在生成时，会把头文件包含的内容一起生成，每个文件生成一次，会产生大量重复的定义，所以最后选择生成一个文件

**注**：如果使用前置声明也不行，它会把前置声明的struct生成struct

# 使用rust生成c,dart定义

1. cargo install --force cbindgen //[See](https://github.com/eqrion/cbindgen/)
2. cargo install --force dart-bindgen --features cli //[See](https://github.com/sunshine-protocol/dart-bindgen)
   *. window
    - install [llvm](https://releases.llvm.org/)
    - 设置环境变量： LIBCLANG_PATH = D:\lang\LLVM\bin
3. 在packages/wallets下面运行 flutter pub run build_runner build，生成c to dart代码

注：运行脚本 bc/wallets_cdl/script/gen.bat 可以生成.h及.dart文件，并放入正确的位置

注：c struct中不能使用如下单词定义字段
free alloc allocate fromC from toC toDart
