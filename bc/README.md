# 项目结构说明

bc是blockchain的简称，为cashbox钱包提供链相关功能实现，通过编译成动态库与客户端程序进行交互。目前实现的功能包含钱包管理，Ethereum,Scryx（基于[Substrate](https://github.com/paritytech/substrate)实现的链）交易生成，签名等钱包最基础的核心功能。（目前bitcoin相关内容还未整合进来）

## 开发环境搭建

### rust编译环境

bc功能是使用`rust`实现，程序编译需要依赖rust的编译环境。关于rust编译环境的搭建，可以[点击这里](https://www.rust-lang.org/tools/install),官方提供了各种安装方式的安装教程。建议使用脚本一键安装，为确保能够快速安装成功，**需要将命令行开启代理**。
[这里有一个关于rust简短的介绍](./rust_brief_introduction.md)

### 动态库编译环境

使用rust提供的工具能够快速的搭建交叉编译环境，为不同的硬件平台提供满足要求的动态库。当前bc中只提供了针对`Android`平台的接口封装，编译Android的目标库需要搭建NDK开发环境，使用版本为 [NDK21](https://developer.android.com/ndk/downloads?hl=zh-cn)。根据操作系统类型选择对应的版本下载对应的版本即可；
关于搭建使用Rust来搭建Android、IOS交叉编译环境，[参考这里](https://dev.to/robertohuertasm/rust-once-and-share-it-with-android-ios-and-flutter-286o)。

不同的系统的编译方式，更详细的可以查看[device_app_lib](./device_app_lib/readme.md)中的帮助文档。

## 代码组织结构
当前代码由`device_app_lib`、`util`、`wallets`这三部分代码组成，下面是对这三部分代码功能实现说明：

- `device_app_lib`:用于针对最终适配平台功能的封装，提供给Android平台通过native 函数调用，当前只有JNI类型接口的适配；
- `util`:实现了wallet中操作需要的一些通用但是跟钱包业务关系不是很紧密的功能，可以独立于钱包的存在，比如 ethereum、substrate的地址生成、交易签名,数据的编解码；数据的加解密、密钥协商；
- `wallets`:实现了钱包的管理功能，比如助记词的管理、代币的管理；通过`device_app_lib`中暴露出去的方法与用户交互，实现了用户数据的存储；

**说明**：由于util中存在对Scryx部分代码的依赖，但是Scryx项目源码还未对外开源，因此目前在util中是依赖本地文件。为了能够在编译时正常编译，需要将[eee](https://github.com/scryinfo/eee),[cashbox](https://github.com/scryinfo/cashbox)代码放置在相同的文件目录下;

### wallets 
cashbox钱包的核心功能都在[wallets](./wallets)实现，为快速理解项目的代码编码过程，下面具体介绍该文件价当初的设计思想；

在wallets的根目录下我们可以看到wallets所有的依赖文件`Cargo.toml`,通过依赖文件能够知道该项目中引用哪些crate以及对应的版本;

在src目录中可以看到有`modle`,`module`,`wallet_db`三个类型的文件夹以及使用相同名字命名的文件，他们之间的关系可以查看[Rust模块管理的内容](https://doc.rust-lang.org/book/ch07-03-paths-for-referring-to-an-item-in-the-module-tree.html),他们分别实现如下功能：
- modle 定义了我们钱包的组成关系，一个钱包下存在不同类型的链（当前设计的是三种类型 Bitcoin、Ethereum、Scryx），每种类型的链允许有多种类型的代币；通过`wallet.rs`的结构可以看出,该结构是用于给客户端返回钱包数据使用； `wallet_store.rs`是与数据库表对应的结构；
- module 用于定义当前钱包支持的功能，这些功能与Andorid端定义的[NativeLib.java](https://github.com/scryinfo/cashbox/blob/master/packages/wallet_manager/android/src/main/java/info/scry/wallet_manager/NativeLib.java)中包含的功能相对应。在具体的实现上按照功能属于的类别进行编码，属于钱包级别的功能在`wallet.rs`中实现，跟链相关的就在`chain.rs`实现，与代币相关的功能就在`digit.rs`中实现
- wallet_db 这部分主要用于跟数据库进行交互，module中的功能涉及到数据库相关的操作，通过调用wallet_db相关实现即可；该模块的组成也是按照钱包、链、代币这个粒度来实现具体功能；由于涉及到数据库的操作需要有建表、数据初始化等所需要的资源文件放置在res中；
- 在src中还包含一个关于错误处理的文件`error.rs`，用于接收在功能实现过程中可能会出现的错误，实现将程序运行过程中产生的错误，传递到应用端。

### util

由于cashbox需要对外提供交易签名、钱包助记词管理功能，涉及到的算法签名、加解密、交易生成的具体实现过程放置在util中来实现，包含如下内容：
- ethtx 实现Eth转账、ERC20交易交易构造，附加数据的解码功能；
- substratetx 实现scryx（基于substrate）的地址生成、交易签名，通知事件、账户信息、区块数据解码功能；
- crypto 是一个关于对AES对称加密功能的封装，用于钱包助记词的加密；

### device_app_lib
这个目录的作用主要起桥接作用，连接java与rust实现的功能。代码结构按照钱包、链、代币方式来组织。由于要满足在Android端上通过JNI方式调用，需要按照JNI格式来读取、构造参数。这部分涉及到交叉编译，更多详情查看[帮助文档](https://github.com/scryinfo/cashbox/tree/master/bc/device_app_lib)。

## 调试
为提高开发效率，测试编写的功能是否符合满足跨平台接口调用定义，在test路径下创建了满足x86平台调用的项目，使用方式[查看文档](https://github.com/scryinfo/cashbox/tree/master/test)

**注意**：由于使用数据库来维护钱包中的数据关系，这里引入了[Sqlite](https://www.sqlite.org/index.html)这种文件类型数据库，使用的依赖版本选择为[sqlite](https://docs.rs/sqlite/0.25.3/sqlite/index.html),虽然在后期使用过程中感觉不够精简(还需要做进一步的封装)，但是当时选用这个crate的原因如下:

由于我们最后会将代码编译成so供终端设备调用，当前有部分sqlite的封装库需要依赖设备的`libsqlite.so`，使用后调试的过程中发现出现`libsqlite.so`找不到的问题。是因为在Android设备上应用想使用Andorid系统提供的Sqlite数据库功能，要么调用Andorid系统提供的Api，要么你这个应用在系统白名单内。针对我们这款应用来说都不能满足这些条件，在测试了几个crate后发现在使用[sqlite](https://docs.rs/sqlite/0.25.3/sqlite/index.html)只包含`libc`的依赖，运行在所有的平台都没有问题。
