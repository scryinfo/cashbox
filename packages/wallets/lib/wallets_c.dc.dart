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
    ffi.free(ptr.ref.free);
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
    c.ref.free = toUtf8Null(free_);
    c.ref.reserved = toUtf8Null(reserved);
    c.ref.misc_frozen = toUtf8Null(misc_frozen);
    c.ref.fee_frozen = toUtf8Null(fee_frozen);
    return c;
  }

  @override
  toDart(Pointer<clib.CAccountInfo> c) {
    nonce = c.ref.nonce;
    ref_count = c.ref.ref_count;
    free_ = fromUtf8Null(c.ref.free);
    reserved = fromUtf8Null(c.ref.reserved);
    misc_frozen = fromUtf8Null(c.ref.misc_frozen);
    fee_frozen = fromUtf8Null(c.ref.fee_frozen);
  }
}

class AccountInfoSyncProg extends DC<clib.CAccountInfoSyncProg> {
  String account;
  String blockNo;
  String blockHash;

  static free(Pointer<clib.CAccountInfoSyncProg> ptr) {
    ffi.free(ptr.ref.account);
    ffi.free(ptr.ref.blockNo);
    ffi.free(ptr.ref.blockHash);
    ffi.free(ptr);
  }

  static AccountInfoSyncProg fromC(Pointer<clib.CAccountInfoSyncProg> ptr) {
    var d = new AccountInfoSyncProg();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CAccountInfoSyncProg> toC() {
    var c = clib.CAccountInfoSyncProg.allocate();
    c.ref.account = toUtf8Null(account);
    c.ref.blockNo = toUtf8Null(blockNo);
    c.ref.blockHash = toUtf8Null(blockHash);
    return c;
  }

  @override
  toDart(Pointer<clib.CAccountInfoSyncProg> c) {
    account = fromUtf8Null(c.ref.account);
    blockNo = fromUtf8Null(c.ref.blockNo);
    blockHash = fromUtf8Null(c.ref.blockHash);
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
    c.ref.id = toUtf8Null(id);
    c.ref.walletId = toUtf8Null(walletId);
    c.ref.chainType = toUtf8Null(chainType);
    c.ref.address = toUtf8Null(address);
    c.ref.publicKey = toUtf8Null(publicKey);
    return c;
  }

  @override
  toDart(Pointer<clib.CAddress> c) {
    id = fromUtf8Null(c.ref.id);
    walletId = fromUtf8Null(c.ref.walletId);
    chainType = fromUtf8Null(c.ref.chainType);
    address = fromUtf8Null(c.ref.address);
    publicKey = fromUtf8Null(c.ref.publicKey);
  }
}

class ArrayCBtcChainToken extends DC<clib.CArrayCBtcChainToken> {
  BtcChainToken ptr;
  int len;
  int cap;

  ArrayCBtcChainToken() {
    ptr = new BtcChainToken();
  }

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

  ArrayCContext() {
    ptr = new Context();
  }

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

  ArrayCEeeChainToken() {
    ptr = new EeeChainToken();
  }

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

  ArrayCEthChainToken() {
    ptr = new EthChainToken();
  }

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

  ArrayCWallet() {
    ptr = new Wallet();
  }

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

  BtcChain() {
    chainShared = new ChainShared();
    tokens = new ArrayCBtcChainToken();
  }

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

  BtcChainToken() {
    btcChainTokenShared = new BtcChainTokenShared();
  }

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

  BtcChainTokenShared() {
    tokenShared = new TokenShared();
  }

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

  ChainShared() {
    walletAddress = new Address();
  }

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
    c.ref.walletId = toUtf8Null(walletId);
    c.ref.chainType = toUtf8Null(chainType);
    c.ref.walletAddress = walletAddress.toC();
    return c;
  }

  @override
  toDart(Pointer<clib.CChainShared> c) {
    walletId = fromUtf8Null(c.ref.walletId);
    chainType = fromUtf8Null(c.ref.chainType);
    walletAddress = new Address();
    walletAddress.toDart(c.ref.walletAddress);
  }
}

class ChainVersion extends DC<clib.CChainVersion> {
  String genesisHash;
  int runtimeVersion;
  int txVersion;

