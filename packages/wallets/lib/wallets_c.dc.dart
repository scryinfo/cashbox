// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// DCGenerator
// **************************************************************************

import 'dart:ffi';
import 'package:ffi/ffi.dart' as ffi;

import 'wallets_c.dart' as clib;
import 'kits.dart';

class AccountInfo extends DC<clib.CAccountInfo> {
  int nonce;
  int ref_count;
  String free_;
  String reserved;
  String misc_frozen;
  String fee_frozen;

  static free(Pointer<clib.CAccountInfo> ptr) {
    ffi.free(ptr.ref.free_);
    ffi.free(ptr.ref.reserved);
    ffi.free(ptr.ref.misc_frozen);
    ffi.free(ptr.ref.fee_frozen);
    ffi.free(ptr);
  }

  static AccountInfo fromC(Pointer<clib.CAccountInfo> ptr) {
    var d = new AccountInfo();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CAccountInfo> toC() {
    var c = clib.CAccountInfo.allocate();
    c.ref.nonce = nonce;
    c.ref.ref_count = ref_count;
    c.ref.free_ = ffi.Utf8.toUtf8(free_);
    c.ref.reserved = ffi.Utf8.toUtf8(reserved);
    c.ref.misc_frozen = ffi.Utf8.toUtf8(misc_frozen);
    c.ref.fee_frozen = ffi.Utf8.toUtf8(fee_frozen);
    return c;
  }

  @override
  toDart(Pointer<clib.CAccountInfo> c) {
    nonce = c.ref.nonce;
    ref_count = c.ref.ref_count;
    free_ = ffi.Utf8.fromUtf8(c.ref.free_);
    reserved = ffi.Utf8.fromUtf8(c.ref.reserved);
    misc_frozen = ffi.Utf8.fromUtf8(c.ref.misc_frozen);
    fee_frozen = ffi.Utf8.fromUtf8(c.ref.fee_frozen);
  }
}

class Address extends DC<clib.CAddress> {
  String id;
  String walletId;
  String chainType;
  String address;
  String publicKey;

  static free(Pointer<clib.CAddress> ptr) {
    ffi.free(ptr.ref.id);
    ffi.free(ptr.ref.walletId);
    ffi.free(ptr.ref.chainType);
    ffi.free(ptr.ref.address);
    ffi.free(ptr.ref.publicKey);
    ffi.free(ptr);
  }

  static Address fromC(Pointer<clib.CAddress> ptr) {
    var d = new Address();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CAddress> toC() {
    var c = clib.CAddress.allocate();
    c.ref.id = ffi.Utf8.toUtf8(id);
    c.ref.walletId = ffi.Utf8.toUtf8(walletId);
    c.ref.chainType = ffi.Utf8.toUtf8(chainType);
    c.ref.address = ffi.Utf8.toUtf8(address);
    c.ref.publicKey = ffi.Utf8.toUtf8(publicKey);
    return c;
  }

  @override
  toDart(Pointer<clib.CAddress> c) {
    id = ffi.Utf8.fromUtf8(c.ref.id);
    walletId = ffi.Utf8.fromUtf8(c.ref.walletId);
    chainType = ffi.Utf8.fromUtf8(c.ref.chainType);
    address = ffi.Utf8.fromUtf8(c.ref.address);
    publicKey = ffi.Utf8.fromUtf8(c.ref.publicKey);
  }
}

class ArrayCBtcChainToken extends DC<clib.CArrayCBtcChainToken> {
  BtcChainToken ptr;
  int len;
  int cap;

  static free(Pointer<clib.CArrayCBtcChainToken> ptr) {
    BtcChainToken.free(ptr.ref.ptr);
    ffi.free(ptr);
  }

  static ArrayCBtcChainToken fromC(Pointer<clib.CArrayCBtcChainToken> ptr) {
    var d = new ArrayCBtcChainToken();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCBtcChainToken> toC() {
    var c = clib.CArrayCBtcChainToken.allocate();
    c.ref.ptr = ptr.toC();
    c.ref.len = len;
    c.ref.cap = cap;
    return c;
  }

  @override
  toDart(Pointer<clib.CArrayCBtcChainToken> c) {
    ptr = new BtcChainToken();
    ptr.toDart(c.ref.ptr);
    len = c.ref.len;
    cap = c.ref.cap;
  }
}

class ArrayCContext extends DC<clib.CArrayCContext> {
  Context ptr;
  int len;
  int cap;

