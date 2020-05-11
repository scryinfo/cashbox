/* DO NOT EDIT THIS FILE - it is machine generated */
#include <jni.h>
/* Header for class info_scry_wallet_manager_NativeLib */

#ifndef _Included_info_scry_wallet_manager_NativeLib
#define _Included_info_scry_wallet_manager_NativeLib
#ifdef __cplusplus
extern "C" {
#endif
/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    mnemonicGenerate
 * Signature: (I)Linfo/scry/wallet_manager/NativeLib/Mnemonic;
 */
JNIEXPORT jobject JNICALL Java_info_scry_wallet_1manager_NativeLib_mnemonicGenerate
  (JNIEnv *, jclass, jint);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    mnemonicProveOwn
 * Signature: (Ljava/lang/String;)Linfo/scry/wallet_manager/NativeLib/MnemonicProveOwn;
 */
JNIEXPORT jobject JNICALL Java_info_scry_wallet_1manager_NativeLib_mnemonicProveOwn
  (JNIEnv *, jclass, jstring);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    mnemonicSign
 * Signature: (Ljava/lang/String;Ljava/lang/String;I[B)Linfo/scry/wallet_manager/NativeLib/Message;
 */
JNIEXPORT jobject JNICALL Java_info_scry_wallet_1manager_NativeLib_mnemonicSign
  (JNIEnv *, jclass, jstring, jstring, jint, jbyteArray);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    isContainWallet
 * Signature: ()Linfo/scry/wallet_manager/NativeLib/WalletState;
 */
JNIEXPORT jobject JNICALL Java_info_scry_wallet_1manager_NativeLib_isContainWallet
  (JNIEnv *, jclass);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    loadAllWalletList
 * Signature: ()Ljava/util/List;
 */
JNIEXPORT jobject JNICALL Java_info_scry_wallet_1manager_NativeLib_loadAllWalletList
  (JNIEnv *, jclass);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    saveWallet
 * Signature: (Ljava/lang/String;[B[BI)Linfo/scry/wallet_manager/NativeLib/Wallet;
 */
JNIEXPORT jobject JNICALL Java_info_scry_wallet_1manager_NativeLib_saveWallet
  (JNIEnv *, jclass, jstring, jbyteArray, jbyteArray, jint);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    exportWallet
 * Signature: (Ljava/lang/String;[B)Linfo/scry/wallet_manager/NativeLib/Mnemonic;
 */
JNIEXPORT jobject JNICALL Java_info_scry_wallet_1manager_NativeLib_exportWallet
  (JNIEnv *, jclass, jstring, jbyteArray);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    getNowWallet
 * Signature: ()Linfo/scry/wallet_manager/NativeLib/WalletState;
 */
JNIEXPORT jobject JNICALL Java_info_scry_wallet_1manager_NativeLib_getNowWallet
  (JNIEnv *, jclass);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    setNowWallet
 * Signature: (Ljava/lang/String;)Linfo/scry/wallet_manager/NativeLib/WalletState;
 */
JNIEXPORT jobject JNICALL Java_info_scry_wallet_1manager_NativeLib_setNowWallet
  (JNIEnv *, jclass, jstring);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    deleteWallet
 * Signature: (Ljava/lang/String;[B)Linfo/scry/wallet_manager/NativeLib/WalletState;
 */
JNIEXPORT jobject JNICALL Java_info_scry_wallet_1manager_NativeLib_deleteWallet
  (JNIEnv *, jclass, jstring, jbyteArray);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    resetPwd
 * Signature: (Ljava/lang/String;[B[B)Linfo/scry/wallet_manager/NativeLib/WalletState;
 */
JNIEXPORT jobject JNICALL Java_info_scry_wallet_1manager_NativeLib_resetPwd
  (JNIEnv *, jclass, jstring, jbyteArray, jbyteArray);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    rename
 * Signature: (Ljava/lang/String;Ljava/lang/String;)Linfo/scry/wallet_manager/NativeLib/WalletState;
 */
JNIEXPORT jobject JNICALL Java_info_scry_wallet_1manager_NativeLib_rename
  (JNIEnv *, jclass, jstring, jstring);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    showChain
 * Signature: (Ljava/lang/String;I)Linfo/scry/wallet_manager/NativeLib/WalletState;
 */
JNIEXPORT jobject JNICALL Java_info_scry_wallet_1manager_NativeLib_showChain
  (JNIEnv *, jclass, jstring, jint);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    hideChain
 * Signature: (Ljava/lang/String;I)Linfo/scry/wallet_manager/NativeLib/WalletState;
 */
JNIEXPORT jobject JNICALL Java_info_scry_wallet_1manager_NativeLib_hideChain
  (JNIEnv *, jclass, jstring, jint);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    getNowChainType
 * Signature: (Ljava/lang/String;)Linfo/scry/wallet_manager/NativeLib/WalletState;
 */
JNIEXPORT jobject JNICALL Java_info_scry_wallet_1manager_NativeLib_getNowChainType
  (JNIEnv *, jclass, jstring);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    setNowChainType
 * Signature: (Ljava/lang/String;I)Linfo/scry/wallet_manager/NativeLib/WalletState;
 */
JNIEXPORT jobject JNICALL Java_info_scry_wallet_1manager_NativeLib_setNowChainType
  (JNIEnv *, jclass, jstring, jint);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    showDigit
 * Signature: (Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Linfo/scry/wallet_manager/NativeLib/WalletState;
 */
JNIEXPORT jobject JNICALL Java_info_scry_wallet_1manager_NativeLib_showDigit
  (JNIEnv *, jclass, jstring, jstring, jstring);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    hideDigit
 * Signature: (Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Linfo/scry/wallet_manager/NativeLib/WalletState;
 */
JNIEXPORT jobject JNICALL Java_info_scry_wallet_1manager_NativeLib_hideDigit
  (JNIEnv *, jclass, jstring, jstring, jstring);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    addDigit
 * Signature: (Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)Linfo/scry/wallet_manager/NativeLib/WalletState;
 */
JNIEXPORT jobject JNICALL Java_info_scry_wallet_1manager_NativeLib_addDigit
  (JNIEnv *, jclass, jstring, jstring, jstring, jstring, jstring, jint);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    eeeOpen
 * Signature: (Ljava/lang/String;Ljava/lang/String;)Linfo/scry/wallet_manager/NativeLib/Handle;
 */
JNIEXPORT jobject JNICALL Java_info_scry_wallet_1manager_NativeLib_eeeOpen
  (JNIEnv *, jclass, jstring, jstring);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    eeeClose
 * Signature: (J)I
 */
JNIEXPORT jint JNICALL Java_info_scry_wallet_1manager_NativeLib_eeeClose
  (JNIEnv *, jclass, jlong);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    eeeTransfer
 * Signature: (JLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Linfo/scry/wallet_manager/NativeLib/Message;
 */
JNIEXPORT jobject JNICALL Java_info_scry_wallet_1manager_NativeLib_eeeTransfer
  (JNIEnv *, jclass, jlong, jstring, jstring, jstring, jstring);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    eeeEnergyTransfer
 * Signature: (Ljava/lang/String;[BLjava/lang/String;Ljava/lang/String;Ljava/lang/String;)Linfo/scry/wallet_manager/NativeLib/Message;
 */
JNIEXPORT jobject JNICALL Java_info_scry_wallet_1manager_NativeLib_eeeEnergyTransfer
  (JNIEnv *, jclass, jstring, jbyteArray, jstring, jstring, jstring);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    eeeTxSign
 * Signature: (Ljava/lang/String;Ljava/lang/String;[B)Linfo/scry/wallet_manager/NativeLib/Message;
 */
JNIEXPORT jobject JNICALL Java_info_scry_wallet_1manager_NativeLib_eeeTxSign
  (JNIEnv *, jclass, jstring, jstring, jbyteArray);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    eeeSign
 * Signature: (Ljava/lang/String;Ljava/lang/String;[B)Linfo/scry/wallet_manager/NativeLib/Message;
 */
JNIEXPORT jobject JNICALL Java_info_scry_wallet_1manager_NativeLib_eeeSign
  (JNIEnv *, jclass, jstring, jstring, jbyteArray);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    eeeTxBroadcast
 * Signature: (JLjava/lang/String;)Linfo/scry/wallet_manager/NativeLib/Message;
 */
JNIEXPORT jobject JNICALL Java_info_scry_wallet_1manager_NativeLib_eeeTxBroadcast
  (JNIEnv *, jclass, jlong, jstring);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    eeeBalance
 * Signature: (JLjava/lang/String;)Linfo/scry/wallet_manager/NativeLib/Message;
 */
JNIEXPORT jobject JNICALL Java_info_scry_wallet_1manager_NativeLib_eeeBalance
  (JNIEnv *, jclass, jlong, jstring);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    eeeEnergyBalance
 * Signature: (JLjava/lang/String;)Linfo/scry/wallet_manager/NativeLib/Message;
 */
JNIEXPORT jobject JNICALL Java_info_scry_wallet_1manager_NativeLib_eeeEnergyBalance
  (JNIEnv *, jclass, jlong, jstring);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    eeeGetTxNonce
 * Signature: ()Ljava/lang/String;
 */
JNIEXPORT jstring JNICALL Java_info_scry_wallet_1manager_NativeLib_eeeGetTxNonce
  (JNIEnv *, jclass);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    ethTxSign
 * Signature: (Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[BLjava/lang/String;Ljava/lang/String;Ljava/lang/String;I)Linfo/scry/wallet_manager/NativeLib/Message;
 */
JNIEXPORT jobject JNICALL Java_info_scry_wallet_1manager_NativeLib_ethTxSign
  (JNIEnv *, jclass, jstring, jint, jstring, jstring, jstring, jstring, jstring, jbyteArray, jstring, jstring, jstring, jint);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    ethTxMakeETHRawTx
 * Signature: ([B[BLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)[B
 */
JNIEXPORT jbyteArray JNICALL Java_info_scry_wallet_1manager_NativeLib_ethTxMakeETHRawTx
  (JNIEnv *, jclass, jbyteArray, jbyteArray, jstring, jstring, jstring, jstring, jstring, jstring);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    ethTxMakeERC20RawTx
 * Signature: ([B[BLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)[B
 */
JNIEXPORT jbyteArray JNICALL Java_info_scry_wallet_1manager_NativeLib_ethTxMakeERC20RawTx
  (JNIEnv *, jclass, jbyteArray, jbyteArray, jstring, jstring, jstring, jstring, jstring, jstring, jstring);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    btcTxMakeBTCRawTx
 * Signature: ([Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)[B
 */
JNIEXPORT jbyteArray JNICALL Java_info_scry_wallet_1manager_NativeLib_btcTxMakeBTCRawTx
  (JNIEnv *, jclass, jobjectArray, jobjectArray, jstring);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    btcTxSignTx
 * Signature: (Ljava/lang/String;[B[B)[B
 */
JNIEXPORT jbyteArray JNICALL Java_info_scry_wallet_1manager_NativeLib_btcTxSignTx
  (JNIEnv *, jclass, jstring, jbyteArray, jbyteArray);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    ethTxBroascastTx
 * Signature: ([B)Z
 */
JNIEXPORT jboolean JNICALL Java_info_scry_wallet_1manager_NativeLib_ethTxBroascastTx
  (JNIEnv *, jclass, jbyteArray);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    btcTxBroascastTx
 * Signature: ([B)Z
 */
JNIEXPORT jboolean JNICALL Java_info_scry_wallet_1manager_NativeLib_btcTxBroascastTx
  (JNIEnv *, jclass, jbyteArray);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    updateDigitBalance
 * Signature: (Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Linfo/scry/wallet_manager/NativeLib/Message;
 */
JNIEXPORT jobject JNICALL Java_info_scry_wallet_1manager_NativeLib_updateDigitBalance
  (JNIEnv *, jclass, jstring, jstring, jstring);

/*
 * Class:     info_scry_wallet_manager_NativeLib
 * Method:    decodeAdditionData
 * Signature: (Ljava/lang/String;)Linfo/scry/wallet_manager/NativeLib/Message;
 */
JNIEXPORT jobject JNICALL Java_info_scry_wallet_1manager_NativeLib_decodeAdditionData
  (JNIEnv *, jclass, jstring);

#ifdef __cplusplus
}
#endif
#endif