  static free(Pointer<clib.CChainVersion> ptr) {
    ffi.free(ptr.ref.genesisHash);
    ffi.free(ptr);
  }

  static ChainVersion fromC(Pointer<clib.CChainVersion> ptr) {
    var d = new ChainVersion();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CChainVersion> toC() {
    var c = clib.CChainVersion.allocate();
    c.ref.genesisHash = toUtf8Null(genesisHash);
    c.ref.runtimeVersion = runtimeVersion;
    c.ref.txVersion = txVersion;
    return c;
  }

  @override
  toDart(Pointer<clib.CChainVersion> c) {
    genesisHash = fromUtf8Null(c.ref.genesisHash);
    runtimeVersion = c.ref.runtimeVersion;
    txVersion = c.ref.txVersion;
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
    c.ref.id = toUtf8Null(id);
    c.ref.contextNote = toUtf8Null(contextNote);
    return c;
  }

  @override
  toDart(Pointer<clib.CContext> c) {
    id = fromUtf8Null(c.ref.id);
    contextNote = fromUtf8Null(c.ref.contextNote);
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
    c.ref.name = toUtf8Null(name);
    c.ref.password = toUtf8Null(password);
    c.ref.mnemonic = toUtf8Null(mnemonic);
    c.ref.walletType = toUtf8Null(walletType);
    return c;
  }

  @override
  toDart(Pointer<clib.CCreateWalletParameters> c) {
    name = fromUtf8Null(c.ref.name);
    password = fromUtf8Null(c.ref.password);
    mnemonic = fromUtf8Null(c.ref.mnemonic);
    walletType = fromUtf8Null(c.ref.walletType);
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
    c.ref.path = toUtf8Null(path);
    c.ref.prefix = toUtf8Null(prefix);
    c.ref.cashboxWallets = toUtf8Null(cashboxWallets);
    c.ref.cashboxMnemonic = toUtf8Null(cashboxMnemonic);
    c.ref.walletMainnet = toUtf8Null(walletMainnet);
    c.ref.walletPrivate = toUtf8Null(walletPrivate);
    c.ref.walletTestnet = toUtf8Null(walletTestnet);
    c.ref.walletTestnetPrivate = toUtf8Null(walletTestnetPrivate);
    return c;
  }

  @override
  toDart(Pointer<clib.CDbName> c) {
    path = fromUtf8Null(c.ref.path);
    prefix = fromUtf8Null(c.ref.prefix);
    cashboxWallets = fromUtf8Null(c.ref.cashboxWallets);
    cashboxMnemonic = fromUtf8Null(c.ref.cashboxMnemonic);
    walletMainnet = fromUtf8Null(c.ref.walletMainnet);
    walletPrivate = fromUtf8Null(c.ref.walletPrivate);
    walletTestnet = fromUtf8Null(c.ref.walletTestnet);
    walletTestnetPrivate = fromUtf8Null(c.ref.walletTestnetPrivate);
  }
}

class DecodeAccountInfoParameters
    extends DC<clib.CDecodeAccountInfoParameters> {
  String encodeData;
  ChainVersion chainVersion;

  DecodeAccountInfoParameters() {
    chainVersion = new ChainVersion();
  }

  static free(Pointer<clib.CDecodeAccountInfoParameters> ptr) {
    ffi.free(ptr.ref.encodeData);
    ChainVersion.free(ptr.ref.chainVersion);
    ffi.free(ptr);
  }

  static DecodeAccountInfoParameters fromC(
      Pointer<clib.CDecodeAccountInfoParameters> ptr) {
    var d = new DecodeAccountInfoParameters();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CDecodeAccountInfoParameters> toC() {
    var c = clib.CDecodeAccountInfoParameters.allocate();
    c.ref.encodeData = toUtf8Null(encodeData);
    c.ref.chainVersion = chainVersion.toC();
    return c;
  }

  @override
  toDart(Pointer<clib.CDecodeAccountInfoParameters> c) {
    encodeData = fromUtf8Null(c.ref.encodeData);
    chainVersion = new ChainVersion();
    chainVersion.toDart(c.ref.chainVersion);
  }
}

class EeeChain extends DC<clib.CEeeChain> {
  ChainShared chainShared;
  Address address;
  ArrayCEeeChainToken tokens;

  EeeChain() {
    chainShared = new ChainShared();
    address = new Address();
    tokens = new ArrayCEeeChainToken();
  }

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

  EeeChainToken() {
    eeeChainTokenShared = new EeeChainTokenShared();
  }

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

  EeeChainTokenShared() {
    tokenShared = new TokenShared();
  }

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
    c.ref.message = toUtf8Null(message);
    return c;
  }

  @override
  toDart(Pointer<clib.CError> c) {
    code = c.ref.code;
    message = fromUtf8Null(c.ref.message);
  }
}

class EthChain extends DC<clib.CEthChain> {
  ChainShared chainShared;
  ArrayCEthChainToken tokens;