  static free(Pointer<clib.CArrayCContext> ptr) {
    Context.free(ptr.ref.ptr);
    ffi.free(ptr);
  }

  static ArrayCContext fromC(Pointer<clib.CArrayCContext> ptr) {
    var d = new ArrayCContext();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCContext> toC() {
    var c = clib.CArrayCContext.allocate();
    c.ref.ptr = ptr.toC();
    c.ref.len = len;
    c.ref.cap = cap;
    return c;
  }

  @override
  toDart(Pointer<clib.CArrayCContext> c) {
    ptr = new Context();
    ptr.toDart(c.ref.ptr);
    len = c.ref.len;
    cap = c.ref.cap;
  }
}

class ArrayCEeeChainToken extends DC<clib.CArrayCEeeChainToken> {
  EeeChainToken ptr;
  int len;
  int cap;

  static free(Pointer<clib.CArrayCEeeChainToken> ptr) {
    EeeChainToken.free(ptr.ref.ptr);
    ffi.free(ptr);
  }

  static ArrayCEeeChainToken fromC(Pointer<clib.CArrayCEeeChainToken> ptr) {
    var d = new ArrayCEeeChainToken();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCEeeChainToken> toC() {
    var c = clib.CArrayCEeeChainToken.allocate();
    c.ref.ptr = ptr.toC();
    c.ref.len = len;
    c.ref.cap = cap;
    return c;
  }

  @override
  toDart(Pointer<clib.CArrayCEeeChainToken> c) {
    ptr = new EeeChainToken();
    ptr.toDart(c.ref.ptr);
    len = c.ref.len;
    cap = c.ref.cap;
  }
}

class ArrayCEthChainToken extends DC<clib.CArrayCEthChainToken> {
  EthChainToken ptr;
  int len;
  int cap;

  static free(Pointer<clib.CArrayCEthChainToken> ptr) {
    EthChainToken.free(ptr.ref.ptr);
    ffi.free(ptr);
  }

  static ArrayCEthChainToken fromC(Pointer<clib.CArrayCEthChainToken> ptr) {
    var d = new ArrayCEthChainToken();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCEthChainToken> toC() {
    var c = clib.CArrayCEthChainToken.allocate();
    c.ref.ptr = ptr.toC();
    c.ref.len = len;
    c.ref.cap = cap;
    return c;
  }

  @override
  toDart(Pointer<clib.CArrayCEthChainToken> c) {
    ptr = new EthChainToken();
    ptr.toDart(c.ref.ptr);
    len = c.ref.len;
    cap = c.ref.cap;
  }
}

class ArrayCWallet extends DC<clib.CArrayCWallet> {
  Wallet ptr;
  int len;
  int cap;

  static free(Pointer<clib.CArrayCWallet> ptr) {
    Wallet.free(ptr.ref.ptr);
    ffi.free(ptr);
  }

  static ArrayCWallet fromC(Pointer<clib.CArrayCWallet> ptr) {
    var d = new ArrayCWallet();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCWallet> toC() {
    var c = clib.CArrayCWallet.allocate();
    c.ref.ptr = ptr.toC();
    c.ref.len = len;
    c.ref.cap = cap;
    return c;
  }

  @override
  toDart(Pointer<clib.CArrayCWallet> c) {
    ptr = new Wallet();
    ptr.toDart(c.ref.ptr);
    len = c.ref.len;
    cap = c.ref.cap;
  }
}

class BtcChain extends DC<clib.CBtcChain> {
  ChainShared chainShared;
  ArrayCBtcChainToken tokens;

  static free(Pointer<clib.CBtcChain> ptr) {
    ChainShared.free(ptr.ref.chainShared);
    ArrayCBtcChainToken.free(ptr.ref.tokens);
    ffi.free(ptr);
  }

