library wallets;

import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart' as ffi;
import 'package:wallets/chain_btc.dart';
import 'package:wallets/chain_eee.dart';
import 'package:wallets/chain_eth.dart';
import 'package:wallets/wallets_c.dc.dart';

import 'enums.dart';
import 'kits.dart';
import 'result.dart';
import 'wallets_c.dart' as clib;

class Wallets {
  ///如果失败返回 null，失败的可能性非常小
  static DbName dbName(DbName name) {
    var ptrOutName = clib.CDbName_dAlloc();
    Error err;
    {
      var ptrName = name.toCPtr();
      var cerr = clib.Wallets_dbName(ptrName, ptrOutName);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      DbName.free(ptrName);
    }
    DbName outName;
    if (err.isSuccess()) {
      outName = DbName.fromC(ptrOutName.value);
    }
    clib.CDbName_dFree(ptrOutName);
    return outName;
  }

  Error init(InitParameters parameters) {
    var ptrContext = clib.CContext_dAlloc();
    Error err;
    {
      var ptrParameters = parameters.toCPtr();
      var cerr = clib.Wallets_init(ptrParameters, ptrContext);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      InitParameters.free(ptrParameters);
    }
    if (err.isSuccess()) {
      var ctx = Context.fromC(ptrContext.value);
      context = ctx;
    }
    clib.CContext_dFree(ptrContext);
    return err;
  }

  Error uninit() {
    Error err;
    {
      var cerr = clib.Wallets_uninit(ptrContext);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
    }

    Context.free(ptrContext);
    _ptrContext = nullptr;
    return err;
  }

  DlResult1<List<Context>> contexts() {
    Error err;
    List<Context> contexts = [];
    {
      var ptrContexts = clib.CArrayCContext_dAlloc();
      var cerr = clib.Wallets_Contexts(ptrContexts);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      if (err.isSuccess()) {
        contexts = ArrayCContext.fromC(ptrContexts.value).data;
      }
      clib.CArrayCContext_dFree(ptrContexts);
    }

    return DlResult1(contexts, err);
  }

  DlResult1<Context> lastContext() {
    Error err;
    Context context;
    {
      var ptrContext = clib.CContext_dAlloc();
      var cerr = clib.Wallets_lastContext(ptrContext);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      if (err.isSuccess()) {
        context = Context.fromC(ptrContext.value);
      }
      clib.CContext_dFree(ptrContext);
    }

    return DlResult1(context, err);
  }

  DlResult1<Context> firstContext() {
    Error err;
    Context context;
    {
      var ptrContext = clib.CContext_dAlloc();
      var cerr = clib.Wallets_firstContext(ptrContext);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      if (err.isSuccess()) {
        context = Context.fromC(ptrContext.value);
      }
      clib.CContext_dFree(ptrContext);
    }

    return DlResult1(context, err);
  }

  Error lockRead() {
    Error err;
    {
      var cerr = clib.Wallets_lockRead(_ptrContext);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
    }
    return err;
  }

  Error unlockRead() {
    Error err;
    {
      var cerr = clib.Wallets_unlockRead(_ptrContext);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
    }
    return err;
  }

  Error lockWrite() {
    Error err;
    {
      var cerr = clib.Wallets_lockWrite(_ptrContext);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
    }
    return err;
  }

  Error unlockWrite() {
    Error err;
    {
      var cerr = clib.Wallets_unlockWrite(_ptrContext);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
    }
    return err;
  }

  DlResult1<List<Wallet>> all() {
    Error err;
    List<Wallet> ws = [];
    {
      var arrayWallet = clib.CArrayCWallet_dAlloc();
      var cerr = clib.Wallets_all(ptrContext, arrayWallet);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      if (err.isSuccess()) {
        ws = ArrayCWallet.fromC(arrayWallet.value).data;
      }
      clib.CArrayCWallet_dFree(arrayWallet);
    }

    return DlResult1(ws, err);
  }

  DlResult1<String> generateMnemonic(int count) {
    Error err;
    String mn;
    {
      var ptr = clib.CStr_dAlloc();
      var cerr = clib.Wallets_generateMnemonic(count, ptr);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      if (err.isSuccess()) {
        mn = fromUtf8Null(ptr.value);
      }
      clib.CStr_dFree(ptr);
    }

    return DlResult1(mn, err);
  }

