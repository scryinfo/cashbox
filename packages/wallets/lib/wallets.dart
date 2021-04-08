library wallets;

import 'dart:ffi';
import 'dart:typed_data';

import 'package:ffi/ffi.dart' as ffi;
import 'package:logger/logger.dart';
import 'package:wallets/chain_btc.dart';
import 'package:wallets/chain_eee.dart';
import 'package:wallets/chain_eth.dart';
import 'package:wallets/wallets_c.dc.dart';

import 'enums.dart';
import 'kits.dart';
import 'result.dart';
import 'wallets_c.dart' as clib;

const _tag = "Wallets";

class Wallets {
  ///如果失败返回 null，失败的可能性非常小
  static DbName dbName(DbName name) {
    var ptrOutName = _cWallets.CDbName_dAlloc();
    Error err;
    {
      var ptrName = name.toCPtr();
      var cerr = _cWallets.Wallets_dbName(ptrName, ptrOutName);
      err = Error.fromC(cerr);
      _cWallets.CError_free(cerr);
      DbName.free(ptrName);
    }
    DbName outName;
    if (err.isSuccess()) {
      outName = DbName.fromC(ptrOutName.value);
    } else {
      Logger().e(_tag, err.toString());
      outName = new DbName();
    }
    _cWallets.CDbName_dFree(ptrOutName);
    return outName;
  }

  Error init(InitParameters parameters) {
    var ptrContext = _cWallets.CContext_dAlloc();
    Error err;
    {
      var ptrParameters = parameters.toCPtr();
      var cerr = _cWallets.Wallets_init(ptrParameters, ptrContext);
      err = Error.fromC(cerr);
      _cWallets.CError_free(cerr);
      InitParameters.free(ptrParameters);
    }
    if (err.isSuccess()) {
      var ctx = Context.fromC(ptrContext.value);
      context = ctx;
    } else {
      Logger.getInstance().f(_tag, err.message);
    }
    _cWallets.CContext_dFree(ptrContext);
    return err;
  }

  Error uninit() {
    Error err;
    {
      var cerr = _cWallets.Wallets_uninit(ptrContext);
      err = Error.fromC(cerr);
      _cWallets.CError_free(cerr);
    }

    Context.free(ptrContext);
    _ptrContext = nullptr;
    return err;
  }

  DlResult1<List<Context>> contexts() {
    Error err;
    List<Context> contexts = [];
    {
      var ptrContexts = _cWallets.CArrayCContext_dAlloc();
      var cerr = _cWallets.Wallets_Contexts(ptrContexts);
      err = Error.fromC(cerr);
      _cWallets.CError_free(cerr);
      if (err.isSuccess()) {
        contexts = ArrayCContext.fromC(ptrContexts.value).data;
      }
      _cWallets.CArrayCContext_dFree(ptrContexts);
    }

    return DlResult1(contexts, err);
  }

  DlResult1<Context> lastContext() {
    Error err;
    Context context;
    {
      var ptrContext = _cWallets.CContext_dAlloc();
      var cerr = _cWallets.Wallets_lastContext(ptrContext);
      err = Error.fromC(cerr);
      _cWallets.CError_free(cerr);
      if (err.isSuccess()) {
        context = Context.fromC(ptrContext.value);
      } else {
        Logger.getInstance().e(_tag, err.message);
        context = new Context();
      }
      _cWallets.CContext_dFree(ptrContext);
    }

    return DlResult1(context, err);
  }

  DlResult1<Context> firstContext() {
    Error err;
    Context context;
    {
      var ptrContext = _cWallets.CContext_dAlloc();
      var cerr = _cWallets.Wallets_firstContext(ptrContext);
      err = Error.fromC(cerr);
      _cWallets.CError_free(cerr);
      if (err.isSuccess()) {
        context = Context.fromC(ptrContext.value);
      } else {
        Logger.getInstance().e(_tag, err.message);
        context = new Context();
      }
      _cWallets.CContext_dFree(ptrContext);
    }

    return DlResult1(context, err);
  }

  Error lockRead() {
    Error err;
    {
      var cerr = _cWallets.Wallets_lockRead(_ptrContext);
      err = Error.fromC(cerr);
      _cWallets.CError_free(cerr);
    }
    return err;
  }

  Error unlockRead() {
    Error err;
    {
      var cerr = _cWallets.Wallets_unlockRead(_ptrContext);
      err = Error.fromC(cerr);
      _cWallets.CError_free(cerr);
    }
    return err;
  }

  Error lockWrite() {
    Error err;
    {
      var cerr = _cWallets.Wallets_lockWrite(_ptrContext);
      err = Error.fromC(cerr);
      _cWallets.CError_free(cerr);
    }
    return err;
  }

  Error unlockWrite() {
    Error err;
    {
      var cerr = _cWallets.Wallets_unlockWrite(_ptrContext);
      err = Error.fromC(cerr);
      _cWallets.CError_free(cerr);
    }
    return err;
  }