  static BtcChain fromC(Pointer<clib.CBtcChain> ptr) {
    var d = new BtcChain();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CBtcChain> toC() {
    var c = clib.CBtcChain.allocate();
    c.ref.chainShared = chainShared.toC();
    c.ref.tokens = tokens.toC();
    return c;
  }

  @override
  toDart(Pointer<clib.CBtcChain> c) {
    chainShared = new ChainShared();
    chainShared.toDart(c.ref.chainShared);
    tokens = new ArrayCBtcChainToken();
    tokens.toDart(c.ref.tokens);
  }
}

class BtcChainToken extends DC<clib.CBtcChainToken> {
  BtcChainTokenShared btcChainTokenShared;

  static free(Pointer<clib.CBtcChainToken> ptr) {
    BtcChainTokenShared.free(ptr.ref.btcChainTokenShared);
    ffi.free(ptr);
  }

  static BtcChainToken fromC(Pointer<clib.CBtcChainToken> ptr) {
    var d = new BtcChainToken();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CBtcChainToken> toC() {
    var c = clib.CBtcChainToken.allocate();
    c.ref.btcChainTokenShared = btcChainTokenShared.toC();
    return c;
  }

  @override
  toDart(Pointer<clib.CBtcChainToken> c) {
    btcChainTokenShared = new BtcChainTokenShared();
    btcChainTokenShared.toDart(c.ref.btcChainTokenShared);
  }
}

class BtcChainTokenShared extends DC<clib.CBtcChainTokenShared> {
  TokenShared tokenShared;

  static free(Pointer<clib.CBtcChainTokenShared> ptr) {
    TokenShared.free(ptr.ref.tokenShared);
    ffi.free(ptr);
  }

  static BtcChainTokenShared fromC(Pointer<clib.CBtcChainTokenShared> ptr) {
    var d = new BtcChainTokenShared();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CBtcChainTokenShared> toC() {
    var c = clib.CBtcChainTokenShared.allocate();
    c.ref.tokenShared = tokenShared.toC();
    return c;
  }

  @override
  toDart(Pointer<clib.CBtcChainTokenShared> c) {
    tokenShared = new TokenShared();
    tokenShared.toDart(c.ref.tokenShared);
  }
}

class ChainShared extends DC<clib.CChainShared> {
  String walletId;
  String chainType;
  Address walletAddress;

  static free(Pointer<clib.CChainShared> ptr) {
    ffi.free(ptr.ref.walletId);
    ffi.free(ptr.ref.chainType);
    Address.free(ptr.ref.walletAddress);
    ffi.free(ptr);
  }

  static ChainShared fromC(Pointer<clib.CChainShared> ptr) {
    var d = new ChainShared();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CChainShared> toC() {
    var c = clib.CChainShared.allocate();
    c.ref.walletId = ffi.Utf8.toUtf8(walletId);
    c.ref.chainType = ffi.Utf8.toUtf8(chainType);
    c.ref.walletAddress = walletAddress.toC();
    return c;
  }

  @override
  toDart(Pointer<clib.CChainShared> c) {
    walletId = ffi.Utf8.fromUtf8(c.ref.walletId);
    chainType = ffi.Utf8.fromUtf8(c.ref.chainType);
    walletAddress = new Address();
    walletAddress.toDart(c.ref.walletAddress);
  }
}

class Context extends DC<clib.CContext> {
  String id;
  String contextNote;

  static free(Pointer<clib.CContext> ptr) {
    ffi.free(ptr.ref.id);
    ffi.free(ptr.ref.contextNote);
    ffi.free(ptr);
  }

  static Context fromC(Pointer<clib.CContext> ptr) {
    var d = new Context();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CContext> toC() {
    var c = clib.CContext.allocate();
    c.ref.id = ffi.Utf8.toUtf8(id);
    c.ref.contextNote = ffi.Utf8.toUtf8(contextNote);
    return c;
  }

  @override
  toDart(Pointer<clib.CContext> c) {
    id = ffi.Utf8.fromUtf8(c.ref.id);
    contextNote = ffi.Utf8.fromUtf8(c.ref.contextNote);
  }
}

class CreateWalletParameters extends DC<clib.CCreateWalletParameters> {
  String name;
  String password;
  String mnemonic;
  String walletType;