  DlResult1<Wallet> createWallet(CreateWalletParameters parameters) {
    Error err;
    Wallet wallet;
    {
      var ptr = clib.CWallet_dAlloc();
      var ptrParameters = parameters.toCPtr();
      var cerr = clib.Wallets_createWallet(ptrContext, ptrParameters, ptr);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      CreateWalletParameters.free(ptrParameters);
      if (err.isSuccess()) {
        wallet = Wallet.fromC(ptr.value);
      }
      clib.CWallet_dFree(ptr);
    }

    return DlResult1(wallet, err);
  }

  Error removeWallet(String walletId, Uint8List password) {
    Error err;
    {
      var ptrWalletId = walletId.toCPtr();
      var ptrPassword = String.fromCharCodes(password).toCPtr();
      var cerr = clib.Wallets_removeWallet(ptrContext, ptrWalletId, ptrPassword);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      ptrWalletId.free();
      ptrPassword.free();
    }

    return err;
  }

  Error renameWallet(String newName, String walletId) {
    Error err;
    {
      var ptrNewName = newName.toCPtr();
      var ptrWalletId = walletId.toCPtr();
      var cerr = clib.Wallets_renameWallet(ptrContext, ptrNewName, ptrWalletId);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      ptrWalletId.free();
      ptrNewName.free();
    }
    return err;
  }

  Error resetPwdWallet(String walletId, Uint8List oldPwd, Uint8List newPwd) {
    Error err;
    {
      var ptrWalletId = walletId.toCPtr();
      var ptrOldPwd = String.fromCharCodes(oldPwd).toCPtr();
      var ptrNewPwd = String.fromCharCodes(newPwd).toCPtr();
      var cerr = clib.Wallets_resetWalletPassword(ptrContext, ptrWalletId, ptrOldPwd, ptrNewPwd);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      ptrWalletId.free();
      ptrOldPwd.free();
      ptrNewPwd.free();
    }
    return err;
  }

  DlResult1<String> exportWallet(String walletId, Uint8List pwd) {
    Error err;
    var mne;
    {
      var ptrWalletId = walletId.toCPtr();
      var ptrPwd = String.fromCharCodes(pwd).toCPtr();
      var ptr = clib.CStr_dAlloc();
      var cerr = clib.Wallets_exportWallet(ptrContext, ptrWalletId, ptrPwd, ptr);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      if (err.isSuccess()) {
        mne = fromUtf8Null(ptr.value);
      }
      ffi.calloc.free(ptr);
      ptrWalletId.free();
      ptrPwd.free();
    }
    return DlResult1(mne, err);
  }

  DlResult1<bool> hasAny() {
    Error err;
    bool re = false;
    {
      var ptr = 0.toBoolPtr();
      var cerr = clib.Wallets_hasAny(ptrContext, ptr);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      if (err.isSuccess()) {
        re = ptr.value.isTrue();
      }
      ffi.calloc.free(ptr);
    }
    return DlResult1(re, err);
  }

  DlResult1<Wallet> findById(String walletId) {
    Error err;
    Wallet wallet;
    {
      var ptrWalletId = walletId.toCPtr();
      var ptrWallet = clib.CWallet_dAlloc();
      var cerr = clib.Wallets_findById(ptrContext, ptrWalletId, ptrWallet);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      if (err.isSuccess()) {
        wallet = Wallet.fromC(ptrWallet.value);
      }
      ptrWalletId.free();
      clib.CWallet_dFree(ptrWallet);
    }
    return DlResult1(wallet, err);
  }

  DlResult1<List<Wallet>> findWalletBaseByName(String name) {
    Error err;
    List<Wallet> wallet = [];
    {
      var ptrName = name.toCPtr();
      var ptrWallet = clib.CArrayCWallet_dAlloc();
      var cerr = clib.Wallets_findWalletBaseByName(ptrContext, ptrName, ptrWallet);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      if (err.isSuccess()) {
        wallet = ArrayCWallet.fromC(ptrWallet.value).data;
      }
      ptrName.free();
      clib.CArrayCWallet_dFree(ptrWallet);
    }
    return DlResult1(wallet, err);
  }

  DlResult1<CurrentWallet> currentWalletChain() {
    Error err;
    CurrentWallet wallet;
    {
      var ptrWalletId = clib.CStr_dAlloc();
      var ptrChainType = clib.CStr_dAlloc();
      var cerr = clib.Wallets_currentWalletChain(ptrContext, ptrWalletId, ptrChainType);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      if (err.isSuccess()) {
        String chainType = fromUtf8Null(ptrChainType.value);
        wallet = CurrentWallet(fromUtf8Null(ptrWalletId.value), chainType.toChainType());
      }
      clib.CStr_dFree(ptrWalletId);
      clib.CStr_dFree(ptrChainType);
    }
    return DlResult1(wallet, err);
  }

