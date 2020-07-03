# Project Structure Description

bc is the abbreviation of blockchain, which provides chain-related functions for the cashbox wallet, and compiles into a dynamic library to interact with the client program. The currently implemented functions include wallet management, Ethereum, Scryx (based on [Substrate] (https://github.com/paritytech/substrate) implementation chain) transaction generation, signature and other basic core wallet functions. (At present, bitcoin related content has not been integrated)

## Development Environment

### Rust Compile Environment

The bc function is implemented using `rust`. Program compilation depends on the rust compilation environment. For the construction of the rust compilation environment, you can [click here](https://www.rust-lang.org/tools/install), the official provides installation tutorials for various installation methods. It is recommended to use the script one-click installation. To ensure a quick installation, **you need to enable the agent on the command line**.
[Here is a brief introduction about rust](./rust_brief_introduction.md)

### Dynamic Library Compile Environment

Use the tools provided by rust to quickly build a cross-compilation environment and provide dynamic libraries that meet the requirements for different hardware platforms. Currently, only the interface package for the `Android` platform is provided in bc. Compiling the Android target library requires building an NDK development environment. The version used is [NDK21](https://developer.android.com/ndk/downloads?hl=zh-cn). Select the corresponding version according to the operating system type and download the corresponding version;
For the use of Rust to build Android and IOS cross-compilation environment, [reference here](https://dev.to/robertohuertasm/rust-once-and-share-it-with-android-ios-and-flutter-286o) .

The compilation method of different systems can be viewed in more detail
[device_app_lib](./device_app_lib/readme.md) help documentation.

## Code Organization

The current code consists of three parts of the code of `device_app_lib`, `util`, and `wallets`. The following is a description of the function of these three parts of code:

- `device_app_lib`: used to encapsulate the function of the final adaptation platform, provided to the Android platform through native function calls, currently only JNI type interface adaptation;
- `util`: implements some common functions required by the operation in the wallet but is not very closely related to the wallet business, and can be independent of the existence of the wallet, such as ethereum,substrate address generation, transaction signature, data encoding and decoding; Encryption and decryption, key agreement;
- `wallets`: implement wallet management functions, such as mnemonic management, token management; interact with users through the methods exposed in `device_app_lib`, and realize the storage of user data;

**Explanation**: Since there is a dependency on part of the Scryx code in util, but the source code of the Scryx project has not been open source, so it currently depends on local files in util. In order to be able to compile normally at compile time, you need to put [eee](https://github.com/scryinfo/eee),[cashbox](https://github.com/scryinfo/cashbox) code in the same file directory under;

### wallets

The core functions of the cashbox wallet are all implemented in [wallets] (./wallets). In order to quickly understand the code encoding process of the project, the specific design ideas of the original document price are introduced below;

In the root directory of the wallet, we can see all the dependency files `Cargo.toml` of the wallet. Through the dependency file, we can know which crates and corresponding versions are referenced in the project;

In the src directory, you can see three types of folders: `modle`, `module`, and `wallet_db` and files named with the same name. The relationship between them can be viewed in [Rust module management content](https://doc.rust-lang.org/book/ch07-03-paths-for-referring-to-an-item-in-the-module-tree.html), they respectively implement the following functions:

- modle defines the composition of our wallets. There are different types of chains under one wallet (the current design is three types of Bitcoin, Ethereum, Scryx), each type of chain allows multiple types of tokens; through `wallet The structure of .rs` can be seen that this structure is used to return wallet data to the client; `wallet_store.rs` is the structure corresponding to the database table;
- module is used to define the functions supported by the current wallet. These functions are the same as [NativeLib.java](https://github.com/scryinfo/cashbox/blob/master/packages/wallet_manager/android/src/main/java/info/scry/wallet_manager/NativeLib.java) corresponds to the functions included. The specific implementation is coded according to the category of the function. The wallet-level functions are implemented in `wallet.rs`, the chain-related functions are implemented in `chain.rs`, and the token-related functions are located in `digit implemented in .rs`
- wallet_db This part is mainly used to interact with the database. The functions in the module involve database-related operations, which can be achieved by calling wallet_db; the composition of the module is also based on the granularity of wallet, chain, and token to achieve specific functions; Because the operations involving the database require the resource files needed for table creation and data initialization to be placed in the res;
- The src also contains a file `error.rs` about error handling, which is used to receive errors that may occur during the implementation of the function, and implements errors generated during the running of the program to the application side.

### util

Because cashbox needs to provide transaction signature and wallet mnemonic management functions, the specific implementation processes of algorithm signature, encryption and decryption, and transaction generation involved are placed in util to achieve, including the following content:
-ethtx implements Eth transfer, ERC20 transaction transaction structure, and additional data decoding function;
-substratetx implements scryx (substrate-based) address generation, transaction signature, notification events, account information, and block data decoding functions;
-crypto is an encapsulation of the symmetric encryption function of AES, used for the encryption of wallet mnemonics;

### device_app_lib

The role of this directory is mainly to act as a bridge, connecting the functions implemented by java and rust. The code structure is organized according to wallets, chains, and tokens. Since it is required to be called on the Android side through the JNI method, the parameters need to be read and constructed according to the JNI format. This part involves cross-compilation. For more details, see [Help Document](https://github.com/scryinfo/cashbox/tree/master/bc/device_app_lib).

## Test

In order to improve development efficiency, test whether the functions written meet the definition of cross-platform interface call, and create a project that meets the x86 platform call under the test path, use method [view document](https://github.com/scryinfo/cashbox/tree/master/test)

**Note**: Since the database is used to maintain the data relationship in the wallet, [Sqlite](https://www.sqlite.org/index.html) file type database is introduced here, and the dependent version used is selected as [sqlite](https://docs.rs/sqlite/0.25.3/sqlite/index.html), although it feels not streamlined in the later use process (further packaging needs to be done), but the reason for choosing this crate as follows:

Since we will finally compile the code into `so` file for the terminal device to call, there are currently some sqlite encapsulation libraries that need to rely on the device's `libsqlite.so`. During the debugging process after use, it was found that the `libsqlite.so` could not be found. Because the application on the Android device wants to use the Sqlite database function provided by the Andorid system, either call the API provided by the Andorid system, or your application is in the system whitelist. For our application, these conditions are not met. After testing a few crates, I found that using [sqlite](https://docs.rs/sqlite/0.25.3/sqlite/index.html) only contains ` The dependencies of libc` run on all platforms without problems.