  static free(Pointer<clib.CCreateWalletParameters> ptr) {
    ffi.free(ptr.ref.name);
    ffi.free(ptr.ref.password);
    ffi.free(ptr.ref.mnemonic);
    ffi.free(ptr.ref.walletType);
    ffi.free(ptr);
  }

  static CreateWalletParameters fromC(
      Pointer<clib.CCreateWalletParameters> ptr) {
    var d = new CreateWalletParameters();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CCreateWalletParameters> toC() {
    var c = clib.CCreateWalletParameters.allocate();
    c.ref.name = ffi.Utf8.toUtf8(name);
    c.ref.password = ffi.Utf8.toUtf8(password);
    c.ref.mnemonic = ffi.Utf8.toUtf8(mnemonic);
    c.ref.walletType = ffi.Utf8.toUtf8(walletType);
    return c;
  }

  @override
  toDart(Pointer<clib.CCreateWalletParameters> c) {
    name = ffi.Utf8.fromUtf8(c.ref.name);
    password = ffi.Utf8.fromUtf8(c.ref.password);
    mnemonic = ffi.Utf8.fromUtf8(c.ref.mnemonic);
    walletType = ffi.Utf8.fromUtf8(c.ref.walletType);
  }
}

class DbName extends DC<clib.CDbName> {
  String path;
  String prefix;
  String cashboxWallets;
  String cashboxMnemonic;
  String walletMainnet;
  String walletPrivate;
  String walletTestnet;
  String walletTestnetPrivate;

  static free(Pointer<clib.CDbName> ptr) {
    ffi.free(ptr.ref.path);
    ffi.free(ptr.ref.prefix);
    ffi.free(ptr.ref.cashboxWallets);
    ffi.free(ptr.ref.cashboxMnemonic);
    ffi.free(ptr.ref.walletMainnet);
    ffi.free(ptr.ref.walletPrivate);
    ffi.free(ptr.ref.walletTestnet);
    ffi.free(ptr.ref.walletTestnetPrivate);
    ffi.free(ptr);
  }

  static DbName fromC(Pointer<clib.CDbName> ptr) {
    var d = new DbName();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CDbName> toC() {
    var c = clib.CDbName.allocate();
    c.ref.path = ffi.Utf8.toUtf8(path);
    c.ref.prefix = ffi.Utf8.toUtf8(prefix);
    c.ref.cashboxWallets = ffi.Utf8.toUtf8(cashboxWallets);
    c.ref.cashboxMnemonic = ffi.Utf8.toUtf8(cashboxMnemonic);
    c.ref.walletMainnet = ffi.Utf8.toUtf8(walletMainnet);
    c.ref.walletPrivate = ffi.Utf8.toUtf8(walletPrivate);
    c.ref.walletTestnet = ffi.Utf8.toUtf8(walletTestnet);
    c.ref.walletTestnetPrivate = ffi.Utf8.toUtf8(walletTestnetPrivate);
    return c;
  }

  @override
  toDart(Pointer<clib.CDbName> c) {
    path = ffi.Utf8.fromUtf8(c.ref.path);
    prefix = ffi.Utf8.fromUtf8(c.ref.prefix);
    cashboxWallets = ffi.Utf8.fromUtf8(c.ref.cashboxWallets);
    cashboxMnemonic = ffi.Utf8.fromUtf8(c.ref.cashboxMnemonic);
    walletMainnet = ffi.Utf8.fromUtf8(c.ref.walletMainnet);
    walletPrivate = ffi.Utf8.fromUtf8(c.ref.walletPrivate);
    walletTestnet = ffi.Utf8.fromUtf8(c.ref.walletTestnet);
    walletTestnetPrivate = ffi.Utf8.fromUtf8(c.ref.walletTestnetPrivate);
  }
}

class EeeChain extends DC<clib.CEeeChain> {
  ChainShared chainShared;
  Address address;
  ArrayCEeeChainToken tokens;

  static free(Pointer<clib.CEeeChain> ptr) {
    ChainShared.free(ptr.ref.chainShared);
    Address.free(ptr.ref.address);
    ArrayCEeeChainToken.free(ptr.ref.tokens);
    ffi.free(ptr);
  }