  DlResult1<List<Wallet>> all() {
    Error err;
    List<Wallet> ws = [];
    {
      var arrayWallet = _cWallets.CArrayCWallet_dAlloc();
      var cerr = _cWallets.Wallets_all(ptrContext, arrayWallet);
      err = Error.fromC(cerr);
      _cWallets.CError_free(cerr);
      if (err.isSuccess()) {
        ws = ArrayCWallet.fromC(arrayWallet.value).data;
      }
      _cWallets.CArrayCWallet_dFree(arrayWallet);
    }

    return DlResult1(ws, err);
  }

  DlResult1<String> generateMnemonic(int count) {
    Error err;
    String mn = "";
    {
      var ptr = _cWallets.CStr_dAlloc();
      var cerr = _cWallets.Wallets_generateMnemonic(count, ptr);
      err = Error.fromC(cerr);
      _cWallets.CError_free(cerr);
      if (err.isSuccess()) {
        mn = ptr.value.toDartString();
      }
      _cWallets.CStr_dFree(ptr);
    }

    return DlResult1(mn, err);
  }

  Error changeNetType(NetType netType) {
    Error err;
    {
      var ptrNetType = netType.toEnumString().toCPtrInt8();
      var cerr = _cWallets.Wallets_changeNetType(ptrContext, ptrNetType);
      err = Error.fromC(cerr);
      _cWallets.CError_free(cerr);
      ptrNetType.free();
    }
    return err;
  }

  DlResult1<Wallet> createWallet(CreateWalletParameters parameters) {
    Error err;
    Wallet wallet;
    {
      var ptr = _cWallets.CWallet_dAlloc();
      var ptrParameters = parameters.toCPtr();
      var cerr = _cWallets.Wallets_createWallet(ptrContext, ptrParameters, ptr);
      err = Error.fromC(cerr);
      _cWallets.CError_free(cerr);
      CreateWalletParameters.free(ptrParameters);
      if (err.isSuccess()) {
        wallet = Wallet.fromC(ptr.value);
      } else {
        Logger.getInstance().e(_tag, err.message);
        wallet = new Wallet();
      }
      _cWallets.CWallet_dFree(ptr);
    }

    return DlResult1(wallet, err);
  }

  Error removeWallet(String walletId, Uint8List password) {
    Error err;
    {
      var ptrWalletId = walletId.toCPtrInt8();
      var ptrPassword = String.fromCharCodes(password).toCPtrInt8();
      var cerr = _cWallets.Wallets_removeWallet(ptrContext, ptrWalletId, ptrPassword);
      err = Error.fromC(cerr);
      _cWallets.CError_free(cerr);
      ptrWalletId.free();
      ptrPassword.free();
    }

    return err;
  }

  Error renameWallet(String newName, String walletId) {
    Error err;
    {
      var ptrNewName = newName.toCPtrInt8();
      var ptrWalletId = walletId.toCPtrInt8();
      var cerr = _cWallets.Wallets_renameWallet(ptrContext, ptrNewName, ptrWalletId);
      err = Error.fromC(cerr);
      _cWallets.CError_free(cerr);
      ptrWalletId.free();
      ptrNewName.free();
    }
    return err;
  }

