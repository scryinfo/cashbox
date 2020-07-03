# project instruction
This project is an open source wallet Cashbox, mainly to realize the development of mobile platform (android, ios) functions.

## Technical selection instructions
In the selection of the Cashbox wallet technology, the upper ui part is implemented with flutter, and the bottom layer uses rust language to compile a dynamic library to implement wallet management, encryption and other functions.

### Environment and configuration
#### Pre-configuration information (features are optional, and configurations can be added, deleted, or modified according to the needs of developers. The function implementation is mainly related to VendorConfig)
- In the global_config directory, create a vendor_config.dart file. In the whole project, search for the place where VendorConfig is used, and replace it with the developer's own function ip as needed.
- Apply for test coins, and register [etherscan](https://etherscan.io/) to develop APIs. Configure your apikey in etherscan_util file
- Change the interface to get the price of the corresponding fiat currency. The location is app/lib/net/rate_util.dart.
- Add some required default configuration information, such as the backend ip of the price corresponding to the fiat currency, other public interface ip, etc. Location: app/lib/util/sharedpreference_util.dart

#### Environment installation
- Install development tools [AndroidStudio](https://developer.android.com/studio/index.html)
- Install [flutter SDK](https://flutterchina.club/get-started/install/)
- Compile the dynamic library, specifically in [bc](https://github.com/scryinfo/cashbox/blob/master/bc/README.md) (written by rust language), there are detailed descriptions of the dynamic library generation process under the directory .

### Project running
   - Take android as an example: the compiled dynamic library. Put it in the corresponding directory packages/wallet_manager/android/src/main/jniLibs/arm64-v8a.
   - Name the developer's own applicationId, the corresponding location is: applicationId parameter value in app/android/app/build.gradle.
   - Go to the app directory and execute flutter pub get to synchronize the dependent toolkits.
   - After the computer is connected to the android device, execute flutter run to run the development version of the android application.
   - flutter run --release Run the release version of the application (specific parameters can be changed according to development needs)
   - flutter run --dev
   - flutter build

## Cashbox project structure description:
### There are three main directories:
- 1.app --- Use flutter to develop the main function code of the wallet.
- 2.bc --- Provide dynamic library generation. Can provide encryption, decryption, private key generation, storage and other low-level independent security related functions.
- 3.packages --- functional plug-in, help to expand the functions of the app, such as providing wallet management function, webview function.

Specific functional modules, you can enter the corresponding module to view the documentation
- [app part description ENGLISH](https://github.com/scryinfo/cashbox/blob/master/app/README_EN.md)
- [section description of bc](https://github.com/scryinfo/cashbox/blob/master/bc/README.md)