  Error saveCurrentWalletChain(String walletId, ChainType chainType) {
    Error err;
    {
      var ptrWalletId = walletId.toCPtr();
      var ptrChainType = chainType.toEnumString().toCPtr();
      var cerr = clib.Wallets_saveCurrentWalletChain(ptrContext, ptrWalletId, ptrChainType);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);

      ptrWalletId.free();
      ptrChainType.free();
    }
    return err;
  }

  DlResult1<List<TokenAddress>> getTokenAddress(String walletId, ChainType chainType) {
    Error err;
    List<TokenAddress> arrayCTokenAddress = [];
    {
      var ptrWalletId = walletId.toCPtr();
      var ptrChainType = chainType.toEnumString().toCPtr();
      var ptrArrayToken = clib.CArrayCTokenAddress_dAlloc();
      var cerr = clib.Wallets_queryBalance(ptrContext, ptrChainType, ptrWalletId, ptrArrayToken);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);

      if (err.isSuccess()) {
        arrayCTokenAddress = ArrayCTokenAddress.fromC(ptrArrayToken.value).data;
      }
      ptrWalletId.free();
      ptrChainType.free();
      clib.CArrayCTokenAddress_dFree(ptrArrayToken);
    }
    return DlResult1(arrayCTokenAddress, err);
  }

  Error changeTokenStatus(ChainType chainType, WalletTokenStatus walletTokenStatus) {
    Error err;
    {
      var ptrChainType = chainType.toEnumString().toCPtr();
      var ptrWalletTokenStatus = walletTokenStatus.toCPtr();
      var cerr = clib.Wallets_changeTokenShowState(ptrContext, ptrChainType, ptrWalletTokenStatus);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      WalletTokenStatus.free(ptrWalletTokenStatus);
      ptrChainType.free();
    }
    return err;
  }

  Error updateBalance(ChainType chainType, TokenAddress tokenAddress) {
    Error err;
    {
      var ptrChainType = chainType.toEnumString().toCPtr();
      var ptrTokenAddress = tokenAddress.toCPtr();
      var cerr = clib.Wallets_updateBalance(ptrContext, ptrChainType, ptrTokenAddress);
      err = Error.fromC(cerr);
      clib.CError_free(cerr);
      TokenAddress.free(ptrTokenAddress);
      ptrChainType.free();
    }
    return err;
  }

  static AppPlatformTypes appPlatformType() {
    AppPlatformTypes platformType;
    {
      var t = clib.Wallets_appPlatformType();
      var platform = fromUtf8Null(t);
      clib.CStr_free(t);
      platformType = platform.toAppPlatformTypes();
    }
    return platformType;
  }

  //wrapper start
  Error safeRead(void doRead()) {
    Error err;
    try {
      err = lockRead();
      if (err.isSuccess()) {
        doRead();
      }
    } finally {
      if (err.isSuccess()) {
        unlockRead();
      }
    }
    return err;
  }

  Error safeWrite(void doWrite()) {
    Error err;
    try {
      err = lockWrite();
      if (err.isSuccess()) {
        doWrite();
      }
    } finally {
      if (err.isSuccess()) {
        unlockWrite();
      }
    }
    return err;
  }

  //wrapper end

  ///此方法只能在主线程中调用
  factory Wallets.mainIsolate() {
    // 只能有一个实例
    if (_instance == null) {
      _instance = new Wallets._internal();
    }
    return _instance;
  }

  ///在子线程中调用时，需要上下文参数
  ///要在子线程中调用，uninit或init，这两个函数都由主线程调用
  factory Wallets.subIsolate(Context ctx) {
    if (_instance == null) {
      _instance = new Wallets._internal();
    }
    _instance.context = ctx;
    return _instance;
  }

  //
  static Wallets _instance;

  Wallets._internal();

  Pointer<clib.CContext> _ptrContext;

  Pointer<clib.CContext> get ptrContext => _ptrContext;

  ChainEth _chainEth;

  ChainEth get chainEth => _chainEth;

  ChainEee _chainEee;

  ChainEee get chainEee => _chainEee;

  ChainBtc _chainBtc;

  ChainBtc get chainBtc => _chainBtc;

  Context _context;

  Context get context => _context;

  set context(Context ctx) {
    _context = ctx;
    _ptrContext = ctx.toCPtr();
    _chainEth = new ChainEth(this);
    _chainEee = new ChainEee(this);
    _chainBtc = new ChainBtc(this);
  }
}