  Error resetPwdWallet(String walletId, Uint8List oldPwd, Uint8List newPwd) {
    Error err;
    {
      var ptrWalletId = walletId.toCPtrInt8();
      var ptrOldPwd = String.fromCharCodes(oldPwd).toCPtrInt8();
      var ptrNewPwd = String.fromCharCodes(newPwd).toCPtrInt8();
      var cerr = _cWallets.Wallets_resetWalletPassword(ptrContext, ptrWalletId, ptrOldPwd, ptrNewPwd);
      err = Error.fromC(cerr);
      _cWallets.CError_free(cerr);
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
      var ptrWalletId = walletId.toCPtrInt8();
      var ptrPwd = String.fromCharCodes(pwd).toCPtrInt8();
      var ptr = _cWallets.CStr_dAlloc();
      var cerr = _cWallets.Wallets_exportWallet(ptrContext, ptrWalletId, ptrPwd, ptr);
      err = Error.fromC(cerr);
      _cWallets.CError_free(cerr);
      if (err.isSuccess()) {
        mne = ptr.value.toDartString();
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
      var cerr = _cWallets.Wallets_hasAny(ptrContext, ptr);
      err = Error.fromC(cerr);
      _cWallets.CError_free(cerr);
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
      var ptrWalletId = walletId.toCPtrInt8();
      var ptrWallet = _cWallets.CWallet_dAlloc();
      var cerr = _cWallets.Wallets_findById(ptrContext, ptrWalletId, ptrWallet);
      err = Error.fromC(cerr);
      _cWallets.CError_free(cerr);
      if (err.isSuccess()) {
        wallet = Wallet.fromC(ptrWallet.value);
      } else {
        Logger.getInstance().e(_tag, err.message);
        wallet = new Wallet();
      }
      ptrWalletId.free();
      _cWallets.CWallet_dFree(ptrWallet);
    }
    return DlResult1(wallet, err);
  }

  DlResult1<List<Wallet>> findWalletBaseByName(String name) {
    Error err;
    List<Wallet> wallet = [];
    {
      var ptrName = name.toCPtrInt8();
      var ptrWallet = _cWallets.CArrayCWallet_dAlloc();
      var cerr = _cWallets.Wallets_findWalletBaseByName(ptrContext, ptrName, ptrWallet);
      err = Error.fromC(cerr);
      _cWallets.CError_free(cerr);
      if (err.isSuccess()) {
        wallet = ArrayCWallet.fromC(ptrWallet.value).data;
      }
      ptrName.free();
      _cWallets.CArrayCWallet_dFree(ptrWallet);
    }
    return DlResult1(wallet, err);
  }

  DlResult1<CurrentWallet> currentWalletChain() {
    Error err;
    CurrentWallet wallet;
    {
      var ptrWalletId = _cWallets.CStr_dAlloc();
      var ptrChainType = _cWallets.CStr_dAlloc();
      var cerr = _cWallets.Wallets_currentWalletChain(ptrContext, ptrWalletId, ptrChainType);
      err = Error.fromC(cerr);
      _cWallets.CError_free(cerr);
      if (err.isSuccess()) {
        String chainType = ptrChainType.value.toDartString();
        wallet = CurrentWallet(ptrWalletId.value.toDartString(), chainType.toChainType());
      } else {
        Logger.getInstance().e(_tag, err.message);
        wallet = CurrentWallet.initValue();
      }
      _cWallets.CStr_dFree(ptrWalletId);
      _cWallets.CStr_dFree(ptrChainType);
    }
    return DlResult1(wallet, err);
  }

  Error saveCurrentWalletChain(String walletId, ChainType chainType) {
    Error err;
    {
      var ptrWalletId = walletId.toCPtrInt8();
      var ptrChainType = chainType.toEnumString().toCPtrInt8();
      var cerr = _cWallets.Wallets_saveCurrentWalletChain(ptrContext, ptrWalletId, ptrChainType);
      err = Error.fromC(cerr);
      _cWallets.CError_free(cerr);

      ptrWalletId.free();
      ptrChainType.free();
    }
    return err;
  }

  DlResult1<List<TokenAddress>> getTokenAddress(String walletId) {
    Error err;
    List<TokenAddress> arrayCTokenAddress = [];
    {
      var ptrWalletId = walletId.toCPtrInt8();
      var ptrArrayToken = _cWallets.CArrayCTokenAddress_dAlloc();
      var cerr = _cWallets.Wallets_queryBalance(ptrContext, ptrWalletId, ptrArrayToken);
      err = Error.fromC(cerr);
      _cWallets.CError_free(cerr);

      if (err.isSuccess()) {
        arrayCTokenAddress = ArrayCTokenAddress.fromC(ptrArrayToken.value).data;
      }
      ptrWalletId.free();
      _cWallets.CArrayCTokenAddress_dFree(ptrArrayToken);
    }
    return DlResult1(arrayCTokenAddress, err);
  }

  Error changeTokenStatus(WalletTokenStatus walletTokenStatus) {
    Error err;
    {
      var ptrWalletTokenStatus = walletTokenStatus.toCPtr();
      var cerr = _cWallets.Wallets_changeTokenShowState(ptrContext, ptrWalletTokenStatus);
      err = Error.fromC(cerr);
      _cWallets.CError_free(cerr);
      WalletTokenStatus.free(ptrWalletTokenStatus);
    }
    return err;
  }

  Error updateBalance(TokenAddress tokenAddress) {
    Error err;
    {
      var ptrTokenAddress = tokenAddress.toCPtr();
      var cerr = _cWallets.Wallets_updateBalance(ptrContext, ptrTokenAddress);
      err = Error.fromC(cerr);
      _cWallets.CError_free(cerr);
      TokenAddress.free(ptrTokenAddress);
    }
    return err;
  }

  static AppPlatformTypes appPlatformType() {
    AppPlatformTypes platformType;
    {
      var t = _cWallets.Wallets_appPlatformType();
      var platform = t.toDartString();
      _cWallets.CStr_free(t);
      platformType = platform.toAppPlatformTypes();
    }
    return platformType;
  }

  //wrapper start
  Error safeRead(void doRead()) {
    Error err = new Error();
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
    Error err = new Error();
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
  static Wallets _instance = Wallets._internal();
  static clib.CWallets _cWallets = new clib.CWallets(dlOpenPlatformSpecific("wallets_cdl"));

  static clib.CWallets get cWallets => _cWallets;

  Wallets._internal();

  Pointer<clib.CContext> _ptrContext = nullptr;

  Pointer<clib.CContext> get ptrContext => _ptrContext;

  late ChainEth _chainEth;

  ChainEth get chainEth => _chainEth;

  late ChainEee _chainEee;

  ChainEee get chainEee => _chainEee;

  late ChainBtc _chainBtc;

  ChainBtc get chainBtc => _chainBtc;

  late Context _context;

  Context get context => _context;

  set context(Context ctx) {
    _context = ctx;
    _ptrContext = ctx.toCPtr();
    _chainEth = new ChainEth(this);
    _chainEee = new ChainEee(this);
    _chainBtc = new ChainBtc(this);
  }
}