  static EeeChain fromC(Pointer<clib.CEeeChain> ptr) {
    var d = new EeeChain();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEeeChain> toC() {
    var c = clib.CEeeChain.allocate();
    c.ref.chainShared = chainShared.toC();
    c.ref.address = address.toC();
    c.ref.tokens = tokens.toC();
    return c;
  }

  @override
  toDart(Pointer<clib.CEeeChain> c) {
    chainShared = new ChainShared();
    chainShared.toDart(c.ref.chainShared);
    address = new Address();
    address.toDart(c.ref.address);
    tokens = new ArrayCEeeChainToken();
    tokens.toDart(c.ref.tokens);
  }
}

class EeeChainToken extends DC<clib.CEeeChainToken> {
  EeeChainTokenShared eeeChainTokenShared;

  static free(Pointer<clib.CEeeChainToken> ptr) {
    EeeChainTokenShared.free(ptr.ref.eeeChainTokenShared);
    ffi.free(ptr);
  }

  static EeeChainToken fromC(Pointer<clib.CEeeChainToken> ptr) {
    var d = new EeeChainToken();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEeeChainToken> toC() {
    var c = clib.CEeeChainToken.allocate();
    c.ref.eeeChainTokenShared = eeeChainTokenShared.toC();
    return c;
  }

  @override
  toDart(Pointer<clib.CEeeChainToken> c) {
    eeeChainTokenShared = new EeeChainTokenShared();
    eeeChainTokenShared.toDart(c.ref.eeeChainTokenShared);
  }
}

class EeeChainTokenShared extends DC<clib.CEeeChainTokenShared> {
  TokenShared tokenShared;

  static free(Pointer<clib.CEeeChainTokenShared> ptr) {
    TokenShared.free(ptr.ref.tokenShared);
    ffi.free(ptr);
  }

  static EeeChainTokenShared fromC(Pointer<clib.CEeeChainTokenShared> ptr) {
    var d = new EeeChainTokenShared();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEeeChainTokenShared> toC() {
    var c = clib.CEeeChainTokenShared.allocate();
    c.ref.tokenShared = tokenShared.toC();
    return c;
  }

  @override
  toDart(Pointer<clib.CEeeChainTokenShared> c) {
    tokenShared = new TokenShared();
    tokenShared.toDart(c.ref.tokenShared);
  }
}

class Error extends DC<clib.CError> {
  int code;
  String message;

  static free(Pointer<clib.CError> ptr) {
    ffi.free(ptr.ref.message);
    ffi.free(ptr);
  }

  static Error fromC(Pointer<clib.CError> ptr) {
    var d = new Error();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CError> toC() {
    var c = clib.CError.allocate();
    c.ref.code = code;
    c.ref.message = ffi.Utf8.toUtf8(message);
    return c;
  }

  @override
  toDart(Pointer<clib.CError> c) {
    code = c.ref.code;
    message = ffi.Utf8.fromUtf8(c.ref.message);
  }
}

class EthChain extends DC<clib.CEthChain> {
  ChainShared chainShared;
  ArrayCEthChainToken tokens;

  static free(Pointer<clib.CEthChain> ptr) {
    ChainShared.free(ptr.ref.chainShared);
    ArrayCEthChainToken.free(ptr.ref.tokens);
    ffi.free(ptr);
  }

  static EthChain fromC(Pointer<clib.CEthChain> ptr) {
    var d = new EthChain();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEthChain> toC() {
    var c = clib.CEthChain.allocate();
    c.ref.chainShared = chainShared.toC();
    c.ref.tokens = tokens.toC();
    return c;
  }

  @override
  toDart(Pointer<clib.CEthChain> c) {
    chainShared = new ChainShared();
    chainShared.toDart(c.ref.chainShared);
    tokens = new ArrayCEthChainToken();
    tokens.toDart(c.ref.tokens);
  }
}

class EthChainToken extends DC<clib.CEthChainToken> {
  EthChainTokenShared ethChainTokenShared;

  static free(Pointer<clib.CEthChainToken> ptr) {
    EthChainTokenShared.free(ptr.ref.ethChainTokenShared);
    ffi.free(ptr);
  }