  EthChain() {
    chainShared = new ChainShared();
    tokens = new ArrayCEthChainToken();
  }

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

  EthChainToken() {
    ethChainTokenShared = new EthChainTokenShared();
  }

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

  EthChainTokenShared() {
    tokenShared = new TokenShared();
  }

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

  InitParameters() {
    dbName = new DbName();
  }

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
    c.ref.contextNote = toUtf8Null(contextNote);
    return c;
  }

  @override
  toDart(Pointer<clib.CInitParameters> c) {
    dbName = new DbName();
    dbName.toDart(c.ref.dbName);
    contextNote = fromUtf8Null(c.ref.contextNote);
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
    c.ref.rawTx = toUtf8Null(rawTx);
    c.ref.walletId = toUtf8Null(walletId);
    c.ref.password = toUtf8Null(password);
    return c;
  }

  @override
  toDart(Pointer<clib.CRawTxParam> c) {
    rawTx = fromUtf8Null(c.ref.rawTx);
    walletId = fromUtf8Null(c.ref.walletId);
    password = fromUtf8Null(c.ref.password);
  }
}

class StorageKeyParameters extends DC<clib.CStorageKeyParameters> {
  ChainVersion chainVersion;
  String module;
  String storageItem;
  String pubKey;

  StorageKeyParameters() {
    chainVersion = new ChainVersion();
  }

  static free(Pointer<clib.CStorageKeyParameters> ptr) {
    ChainVersion.free(ptr.ref.chainVersion);
    ffi.free(ptr.ref.module);
    ffi.free(ptr.ref.storageItem);
    ffi.free(ptr.ref.pubKey);
    ffi.free(ptr);
  }

  static StorageKeyParameters fromC(Pointer<clib.CStorageKeyParameters> ptr) {
    var d = new StorageKeyParameters();
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CStorageKeyParameters> toC() {
    var c = clib.CStorageKeyParameters.allocate();
    c.ref.chainVersion = chainVersion.toC();
    c.ref.module = toUtf8Null(module);
    c.ref.storageItem = toUtf8Null(storageItem);
    c.ref.pubKey = toUtf8Null(pubKey);
    return c;
  }

  @override
  toDart(Pointer<clib.CStorageKeyParameters> c) {
    chainVersion = new ChainVersion();
    chainVersion.toDart(c.ref.chainVersion);
    module = fromUtf8Null(c.ref.module);
    storageItem = fromUtf8Null(c.ref.storageItem);
    pubKey = fromUtf8Null(c.ref.pubKey);
  }
}

class SubChainBasicInfo extends DC<clib.CSubChainBasicInfo> {
  String genesisHash;
  String metadata;
  int runtimeVersion;
  int txVersion;
  int ss58FormatPrefix;
  int tokenDecimals;
  String tokenSymbol;
  int isDefault;

  static free(Pointer<clib.CSubChainBasicInfo> ptr) {
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
    c.ref.genesisHash = toUtf8Null(genesisHash);
    c.ref.metadata = toUtf8Null(metadata);
    c.ref.runtimeVersion = runtimeVersion;
    c.ref.txVersion = txVersion;
    c.ref.ss58FormatPrefix = ss58FormatPrefix;
    c.ref.tokenDecimals = tokenDecimals;
    c.ref.tokenSymbol = toUtf8Null(tokenSymbol);
    c.ref.isDefault = isDefault;
    return c;
  }

