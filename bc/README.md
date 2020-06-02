# 说明

bc是blockchain的简称，为cashbox钱包提供链相关功能实现，通过编译成动态库与客户端程序进行交互。目前实现的功能包含钱包管理，Ethereum,Scryx（基于[Substrate](https://github.com/paritytech/substrate)实现的链）交易生成，签名等钱包最基础的核心功能。（目前bitcoin相关内容还未整合进来）

## 开发环境搭建

### rust编译

bc功能是使用`rust`实现，程序编译需要依赖rust的编译环境。关于rust编译环境的搭建，可以[点击这里](https://www.rust-lang.org/tools/install),官方提供了各种安装方式的安装教程。

### 动态库编译

使用rust提供的工具能够快速的搭建交叉编译环境，为不同的硬件平台提供满足要求的动态库。当前bc中只提供了针对`Android`平台的接口封装，编译Android的目标库需要搭建NDK开发环境，使用版本为 [NDK21](https://developer.android.com/ndk/downloads?hl=zh-cn)。根据操作系统类型选择对应的版本下载对应的版本即可；
关于搭建使用Rust来搭建Android、IOS交叉编译环境，[参考这里](https://dev.to/robertohuertasm/rust-once-and-share-it-with-android-ios-and-flutter-286o)。

不同的系统的编译方式，更详细的可以查看[device_app_lib](./device_app_lib/readme.md)中的帮助文档。

## 代码组织结构

当前代码由`device_app_lib`、`util`、`wallet`这三部分代码组成，下面是对这三部分代码功能实现说明：

- `device_app_lib`:用于针对最终适配平台功能的封装，提供给Android平台通过native 函数调用，当前只有JNI类型接口的适配；
- `util`:实现了wallet中操作需要的一些通用但是跟钱包业务关系不是很紧密的功能，可以独立于钱包的存在，比如 ethereum、substrate的地址生成、交易签名,数据的编解码；数据的加解密、密钥协商；
- `wallet`:实现了钱包的管理功能，比如助记词的管理、代币的管理；通过`device_app_lib`中暴露出去的方法与用户交互，实现了用户数据的存储；

**说明**：由于util中存在对Scryx部分代码的依赖，但是Scryx项目源码还未对外开源，因此目前在util中是依赖本地文件。为了能够在编译时正常编译，需要将[eee](https://github.com/scryinfo/eee),[cashbox](https://github.com/scryinfo/cashbox)代码放置在相同的文件目录下;