  static EthChainToken fromC(Pointer<clib.CEthChainToken> ptr) {
    var d = new EthChainToken();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEthChainToken> toC() {
    var c = clib.CEthChainToken.allocate();
    c.ref.ethChainTokenShared = ethChainTokenShared.toC();
    return c;
  }

  @override
  toDart(Pointer<clib.CEthChainToken> c) {
    ethChainTokenShared = new EthChainTokenShared();
    ethChainTokenShared.toDart(c.ref.ethChainTokenShared);
  }
}

class EthChainTokenShared extends DC<clib.CEthChainTokenShared> {
  TokenShared tokenShared;

  static free(Pointer<clib.CEthChainTokenShared> ptr) {
    TokenShared.free(ptr.ref.tokenShared);
    ffi.free(ptr);
  }

  static EthChainTokenShared fromC(Pointer<clib.CEthChainTokenShared> ptr) {
    var d = new EthChainTokenShared();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEthChainTokenShared> toC() {
    var c = clib.CEthChainTokenShared.allocate();
    c.ref.tokenShared = tokenShared.toC();
    return c;
  }

  @override
  toDart(Pointer<clib.CEthChainTokenShared> c) {
    tokenShared = new TokenShared();
    tokenShared.toDart(c.ref.tokenShared);
  }
}

class InitParameters extends DC<clib.CInitParameters> {
  DbName dbName;
  String contextNote;

  static free(Pointer<clib.CInitParameters> ptr) {
    DbName.free(ptr.ref.dbName);
    ffi.free(ptr.ref.contextNote);
    ffi.free(ptr);
  }

  static InitParameters fromC(Pointer<clib.CInitParameters> ptr) {
    var d = new InitParameters();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CInitParameters> toC() {
    var c = clib.CInitParameters.allocate();
    c.ref.dbName = dbName.toC();
    c.ref.contextNote = ffi.Utf8.toUtf8(contextNote);
    return c;
  }

  @override
  toDart(Pointer<clib.CInitParameters> c) {
    dbName = new DbName();
    dbName.toDart(c.ref.dbName);
    contextNote = ffi.Utf8.fromUtf8(c.ref.contextNote);
  }
}

class RawTxParam extends DC<clib.CRawTxParam> {
  String rawTx;
  String walletId;
  String password;

  static free(Pointer<clib.CRawTxParam> ptr) {
    ffi.free(ptr.ref.rawTx);
    ffi.free(ptr.ref.walletId);
    ffi.free(ptr.ref.password);
    ffi.free(ptr);
  }

  static RawTxParam fromC(Pointer<clib.CRawTxParam> ptr) {
    var d = new RawTxParam();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CRawTxParam> toC() {
    var c = clib.CRawTxParam.allocate();
    c.ref.rawTx = ffi.Utf8.toUtf8(rawTx);
    c.ref.walletId = ffi.Utf8.toUtf8(walletId);
    c.ref.password = ffi.Utf8.toUtf8(password);
    return c;
  }

  @override
  toDart(Pointer<clib.CRawTxParam> c) {
    rawTx = ffi.Utf8.fromUtf8(c.ref.rawTx);
    walletId = ffi.Utf8.fromUtf8(c.ref.walletId);
    password = ffi.Utf8.fromUtf8(c.ref.password);
  }
}

class SubChainBasicInfo extends DC<clib.CSubChainBasicInfo> {
  String infoId;
  String genesisHash;
  String metadata;
  int runtimeVersion;
  int txVersion;
  int ss58Format;
  int tokenDecimals;
  String tokenSymbol;

  static free(Pointer<clib.CSubChainBasicInfo> ptr) {
    ffi.free(ptr.ref.infoId);
    ffi.free(ptr.ref.genesisHash);
    ffi.free(ptr.ref.metadata);
    ffi.free(ptr.ref.tokenSymbol);
    ffi.free(ptr);
  }