  @override
  toDart(Pointer<clib.CSubChainBasicInfo> c) {
    genesisHash = fromUtf8Null(c.ref.genesisHash);
    metadata = fromUtf8Null(c.ref.metadata);
    runtimeVersion = c.ref.runtimeVersion;
    txVersion = c.ref.txVersion;
    ss58FormatPrefix = c.ref.ss58FormatPrefix;
    tokenDecimals = c.ref.tokenDecimals;
    tokenSymbol = fromUtf8Null(c.ref.tokenSymbol);
    isDefault = c.ref.isDefault;
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
    c.ref.name = toUtf8Null(name);
    c.ref.symbol = toUtf8Null(symbol);
    c.ref.logoUrl = toUtf8Null(logoUrl);
    c.ref.logoBytes = toUtf8Null(logoBytes);
    c.ref.projectName = toUtf8Null(projectName);
    c.ref.projectHome = toUtf8Null(projectHome);
    c.ref.projectNote = toUtf8Null(projectNote);
    return c;
  }

  @override
  toDart(Pointer<clib.CTokenShared> c) {
    name = fromUtf8Null(c.ref.name);
    symbol = fromUtf8Null(c.ref.symbol);
    logoUrl = fromUtf8Null(c.ref.logoUrl);
    logoBytes = fromUtf8Null(c.ref.logoBytes);
    projectName = fromUtf8Null(c.ref.projectName);
    projectHome = fromUtf8Null(c.ref.projectHome);
    projectNote = fromUtf8Null(c.ref.projectNote);
  }
}

class TransferPayload extends DC<clib.CTransferPayload> {
  String fromAccount;
  String toAccount;
  String value;
  int index;
  ChainVersion chainVersion;
  String extData;
  String password;

  TransferPayload() {
    chainVersion = new ChainVersion();
  }

  static free(Pointer<clib.CTransferPayload> ptr) {
    ffi.free(ptr.ref.fromAccount);
    ffi.free(ptr.ref.toAccount);
    ffi.free(ptr.ref.value);
    ChainVersion.free(ptr.ref.chainVersion);
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
    c.ref.fromAccount = toUtf8Null(fromAccount);
    c.ref.toAccount = toUtf8Null(toAccount);
    c.ref.value = toUtf8Null(value);
    c.ref.index = index;
    c.ref.chainVersion = chainVersion.toC();
    c.ref.extData = toUtf8Null(extData);
    c.ref.password = toUtf8Null(password);
    return c;
  }

  @override
  toDart(Pointer<clib.CTransferPayload> c) {
    fromAccount = fromUtf8Null(c.ref.fromAccount);
    toAccount = fromUtf8Null(c.ref.toAccount);
    value = fromUtf8Null(c.ref.value);
    index = c.ref.index;
    chainVersion = new ChainVersion();
    chainVersion.toDart(c.ref.chainVersion);
    extData = fromUtf8Null(c.ref.extData);
    password = fromUtf8Null(c.ref.password);
  }
}

class Wallet extends DC<clib.CWallet> {
  String id;
  String nextId;
  String name;
  EthChain ethChain;
  EeeChain eeeChain;
  BtcChain btcChain;

  Wallet() {
    ethChain = new EthChain();
    eeeChain = new EeeChain();
    btcChain = new BtcChain();
  }

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
    c.ref.id = toUtf8Null(id);
    c.ref.nextId = toUtf8Null(nextId);
    c.ref.name = toUtf8Null(name);
    c.ref.ethChain = ethChain.toC();
    c.ref.eeeChain = eeeChain.toC();
    c.ref.btcChain = btcChain.toC();
    return c;
  }

  @override
  toDart(Pointer<clib.CWallet> c) {
    id = fromUtf8Null(c.ref.id);
    nextId = fromUtf8Null(c.ref.nextId);
    name = fromUtf8Null(c.ref.name);
    ethChain = new EthChain();
    ethChain.toDart(c.ref.ethChain);
    eeeChain = new EeeChain();
    eeeChain.toDart(c.ref.eeeChain);
    btcChain = new BtcChain();
    btcChain.toDart(c.ref.btcChain);
  }
}
