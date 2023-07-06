# Project Structure Description

bc is the abbreviation of blockchain, which provides chain-related functions for the cashbox wallet, and compiles into a
dynamic library to interact with the client program. The currently implemented functions include wallet management,
Ethereum, Scryx (based on [Substrate](https://github.com/paritytech/substrate) implementation chain) transaction generation,
signature and other basic core wallet functions. (At present, bitcoin related content has not been integrated)

## Code Organization

The current code structure mainly contains the following parts:

- `chain`: It mainly provides functions such as transaction signature, address generation, transaction record decode and
  other functions for the wallet supported chain . such as `Bitcion`,`Ethereum`,`Based Substate chain` etc;
- `mav`: Currently, the `rbatis` library is used to achieve data access. For the convenience of operation, the data model
  layer that interacts with the database is defined in this position;
- `wallets`: This part of the code implement wallet management functions, such as mnemonic management, token management;
  interact with users through the methods exposed in `wallets_cdl`, and realize the storage of user data;
- `util`:implements some common functions, such as Encryption and decryption, key agreement;
- `wallets_cdl`:used to encapsulate the function of the final adaptation platform, provided to the Android platform through
  native function calls;
- `wallets_macro`:Define various macros in the entire dynamic library to simplify the writing of code; for example, in the
  use of C interface parameters, it is necessary to convert the data structure defined by C and the Rust data type, and the
  substructures used extensively in the definition of the data model layer structure;
- `wallet_types`: Used to define the data types converted to and from `wallets_cdl`;

## Development Environment

### Rust Environment

Program compilation depends on the rust compilation environment. For the construction of the rust compilation environment,
you can [click here](https://www.rust-lang.org/tools/install), the official provides installation tutorials for various
installation methods. It is recommended to use the script one-click installation. To ensure a quick installation, **you need
to enable the agent on the command line**.

### Library Compile Environment

Use the tools provided by rust to quickly build a cross-compilation environment and provide dynamic libraries that meet the
requirements for different hardware platforms.

- Make sure that the Android NDK is installed
    - You might also need LLVM from the SDK manager,The version used
      is [NDK21](https://developer.android.com/ndk/downloads?hl=zh-cn). Select the corresponding version according to the
      operating system type and download the corresponding version;
- Ensure that the env variable `$ANDROID_NDK` points to the NDK base folder
    - It may look like `/Users/brickpop/Library/Android/sdk/ndk-bundle` on MacOS
    - And look like `/home/brickpop/dev/android/ndk-bundle` on Linux
- Add Support target

```sh
  rustup target add aarch64-apple-ios x86_64-apple-ios

  rustup target add aarch64-linux-android armv7-linux-androideabi i686-linux-android x86_64-linux-android

  rustup target add x86_64-pc-windows-gnu
  rustup target add x86_64-unknown-linux-gnu

```

## Dart file generation tool

When `flutter` calls the C interface provided by the dynamic library through the `FFI` method, it needs to use the
corresponding Dart file that defines the interface in Rust.

- cargo install --force cbindgen //[See](https://github.com/eqrion/cbindgen/)
- cargo install --force dart-bindgen --features cli //[See](https://github.com/sunshine-protocol/dart-bindgen)
- on windows platform
    - install [llvm](https://releases.llvm.org/)
    - Set environment variables ： LIBCLANG_PATH = D:\lang\LLVM\bin

## Compile the library

- According to the target platform to be compiled, select the corresponding compilation script in
  the `./wallets_cdl/script/`.The final generated dynamic library is located in the target directory.

- execute script `gen.bat` or `gen.sh` which in the directory`./wallets_cdl/script`, the `.h`,`.dart`file will be generated
  and copied to the correct location.