  static SubChainBasicInfo fromC(Pointer<clib.CSubChainBasicInfo> ptr) {
    var d = new SubChainBasicInfo();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CSubChainBasicInfo> toC() {
    var c = clib.CSubChainBasicInfo.allocate();
    c.ref.infoId = ffi.Utf8.toUtf8(infoId);
    c.ref.genesisHash = ffi.Utf8.toUtf8(genesisHash);
    c.ref.metadata = ffi.Utf8.toUtf8(metadata);
    c.ref.runtimeVersion = runtimeVersion;
    c.ref.txVersion = txVersion;
    c.ref.ss58Format = ss58Format;
    c.ref.tokenDecimals = tokenDecimals;
    c.ref.tokenSymbol = ffi.Utf8.toUtf8(tokenSymbol);
    return c;
  }

  @override
  toDart(Pointer<clib.CSubChainBasicInfo> c) {
    infoId = ffi.Utf8.fromUtf8(c.ref.infoId);
    genesisHash = ffi.Utf8.fromUtf8(c.ref.genesisHash);
    metadata = ffi.Utf8.fromUtf8(c.ref.metadata);
    runtimeVersion = c.ref.runtimeVersion;
    txVersion = c.ref.txVersion;
    ss58Format = c.ref.ss58Format;
    tokenDecimals = c.ref.tokenDecimals;
    tokenSymbol = ffi.Utf8.fromUtf8(c.ref.tokenSymbol);
  }
}

class SyncRecordDetail extends DC<clib.CSyncRecordDetail> {
  String account;
  String blockNo;
  String blockHash;

  static free(Pointer<clib.CSyncRecordDetail> ptr) {
    ffi.free(ptr.ref.account);
    ffi.free(ptr.ref.blockNo);
    ffi.free(ptr.ref.blockHash);
    ffi.free(ptr);
  }

  static SyncRecordDetail fromC(Pointer<clib.CSyncRecordDetail> ptr) {
    var d = new SyncRecordDetail();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CSyncRecordDetail> toC() {
    var c = clib.CSyncRecordDetail.allocate();
    c.ref.account = ffi.Utf8.toUtf8(account);
    c.ref.blockNo = ffi.Utf8.toUtf8(blockNo);
    c.ref.blockHash = ffi.Utf8.toUtf8(blockHash);
    return c;
  }

  @override
  toDart(Pointer<clib.CSyncRecordDetail> c) {
    account = ffi.Utf8.fromUtf8(c.ref.account);
    blockNo = ffi.Utf8.fromUtf8(c.ref.blockNo);
    blockHash = ffi.Utf8.fromUtf8(c.ref.blockHash);
  }
}

class TokenShared extends DC<clib.CTokenShared> {
  String name;
  String symbol;
  String logoUrl;
  String logoBytes;
  String projectName;
  String projectHome;
  String projectNote;

  static free(Pointer<clib.CTokenShared> ptr) {
    ffi.free(ptr.ref.name);
    ffi.free(ptr.ref.symbol);
    ffi.free(ptr.ref.logoUrl);
    ffi.free(ptr.ref.logoBytes);
    ffi.free(ptr.ref.projectName);
    ffi.free(ptr.ref.projectHome);
    ffi.free(ptr.ref.projectNote);
    ffi.free(ptr);
  }

  static TokenShared fromC(Pointer<clib.CTokenShared> ptr) {
    var d = new TokenShared();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CTokenShared> toC() {
    var c = clib.CTokenShared.allocate();
    c.ref.name = ffi.Utf8.toUtf8(name);
    c.ref.symbol = ffi.Utf8.toUtf8(symbol);
    c.ref.logoUrl = ffi.Utf8.toUtf8(logoUrl);
    c.ref.logoBytes = ffi.Utf8.toUtf8(logoBytes);
    c.ref.projectName = ffi.Utf8.toUtf8(projectName);
    c.ref.projectHome = ffi.Utf8.toUtf8(projectHome);
    c.ref.projectNote = ffi.Utf8.toUtf8(projectNote);
    return c;
  }

  @override
  toDart(Pointer<clib.CTokenShared> c) {
    name = ffi.Utf8.fromUtf8(c.ref.name);
    symbol = ffi.Utf8.fromUtf8(c.ref.symbol);
    logoUrl = ffi.Utf8.fromUtf8(c.ref.logoUrl);
    logoBytes = ffi.Utf8.fromUtf8(c.ref.logoBytes);
    projectName = ffi.Utf8.fromUtf8(c.ref.projectName);
    projectHome = ffi.Utf8.fromUtf8(c.ref.projectHome);
    projectNote = ffi.Utf8.fromUtf8(c.ref.projectNote);
  }
}

class TransferPayload extends DC<clib.CTransferPayload> {
  String fromAccount;
  String toAccount;
  String value;
  String genesisHash;
  int index;
  int runtime_version;
  int tx_version;
  String extData;
  String password;

  static free(Pointer<clib.CTransferPayload> ptr) {
    ffi.free(ptr.ref.fromAccount);
    ffi.free(ptr.ref.toAccount);
    ffi.free(ptr.ref.value);
    ffi.free(ptr.ref.genesisHash);
    ffi.free(ptr.ref.extData);
    ffi.free(ptr.ref.password);
    ffi.free(ptr);
  }

  static TransferPayload fromC(Pointer<clib.CTransferPayload> ptr) {
    var d = new TransferPayload();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CTransferPayload> toC() {
    var c = clib.CTransferPayload.allocate();
    c.ref.fromAccount = ffi.Utf8.toUtf8(fromAccount);
    c.ref.toAccount = ffi.Utf8.toUtf8(toAccount);
    c.ref.value = ffi.Utf8.toUtf8(value);
    c.ref.genesisHash = ffi.Utf8.toUtf8(genesisHash);
    c.ref.index = index;
    c.ref.runtime_version = runtime_version;
    c.ref.tx_version = tx_version;
    c.ref.extData = ffi.Utf8.toUtf8(extData);
    c.ref.password = ffi.Utf8.toUtf8(password);
    return c;
  }

  @override
  toDart(Pointer<clib.CTransferPayload> c) {
    fromAccount = ffi.Utf8.fromUtf8(c.ref.fromAccount);
    toAccount = ffi.Utf8.fromUtf8(c.ref.toAccount);
    value = ffi.Utf8.fromUtf8(c.ref.value);
    genesisHash = ffi.Utf8.fromUtf8(c.ref.genesisHash);
    index = c.ref.index;
    runtime_version = c.ref.runtime_version;
    tx_version = c.ref.tx_version;
    extData = ffi.Utf8.fromUtf8(c.ref.extData);
    password = ffi.Utf8.fromUtf8(c.ref.password);
  }
}

class Wallet extends DC<clib.CWallet> {
  String id;
  String nextId;
  String name;
  EthChain ethChain;
  EeeChain eeeChain;
  BtcChain btcChain;

  static free(Pointer<clib.CWallet> ptr) {
    ffi.free(ptr.ref.id);
    ffi.free(ptr.ref.nextId);
    ffi.free(ptr.ref.name);
    EthChain.free(ptr.ref.ethChain);
    EeeChain.free(ptr.ref.eeeChain);
    BtcChain.free(ptr.ref.btcChain);
    ffi.free(ptr);
  }

  static Wallet fromC(Pointer<clib.CWallet> ptr) {
    var d = new Wallet();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CWallet> toC() {
    var c = clib.CWallet.allocate();
    c.ref.id = ffi.Utf8.toUtf8(id);
    c.ref.nextId = ffi.Utf8.toUtf8(nextId);
    c.ref.name = ffi.Utf8.toUtf8(name);
    c.ref.ethChain = ethChain.toC();
    c.ref.eeeChain = eeeChain.toC();
    c.ref.btcChain = btcChain.toC();
    return c;
  }

  @override
  toDart(Pointer<clib.CWallet> c) {
    id = ffi.Utf8.fromUtf8(c.ref.id);
    nextId = ffi.Utf8.fromUtf8(c.ref.nextId);
    name = ffi.Utf8.fromUtf8(c.ref.name);
    ethChain = new EthChain();
    ethChain.toDart(c.ref.ethChain);
    eeeChain = new EeeChain();
    eeeChain.toDart(c.ref.eeeChain);
    btcChain = new BtcChain();
    btcChain.toDart(c.ref.btcChain);
  }
}
