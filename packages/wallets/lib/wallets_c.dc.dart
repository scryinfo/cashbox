// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// DCGenerator
// **************************************************************************

import 'dart:ffi';
import 'package:ffi/ffi.dart' as ffi;

import 'wallets_c.dart' as clib;
import 'kits.dart';

class __fsid_t implements DC<clib.__fsid_t>{
  Array __val = 0;

  static freeInstance(clib.__fsid_t instance) {

  }
    
  static free(Pointer<clib.__fsid_t> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static __fsid_t fromC(Pointer<clib.__fsid_t> ptr) {
    var d = new __fsid_t();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.__fsid_t> toCPtr() {
    var ptr = allocateZero<clib.__fsid_t>(sizeOf<clib.__fsid_t>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.__fsid_t> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.__fsid_t c) {
    c.__val = __val;

  }

  @override
  toDart(Pointer<clib.__fsid_t> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.__fsid_t c) {
    __val = c.__val;
  }
}

class Context implements DC<clib.CContext>{
   id = 0;
   contextNote = 0;

  static freeInstance(clib.CContext instance) {
    if (instance.id != nullptr) {ffi.calloc.free(instance.id);}
    instance.id = nullptr;
    if (instance.contextNote != nullptr) {ffi.calloc.free(instance.contextNote);}
    instance.contextNote = nullptr;

  }
    
  static free(Pointer<clib.CContext> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static Context fromC(Pointer<clib.CContext> ptr) {
    var d = new Context();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CContext> toCPtr() {
    var ptr = allocateZero<clib.CContext>(sizeOf<clib.CContext>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CContext> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CContext c) {
    c.id.value = id;
    c.contextNote.value = contextNote;

  }

  @override
  toDart(Pointer<clib.CContext> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CContext c) {
    id = c.id.value;
    contextNote = c.contextNote.value;
  }
}

class ArrayCContext implements DC<clib.CArrayCContext>{
  List<Context> data = <Context>[];
  
  static free(Pointer<clib.CArrayCContext> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }
  
  static freeInstance(clib.CArrayCContext instance) {
    Context.free(instance.ptr);
    instance.ptr = nullptr;
  }
  
  static ArrayCContext fromC(Pointer<clib.CArrayCContext> ptr) {
    var d = new ArrayCContext();
    if (ptr == nullptr) {
      return d;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCContext> toCPtr() {
    var c = allocateZero<clib.CArrayCContext>(sizeOf<clib.CArrayCContext>());
    toC(c);
    return c;
  }
  
  @override
  toC(Pointer<clib.CArrayCContext> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CArrayCContext c) {
    if (c.ptr != nullptr) {
      Context.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CContext>(sizeOf<clib.CContext>(),count : data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length;i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCContext> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }
  @override
  toDartInstance(clib.CArrayCContext c) {
    data =  <Context>[];
    for (var i = 0; i < c.len;i++) {
      data.add(new Context());      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}


class Error implements DC<clib.CError>{
  int code = 0;
   message = 0;

  static freeInstance(clib.CError instance) {
    if (instance.message != nullptr) {ffi.calloc.free(instance.message);}
    instance.message = nullptr;

  }
    
  static free(Pointer<clib.CError> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static Error fromC(Pointer<clib.CError> ptr) {
    var d = new Error();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CError> toCPtr() {
    var ptr = allocateZero<clib.CError>(sizeOf<clib.CError>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CError> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CError c) {
    c.code = code;
    c.message.value = message;

  }

  @override
  toDart(Pointer<clib.CError> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CError c) {
    code = c.code;
    message = c.message.value;
  }
}

class Address implements DC<clib.CAddress>{
   id = 0;
   walletId = 0;
   chainType = 0;
   address = 0;
   publicKey = 0;
  int isWalletAddress = 0;
  int show1 = 0;

  static freeInstance(clib.CAddress instance) {
    if (instance.id != nullptr) {ffi.calloc.free(instance.id);}
    instance.id = nullptr;
    if (instance.walletId != nullptr) {ffi.calloc.free(instance.walletId);}
    instance.walletId = nullptr;
    if (instance.chainType != nullptr) {ffi.calloc.free(instance.chainType);}
    instance.chainType = nullptr;
    if (instance.address != nullptr) {ffi.calloc.free(instance.address);}
    instance.address = nullptr;
    if (instance.publicKey != nullptr) {ffi.calloc.free(instance.publicKey);}
    instance.publicKey = nullptr;

  }
    
  static free(Pointer<clib.CAddress> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static Address fromC(Pointer<clib.CAddress> ptr) {
    var d = new Address();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CAddress> toCPtr() {
    var ptr = allocateZero<clib.CAddress>(sizeOf<clib.CAddress>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CAddress> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CAddress c) {
    c.id.value = id;
    c.walletId.value = walletId;
    c.chainType.value = chainType;
    c.address.value = address;
    c.publicKey.value = publicKey;
    c.isWalletAddress = isWalletAddress;
    c.show1 = show1;

  }

  @override
  toDart(Pointer<clib.CAddress> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CAddress c) {
    id = c.id.value;
    walletId = c.walletId.value;
    chainType = c.chainType.value;
    address = c.address.value;
    publicKey = c.publicKey.value;
    isWalletAddress = c.isWalletAddress;
    show1 = c.show1;
  }
}

class ChainShared implements DC<clib.CChainShared>{
   walletId = 0;
   chainType = 0;
  Address walletAddress = new Address();

  static freeInstance(clib.CChainShared instance) {
    if (instance.walletId != nullptr) {ffi.calloc.free(instance.walletId);}
    instance.walletId = nullptr;
    if (instance.chainType != nullptr) {ffi.calloc.free(instance.chainType);}
    instance.chainType = nullptr;
    Address.free(instance.walletAddress);
    instance.walletAddress = nullptr;

  }
    
  static free(Pointer<clib.CChainShared> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static ChainShared fromC(Pointer<clib.CChainShared> ptr) {
    var d = new ChainShared();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CChainShared> toCPtr() {
    var ptr = allocateZero<clib.CChainShared>(sizeOf<clib.CChainShared>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CChainShared> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CChainShared c) {
    c.walletId.value = walletId;
    c.chainType.value = chainType;
    if (c.walletAddress == nullptr) {c.walletAddress = allocateZero<clib.CAddress>(sizeOf<clib.CAddress>());}
    walletAddress.toC(c.walletAddress);

  }

  @override
  toDart(Pointer<clib.CChainShared> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CChainShared c) {
    walletId = c.walletId.value;
    chainType = c.chainType.value;
    walletAddress = new Address();
    walletAddress.toDart(c.walletAddress);
  }
}

class TokenShared implements DC<clib.CTokenShared>{
   name = 0;
   symbol = 0;
   logoUrl = 0;
   logoBytes = 0;
   projectName = 0;
   projectHome = 0;
   projectNote = 0;

  static freeInstance(clib.CTokenShared instance) {
    if (instance.name != nullptr) {ffi.calloc.free(instance.name);}
    instance.name = nullptr;
    if (instance.symbol != nullptr) {ffi.calloc.free(instance.symbol);}
    instance.symbol = nullptr;
    if (instance.logoUrl != nullptr) {ffi.calloc.free(instance.logoUrl);}
    instance.logoUrl = nullptr;
    if (instance.logoBytes != nullptr) {ffi.calloc.free(instance.logoBytes);}
    instance.logoBytes = nullptr;
    if (instance.projectName != nullptr) {ffi.calloc.free(instance.projectName);}
    instance.projectName = nullptr;
    if (instance.projectHome != nullptr) {ffi.calloc.free(instance.projectHome);}
    instance.projectHome = nullptr;
    if (instance.projectNote != nullptr) {ffi.calloc.free(instance.projectNote);}
    instance.projectNote = nullptr;

  }
    
  static free(Pointer<clib.CTokenShared> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static TokenShared fromC(Pointer<clib.CTokenShared> ptr) {
    var d = new TokenShared();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CTokenShared> toCPtr() {
    var ptr = allocateZero<clib.CTokenShared>(sizeOf<clib.CTokenShared>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CTokenShared> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CTokenShared c) {
    c.name.value = name;
    c.symbol.value = symbol;
    c.logoUrl.value = logoUrl;
    c.logoBytes.value = logoBytes;
    c.projectName.value = projectName;
    c.projectHome.value = projectHome;
    c.projectNote.value = projectNote;

  }

  @override
  toDart(Pointer<clib.CTokenShared> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CTokenShared c) {
    name = c.name.value;
    symbol = c.symbol.value;
    logoUrl = c.logoUrl.value;
    logoBytes = c.logoBytes.value;
    projectName = c.projectName.value;
    projectHome = c.projectHome.value;
    projectNote = c.projectNote.value;
  }
}

class EthChainTokenShared implements DC<clib.CEthChainTokenShared>{
  TokenShared tokenShared = new TokenShared();
   tokenType = 0;
  int gasLimit = 0;
   gasPrice = 0;
  int decimal = 0;

  static freeInstance(clib.CEthChainTokenShared instance) {
    TokenShared.free(instance.tokenShared);
    instance.tokenShared = nullptr;
    if (instance.tokenType != nullptr) {ffi.calloc.free(instance.tokenType);}
    instance.tokenType = nullptr;
    if (instance.gasPrice != nullptr) {ffi.calloc.free(instance.gasPrice);}
    instance.gasPrice = nullptr;

  }
    
  static free(Pointer<clib.CEthChainTokenShared> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static EthChainTokenShared fromC(Pointer<clib.CEthChainTokenShared> ptr) {
    var d = new EthChainTokenShared();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEthChainTokenShared> toCPtr() {
    var ptr = allocateZero<clib.CEthChainTokenShared>(sizeOf<clib.CEthChainTokenShared>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEthChainTokenShared> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CEthChainTokenShared c) {
    if (c.tokenShared == nullptr) {c.tokenShared = allocateZero<clib.CTokenShared>(sizeOf<clib.CTokenShared>());}
    tokenShared.toC(c.tokenShared);
    c.tokenType.value = tokenType;
    c.gasLimit = gasLimit;
    c.gasPrice.value = gasPrice;
    c.decimal = decimal;

  }

  @override
  toDart(Pointer<clib.CEthChainTokenShared> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CEthChainTokenShared c) {
    tokenShared = new TokenShared();
    tokenShared.toDart(c.tokenShared);
    tokenType = c.tokenType.value;
    gasLimit = c.gasLimit;
    gasPrice = c.gasPrice.value;
    decimal = c.decimal;
  }
}

class EthChainToken implements DC<clib.CEthChainToken>{
   chainTokenSharedId = 0;
  int show1 = 0;
   contractAddress = 0;
  EthChainTokenShared ethChainTokenShared = new EthChainTokenShared();

  static freeInstance(clib.CEthChainToken instance) {
    if (instance.chainTokenSharedId != nullptr) {ffi.calloc.free(instance.chainTokenSharedId);}
    instance.chainTokenSharedId = nullptr;
    if (instance.contractAddress != nullptr) {ffi.calloc.free(instance.contractAddress);}
    instance.contractAddress = nullptr;
    EthChainTokenShared.free(instance.ethChainTokenShared);
    instance.ethChainTokenShared = nullptr;

  }
    
  static free(Pointer<clib.CEthChainToken> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static EthChainToken fromC(Pointer<clib.CEthChainToken> ptr) {
    var d = new EthChainToken();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEthChainToken> toCPtr() {
    var ptr = allocateZero<clib.CEthChainToken>(sizeOf<clib.CEthChainToken>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEthChainToken> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CEthChainToken c) {
    c.chainTokenSharedId.value = chainTokenSharedId;
    c.show1 = show1;
    c.contractAddress.value = contractAddress;
    if (c.ethChainTokenShared == nullptr) {c.ethChainTokenShared = allocateZero<clib.CEthChainTokenShared>(sizeOf<clib.CEthChainTokenShared>());}
    ethChainTokenShared.toC(c.ethChainTokenShared);

  }

  @override
  toDart(Pointer<clib.CEthChainToken> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CEthChainToken c) {
    chainTokenSharedId = c.chainTokenSharedId.value;
    show1 = c.show1;
    contractAddress = c.contractAddress.value;
    ethChainTokenShared = new EthChainTokenShared();
    ethChainTokenShared.toDart(c.ethChainTokenShared);
  }
}

class ArrayCEthChainToken implements DC<clib.CArrayCEthChainToken>{
  List<EthChainToken> data = <EthChainToken>[];
  
  static free(Pointer<clib.CArrayCEthChainToken> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }
  
  static freeInstance(clib.CArrayCEthChainToken instance) {
    EthChainToken.free(instance.ptr);
    instance.ptr = nullptr;
  }
  
  static ArrayCEthChainToken fromC(Pointer<clib.CArrayCEthChainToken> ptr) {
    var d = new ArrayCEthChainToken();
    if (ptr == nullptr) {
      return d;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCEthChainToken> toCPtr() {
    var c = allocateZero<clib.CArrayCEthChainToken>(sizeOf<clib.CArrayCEthChainToken>());
    toC(c);
    return c;
  }
  
  @override
  toC(Pointer<clib.CArrayCEthChainToken> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CArrayCEthChainToken c) {
    if (c.ptr != nullptr) {
      EthChainToken.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CEthChainToken>(sizeOf<clib.CEthChainToken>(),count : data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length;i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCEthChainToken> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }
  @override
  toDartInstance(clib.CArrayCEthChainToken c) {
    data =  <EthChainToken>[];
    for (var i = 0; i < c.len;i++) {
      data.add(new EthChainToken());      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}


class EthChain implements DC<clib.CEthChain>{
  ChainShared chainShared = new ChainShared();
  ArrayCEthChainToken tokens = new ArrayCEthChainToken();

  static freeInstance(clib.CEthChain instance) {
    ChainShared.free(instance.chainShared);
    instance.chainShared = nullptr;
    ArrayCEthChainToken.free(instance.tokens);
    instance.tokens = nullptr;

  }
    
  static free(Pointer<clib.CEthChain> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static EthChain fromC(Pointer<clib.CEthChain> ptr) {
    var d = new EthChain();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEthChain> toCPtr() {
    var ptr = allocateZero<clib.CEthChain>(sizeOf<clib.CEthChain>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEthChain> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CEthChain c) {
    if (c.chainShared == nullptr) {c.chainShared = allocateZero<clib.CChainShared>(sizeOf<clib.CChainShared>());}
    chainShared.toC(c.chainShared);
    if (c.tokens == nullptr) {c.tokens = allocateZero<clib.CArrayCEthChainToken>(sizeOf<clib.CArrayCEthChainToken>());}
    tokens.toC(c.tokens);

  }

  @override
  toDart(Pointer<clib.CEthChain> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CEthChain c) {
    chainShared = new ChainShared();
    chainShared.toDart(c.chainShared);
    tokens = new ArrayCEthChainToken();
    tokens.toDart(c.tokens);
  }
}

class EeeChainTokenShared implements DC<clib.CEeeChainTokenShared>{
  TokenShared tokenShared = new TokenShared();
   tokenType = 0;
  int gasLimit = 0;
   gasPrice = 0;
  int decimal = 0;

  static freeInstance(clib.CEeeChainTokenShared instance) {
    TokenShared.free(instance.tokenShared);
    instance.tokenShared = nullptr;
    if (instance.tokenType != nullptr) {ffi.calloc.free(instance.tokenType);}
    instance.tokenType = nullptr;
    if (instance.gasPrice != nullptr) {ffi.calloc.free(instance.gasPrice);}
    instance.gasPrice = nullptr;

  }
    
  static free(Pointer<clib.CEeeChainTokenShared> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static EeeChainTokenShared fromC(Pointer<clib.CEeeChainTokenShared> ptr) {
    var d = new EeeChainTokenShared();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEeeChainTokenShared> toCPtr() {
    var ptr = allocateZero<clib.CEeeChainTokenShared>(sizeOf<clib.CEeeChainTokenShared>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEeeChainTokenShared> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CEeeChainTokenShared c) {
    if (c.tokenShared == nullptr) {c.tokenShared = allocateZero<clib.CTokenShared>(sizeOf<clib.CTokenShared>());}
    tokenShared.toC(c.tokenShared);
    c.tokenType.value = tokenType;
    c.gasLimit = gasLimit;
    c.gasPrice.value = gasPrice;
    c.decimal = decimal;

  }

  @override
  toDart(Pointer<clib.CEeeChainTokenShared> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CEeeChainTokenShared c) {
    tokenShared = new TokenShared();
    tokenShared.toDart(c.tokenShared);
    tokenType = c.tokenType.value;
    gasLimit = c.gasLimit;
    gasPrice = c.gasPrice.value;
    decimal = c.decimal;
  }
}

class EeeChainToken implements DC<clib.CEeeChainToken>{
  int show1 = 0;
   chainTokenSharedId = 0;
  EeeChainTokenShared eeeChainTokenShared = new EeeChainTokenShared();

  static freeInstance(clib.CEeeChainToken instance) {
    if (instance.chainTokenSharedId != nullptr) {ffi.calloc.free(instance.chainTokenSharedId);}
    instance.chainTokenSharedId = nullptr;
    EeeChainTokenShared.free(instance.eeeChainTokenShared);
    instance.eeeChainTokenShared = nullptr;

  }
    
  static free(Pointer<clib.CEeeChainToken> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static EeeChainToken fromC(Pointer<clib.CEeeChainToken> ptr) {
    var d = new EeeChainToken();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEeeChainToken> toCPtr() {
    var ptr = allocateZero<clib.CEeeChainToken>(sizeOf<clib.CEeeChainToken>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEeeChainToken> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CEeeChainToken c) {
    c.show1 = show1;
    c.chainTokenSharedId.value = chainTokenSharedId;
    if (c.eeeChainTokenShared == nullptr) {c.eeeChainTokenShared = allocateZero<clib.CEeeChainTokenShared>(sizeOf<clib.CEeeChainTokenShared>());}
    eeeChainTokenShared.toC(c.eeeChainTokenShared);

  }

  @override
  toDart(Pointer<clib.CEeeChainToken> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CEeeChainToken c) {
    show1 = c.show1;
    chainTokenSharedId = c.chainTokenSharedId.value;
    eeeChainTokenShared = new EeeChainTokenShared();
    eeeChainTokenShared.toDart(c.eeeChainTokenShared);
  }
}

class ArrayCEeeChainToken implements DC<clib.CArrayCEeeChainToken>{
  List<EeeChainToken> data = <EeeChainToken>[];
  
  static free(Pointer<clib.CArrayCEeeChainToken> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }
  
  static freeInstance(clib.CArrayCEeeChainToken instance) {
    EeeChainToken.free(instance.ptr);
    instance.ptr = nullptr;
  }
  
  static ArrayCEeeChainToken fromC(Pointer<clib.CArrayCEeeChainToken> ptr) {
    var d = new ArrayCEeeChainToken();
    if (ptr == nullptr) {
      return d;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCEeeChainToken> toCPtr() {
    var c = allocateZero<clib.CArrayCEeeChainToken>(sizeOf<clib.CArrayCEeeChainToken>());
    toC(c);
    return c;
  }
  
  @override
  toC(Pointer<clib.CArrayCEeeChainToken> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CArrayCEeeChainToken c) {
    if (c.ptr != nullptr) {
      EeeChainToken.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CEeeChainToken>(sizeOf<clib.CEeeChainToken>(),count : data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length;i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCEeeChainToken> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }
  @override
  toDartInstance(clib.CArrayCEeeChainToken c) {
    data =  <EeeChainToken>[];
    for (var i = 0; i < c.len;i++) {
      data.add(new EeeChainToken());      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}


class EeeChain implements DC<clib.CEeeChain>{
  ChainShared chainShared = new ChainShared();
  ArrayCEeeChainToken tokens = new ArrayCEeeChainToken();

  static freeInstance(clib.CEeeChain instance) {
    ChainShared.free(instance.chainShared);
    instance.chainShared = nullptr;
    ArrayCEeeChainToken.free(instance.tokens);
    instance.tokens = nullptr;

  }
    
  static free(Pointer<clib.CEeeChain> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static EeeChain fromC(Pointer<clib.CEeeChain> ptr) {
    var d = new EeeChain();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEeeChain> toCPtr() {
    var ptr = allocateZero<clib.CEeeChain>(sizeOf<clib.CEeeChain>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEeeChain> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CEeeChain c) {
    if (c.chainShared == nullptr) {c.chainShared = allocateZero<clib.CChainShared>(sizeOf<clib.CChainShared>());}
    chainShared.toC(c.chainShared);
    if (c.tokens == nullptr) {c.tokens = allocateZero<clib.CArrayCEeeChainToken>(sizeOf<clib.CArrayCEeeChainToken>());}
    tokens.toC(c.tokens);

  }

  @override
  toDart(Pointer<clib.CEeeChain> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CEeeChain c) {
    chainShared = new ChainShared();
    chainShared.toDart(c.chainShared);
    tokens = new ArrayCEeeChainToken();
    tokens.toDart(c.tokens);
  }
}

class BtcChainTokenShared implements DC<clib.CBtcChainTokenShared>{
  TokenShared tokenShared = new TokenShared();
   tokenType = 0;
  int fee_per_byte = 0;
  int decimal = 0;

  static freeInstance(clib.CBtcChainTokenShared instance) {
    TokenShared.free(instance.tokenShared);
    instance.tokenShared = nullptr;
    if (instance.tokenType != nullptr) {ffi.calloc.free(instance.tokenType);}
    instance.tokenType = nullptr;

  }
    
  static free(Pointer<clib.CBtcChainTokenShared> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static BtcChainTokenShared fromC(Pointer<clib.CBtcChainTokenShared> ptr) {
    var d = new BtcChainTokenShared();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CBtcChainTokenShared> toCPtr() {
    var ptr = allocateZero<clib.CBtcChainTokenShared>(sizeOf<clib.CBtcChainTokenShared>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CBtcChainTokenShared> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CBtcChainTokenShared c) {
    if (c.tokenShared == nullptr) {c.tokenShared = allocateZero<clib.CTokenShared>(sizeOf<clib.CTokenShared>());}
    tokenShared.toC(c.tokenShared);
    c.tokenType.value = tokenType;
    c.fee_per_byte = fee_per_byte;
    c.decimal = decimal;

  }

  @override
  toDart(Pointer<clib.CBtcChainTokenShared> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CBtcChainTokenShared c) {
    tokenShared = new TokenShared();
    tokenShared.toDart(c.tokenShared);
    tokenType = c.tokenType.value;
    fee_per_byte = c.fee_per_byte;
    decimal = c.decimal;
  }
}

class BtcChainToken implements DC<clib.CBtcChainToken>{
  int show1 = 0;
   chainTokenSharedId = 0;
  BtcChainTokenShared btcChainTokenShared = new BtcChainTokenShared();

  static freeInstance(clib.CBtcChainToken instance) {
    if (instance.chainTokenSharedId != nullptr) {ffi.calloc.free(instance.chainTokenSharedId);}
    instance.chainTokenSharedId = nullptr;
    BtcChainTokenShared.free(instance.btcChainTokenShared);
    instance.btcChainTokenShared = nullptr;

  }
    
  static free(Pointer<clib.CBtcChainToken> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static BtcChainToken fromC(Pointer<clib.CBtcChainToken> ptr) {
    var d = new BtcChainToken();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CBtcChainToken> toCPtr() {
    var ptr = allocateZero<clib.CBtcChainToken>(sizeOf<clib.CBtcChainToken>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CBtcChainToken> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CBtcChainToken c) {
    c.show1 = show1;
    c.chainTokenSharedId.value = chainTokenSharedId;
    if (c.btcChainTokenShared == nullptr) {c.btcChainTokenShared = allocateZero<clib.CBtcChainTokenShared>(sizeOf<clib.CBtcChainTokenShared>());}
    btcChainTokenShared.toC(c.btcChainTokenShared);

  }

  @override
  toDart(Pointer<clib.CBtcChainToken> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CBtcChainToken c) {
    show1 = c.show1;
    chainTokenSharedId = c.chainTokenSharedId.value;
    btcChainTokenShared = new BtcChainTokenShared();
    btcChainTokenShared.toDart(c.btcChainTokenShared);
  }
}

class ArrayCBtcChainToken implements DC<clib.CArrayCBtcChainToken>{
  List<BtcChainToken> data = <BtcChainToken>[];
  
  static free(Pointer<clib.CArrayCBtcChainToken> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }
  
  static freeInstance(clib.CArrayCBtcChainToken instance) {
    BtcChainToken.free(instance.ptr);
    instance.ptr = nullptr;
  }
  
  static ArrayCBtcChainToken fromC(Pointer<clib.CArrayCBtcChainToken> ptr) {
    var d = new ArrayCBtcChainToken();
    if (ptr == nullptr) {
      return d;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCBtcChainToken> toCPtr() {
    var c = allocateZero<clib.CArrayCBtcChainToken>(sizeOf<clib.CArrayCBtcChainToken>());
    toC(c);
    return c;
  }
  
  @override
  toC(Pointer<clib.CArrayCBtcChainToken> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CArrayCBtcChainToken c) {
    if (c.ptr != nullptr) {
      BtcChainToken.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CBtcChainToken>(sizeOf<clib.CBtcChainToken>(),count : data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length;i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCBtcChainToken> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }
  @override
  toDartInstance(clib.CArrayCBtcChainToken c) {
    data =  <BtcChainToken>[];
    for (var i = 0; i < c.len;i++) {
      data.add(new BtcChainToken());      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}


class BtcChain implements DC<clib.CBtcChain>{
  ChainShared chainShared = new ChainShared();
  ArrayCBtcChainToken tokens = new ArrayCBtcChainToken();

  static freeInstance(clib.CBtcChain instance) {
    ChainShared.free(instance.chainShared);
    instance.chainShared = nullptr;
    ArrayCBtcChainToken.free(instance.tokens);
    instance.tokens = nullptr;

  }
    
  static free(Pointer<clib.CBtcChain> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static BtcChain fromC(Pointer<clib.CBtcChain> ptr) {
    var d = new BtcChain();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CBtcChain> toCPtr() {
    var ptr = allocateZero<clib.CBtcChain>(sizeOf<clib.CBtcChain>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CBtcChain> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CBtcChain c) {
    if (c.chainShared == nullptr) {c.chainShared = allocateZero<clib.CChainShared>(sizeOf<clib.CChainShared>());}
    chainShared.toC(c.chainShared);
    if (c.tokens == nullptr) {c.tokens = allocateZero<clib.CArrayCBtcChainToken>(sizeOf<clib.CArrayCBtcChainToken>());}
    tokens.toC(c.tokens);

  }

  @override
  toDart(Pointer<clib.CBtcChain> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CBtcChain c) {
    chainShared = new ChainShared();
    chainShared.toDart(c.chainShared);
    tokens = new ArrayCBtcChainToken();
    tokens.toDart(c.tokens);
  }
}

class Wallet implements DC<clib.CWallet>{
   id = 0;
   nextId = 0;
   name = 0;
   walletType = 0;
  EthChain ethChain = new EthChain();
  EeeChain eeeChain = new EeeChain();
  BtcChain btcChain = new BtcChain();

  static freeInstance(clib.CWallet instance) {
    if (instance.id != nullptr) {ffi.calloc.free(instance.id);}
    instance.id = nullptr;
    if (instance.nextId != nullptr) {ffi.calloc.free(instance.nextId);}
    instance.nextId = nullptr;
    if (instance.name != nullptr) {ffi.calloc.free(instance.name);}
    instance.name = nullptr;
    if (instance.walletType != nullptr) {ffi.calloc.free(instance.walletType);}
    instance.walletType = nullptr;
    EthChain.free(instance.ethChain);
    instance.ethChain = nullptr;
    EeeChain.free(instance.eeeChain);
    instance.eeeChain = nullptr;
    BtcChain.free(instance.btcChain);
    instance.btcChain = nullptr;

  }
    
  static free(Pointer<clib.CWallet> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static Wallet fromC(Pointer<clib.CWallet> ptr) {
    var d = new Wallet();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CWallet> toCPtr() {
    var ptr = allocateZero<clib.CWallet>(sizeOf<clib.CWallet>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CWallet> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CWallet c) {
    c.id.value = id;
    c.nextId.value = nextId;
    c.name.value = name;
    c.walletType.value = walletType;
    if (c.ethChain == nullptr) {c.ethChain = allocateZero<clib.CEthChain>(sizeOf<clib.CEthChain>());}
    ethChain.toC(c.ethChain);
    if (c.eeeChain == nullptr) {c.eeeChain = allocateZero<clib.CEeeChain>(sizeOf<clib.CEeeChain>());}
    eeeChain.toC(c.eeeChain);
    if (c.btcChain == nullptr) {c.btcChain = allocateZero<clib.CBtcChain>(sizeOf<clib.CBtcChain>());}
    btcChain.toC(c.btcChain);

  }

  @override
  toDart(Pointer<clib.CWallet> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CWallet c) {
    id = c.id.value;
    nextId = c.nextId.value;
    name = c.name.value;
    walletType = c.walletType.value;
    ethChain = new EthChain();
    ethChain.toDart(c.ethChain);
    eeeChain = new EeeChain();
    eeeChain.toDart(c.eeeChain);
    btcChain = new BtcChain();
    btcChain.toDart(c.btcChain);
  }
}

class ArrayCWallet implements DC<clib.CArrayCWallet>{
  List<Wallet> data = <Wallet>[];
  
  static free(Pointer<clib.CArrayCWallet> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }
  
  static freeInstance(clib.CArrayCWallet instance) {
    Wallet.free(instance.ptr);
    instance.ptr = nullptr;
  }
  
  static ArrayCWallet fromC(Pointer<clib.CArrayCWallet> ptr) {
    var d = new ArrayCWallet();
    if (ptr == nullptr) {
      return d;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCWallet> toCPtr() {
    var c = allocateZero<clib.CArrayCWallet>(sizeOf<clib.CArrayCWallet>());
    toC(c);
    return c;
  }
  
  @override
  toC(Pointer<clib.CArrayCWallet> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CArrayCWallet c) {
    if (c.ptr != nullptr) {
      Wallet.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CWallet>(sizeOf<clib.CWallet>(),count : data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length;i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCWallet> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }
  @override
  toDartInstance(clib.CArrayCWallet c) {
    data =  <Wallet>[];
    for (var i = 0; i < c.len;i++) {
      data.add(new Wallet());      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}


class DbName implements DC<clib.CDbName>{
   path = 0;
   prefix = 0;
   cashboxWallets = 0;
   cashboxMnemonic = 0;
   walletMainnet = 0;
   walletPrivate = 0;
   walletTestnet = 0;
   walletTestnetPrivate = 0;

  static freeInstance(clib.CDbName instance) {
    if (instance.path != nullptr) {ffi.calloc.free(instance.path);}
    instance.path = nullptr;
    if (instance.prefix != nullptr) {ffi.calloc.free(instance.prefix);}
    instance.prefix = nullptr;
    if (instance.cashboxWallets != nullptr) {ffi.calloc.free(instance.cashboxWallets);}
    instance.cashboxWallets = nullptr;
    if (instance.cashboxMnemonic != nullptr) {ffi.calloc.free(instance.cashboxMnemonic);}
    instance.cashboxMnemonic = nullptr;
    if (instance.walletMainnet != nullptr) {ffi.calloc.free(instance.walletMainnet);}
    instance.walletMainnet = nullptr;
    if (instance.walletPrivate != nullptr) {ffi.calloc.free(instance.walletPrivate);}
    instance.walletPrivate = nullptr;
    if (instance.walletTestnet != nullptr) {ffi.calloc.free(instance.walletTestnet);}
    instance.walletTestnet = nullptr;
    if (instance.walletTestnetPrivate != nullptr) {ffi.calloc.free(instance.walletTestnetPrivate);}
    instance.walletTestnetPrivate = nullptr;

  }
    
  static free(Pointer<clib.CDbName> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static DbName fromC(Pointer<clib.CDbName> ptr) {
    var d = new DbName();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CDbName> toCPtr() {
    var ptr = allocateZero<clib.CDbName>(sizeOf<clib.CDbName>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CDbName> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CDbName c) {
    c.path.value = path;
    c.prefix.value = prefix;
    c.cashboxWallets.value = cashboxWallets;
    c.cashboxMnemonic.value = cashboxMnemonic;
    c.walletMainnet.value = walletMainnet;
    c.walletPrivate.value = walletPrivate;
    c.walletTestnet.value = walletTestnet;
    c.walletTestnetPrivate.value = walletTestnetPrivate;

  }

  @override
  toDart(Pointer<clib.CDbName> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CDbName c) {
    path = c.path.value;
    prefix = c.prefix.value;
    cashboxWallets = c.cashboxWallets.value;
    cashboxMnemonic = c.cashboxMnemonic.value;
    walletMainnet = c.walletMainnet.value;
    walletPrivate = c.walletPrivate.value;
    walletTestnet = c.walletTestnet.value;
    walletTestnetPrivate = c.walletTestnetPrivate.value;
  }
}

class ArrayI64 implements DC<clib.CArrayI64>{
  List<int> data = <int>[];
  
  static free(Pointer<clib.CArrayI64> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }
  
  static freeInstance(clib.CArrayI64 instance) {
    instance.ptr.free();
    instance.ptr = nullptr;
  }
  
  static ArrayI64 fromC(Pointer<clib.CArrayI64> ptr) {
    var d = new ArrayI64();
    if (ptr == nullptr) {
      return d;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayI64> toCPtr() {
    var c = allocateZero<clib.CArrayI64>(sizeOf<clib.CArrayI64>());
    toC(c);
    return c;
  }
  
  @override
  toC(Pointer<clib.CArrayI64> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CArrayI64 c) {
    if (c.ptr != nullptr) {
      c.ptr.free();
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<Int64>(sizeOf<Int64>(),count : data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length;i++) {
      c.ptr.elementAt(i).value = data[i];
    }
  }

  @override
  toDart(Pointer<clib.CArrayI64> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }
  @override
  toDartInstance(clib.CArrayI64 c) {
    data =  <int>[];
    for (var i = 0; i < c.len;i++) {
      data.add(c.ptr.elementAt(i).value);
    }
  }
}


class AccountInfoSyncProg implements DC<clib.CAccountInfoSyncProg>{
   account = 0;
   blockNo = 0;
   blockHash = 0;

  static freeInstance(clib.CAccountInfoSyncProg instance) {
    if (instance.account != nullptr) {ffi.calloc.free(instance.account);}
    instance.account = nullptr;
    if (instance.blockNo != nullptr) {ffi.calloc.free(instance.blockNo);}
    instance.blockNo = nullptr;
    if (instance.blockHash != nullptr) {ffi.calloc.free(instance.blockHash);}
    instance.blockHash = nullptr;

  }
    
  static free(Pointer<clib.CAccountInfoSyncProg> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static AccountInfoSyncProg fromC(Pointer<clib.CAccountInfoSyncProg> ptr) {
    var d = new AccountInfoSyncProg();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CAccountInfoSyncProg> toCPtr() {
    var ptr = allocateZero<clib.CAccountInfoSyncProg>(sizeOf<clib.CAccountInfoSyncProg>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CAccountInfoSyncProg> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CAccountInfoSyncProg c) {
    c.account.value = account;
    c.blockNo.value = blockNo;
    c.blockHash.value = blockHash;

  }

  @override
  toDart(Pointer<clib.CAccountInfoSyncProg> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CAccountInfoSyncProg c) {
    account = c.account.value;
    blockNo = c.blockNo.value;
    blockHash = c.blockHash.value;
  }
}

class AccountInfo implements DC<clib.CAccountInfo>{
  int nonce = 0;
  int refCount = 0;
   freeBalance = 0;
   reserved = 0;
   miscFrozen = 0;
   feeFrozen = 0;

  static freeInstance(clib.CAccountInfo instance) {
    if (instance.freeBalance != nullptr) {ffi.calloc.free(instance.freeBalance);}
    instance.freeBalance = nullptr;
    if (instance.reserved != nullptr) {ffi.calloc.free(instance.reserved);}
    instance.reserved = nullptr;
    if (instance.miscFrozen != nullptr) {ffi.calloc.free(instance.miscFrozen);}
    instance.miscFrozen = nullptr;
    if (instance.feeFrozen != nullptr) {ffi.calloc.free(instance.feeFrozen);}
    instance.feeFrozen = nullptr;

  }
    
  static free(Pointer<clib.CAccountInfo> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static AccountInfo fromC(Pointer<clib.CAccountInfo> ptr) {
    var d = new AccountInfo();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CAccountInfo> toCPtr() {
    var ptr = allocateZero<clib.CAccountInfo>(sizeOf<clib.CAccountInfo>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CAccountInfo> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CAccountInfo c) {
    c.nonce = nonce;
    c.refCount = refCount;
    c.freeBalance.value = freeBalance;
    c.reserved.value = reserved;
    c.miscFrozen.value = miscFrozen;
    c.feeFrozen.value = feeFrozen;

  }

  @override
  toDart(Pointer<clib.CAccountInfo> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CAccountInfo c) {
    nonce = c.nonce;
    refCount = c.refCount;
    freeBalance = c.freeBalance.value;
    reserved = c.reserved.value;
    miscFrozen = c.miscFrozen.value;
    feeFrozen = c.feeFrozen.value;
  }
}

class SubChainBasicInfo implements DC<clib.CSubChainBasicInfo>{
   genesisHash = 0;
   metadata = 0;
  int runtimeVersion = 0;
  int txVersion = 0;
  int ss58FormatPrefix = 0;
  int tokenDecimals = 0;
   tokenSymbol = 0;
  int isDefault = 0;

  static freeInstance(clib.CSubChainBasicInfo instance) {
    if (instance.genesisHash != nullptr) {ffi.calloc.free(instance.genesisHash);}
    instance.genesisHash = nullptr;
    if (instance.metadata != nullptr) {ffi.calloc.free(instance.metadata);}
    instance.metadata = nullptr;
    if (instance.tokenSymbol != nullptr) {ffi.calloc.free(instance.tokenSymbol);}
    instance.tokenSymbol = nullptr;

  }
    
  static free(Pointer<clib.CSubChainBasicInfo> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static SubChainBasicInfo fromC(Pointer<clib.CSubChainBasicInfo> ptr) {
    var d = new SubChainBasicInfo();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CSubChainBasicInfo> toCPtr() {
    var ptr = allocateZero<clib.CSubChainBasicInfo>(sizeOf<clib.CSubChainBasicInfo>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CSubChainBasicInfo> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CSubChainBasicInfo c) {
    c.genesisHash.value = genesisHash;
    c.metadata.value = metadata;
    c.runtimeVersion = runtimeVersion;
    c.txVersion = txVersion;
    c.ss58FormatPrefix = ss58FormatPrefix;
    c.tokenDecimals = tokenDecimals;
    c.tokenSymbol.value = tokenSymbol;
    c.isDefault = isDefault;

  }

  @override
  toDart(Pointer<clib.CSubChainBasicInfo> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CSubChainBasicInfo c) {
    genesisHash = c.genesisHash.value;
    metadata = c.metadata.value;
    runtimeVersion = c.runtimeVersion;
    txVersion = c.txVersion;
    ss58FormatPrefix = c.ss58FormatPrefix;
    tokenDecimals = c.tokenDecimals;
    tokenSymbol = c.tokenSymbol.value;
    isDefault = c.isDefault;
  }
}

class ArrayCChar implements DC<clib.CArrayCChar>{
  List<> data = <>[];
  
  static free(Pointer<clib.CArrayCChar> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }
  
  static freeInstance(clib.CArrayCChar instance) {
    instance.ptr.free();
    instance.ptr = nullptr;
  }
  
  static ArrayCChar fromC(Pointer<clib.CArrayCChar> ptr) {
    var d = new ArrayCChar();
    if (ptr == nullptr) {
      return d;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCChar> toCPtr() {
    var c = allocateZero<clib.CArrayCChar>(sizeOf<clib.CArrayCChar>());
    toC(c);
    return c;
  }
  
  @override
  toC(Pointer<clib.CArrayCChar> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CArrayCChar c) {
    if (c.ptr != nullptr) {
      c.ptr.free();
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<Pointer>(sizeOf<Pointer>(),count : data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length;i++) {
      c.ptr.elementAt(i).value = data[i];
    }
  }

  @override
  toDart(Pointer<clib.CArrayCChar> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }
  @override
  toDartInstance(clib.CArrayCChar c) {
    data =  <>[];
    for (var i = 0; i < c.len;i++) {
      data.add(c.ptr.elementAt(i).value);
    }
  }
}


class ChainVersion implements DC<clib.CChainVersion>{
   genesisHash = 0;
  int runtimeVersion = 0;
  int txVersion = 0;

  static freeInstance(clib.CChainVersion instance) {
    if (instance.genesisHash != nullptr) {ffi.calloc.free(instance.genesisHash);}
    instance.genesisHash = nullptr;

  }
    
  static free(Pointer<clib.CChainVersion> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static ChainVersion fromC(Pointer<clib.CChainVersion> ptr) {
    var d = new ChainVersion();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CChainVersion> toCPtr() {
    var ptr = allocateZero<clib.CChainVersion>(sizeOf<clib.CChainVersion>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CChainVersion> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CChainVersion c) {
    c.genesisHash.value = genesisHash;
    c.runtimeVersion = runtimeVersion;
    c.txVersion = txVersion;

  }

  @override
  toDart(Pointer<clib.CChainVersion> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CChainVersion c) {
    genesisHash = c.genesisHash.value;
    runtimeVersion = c.runtimeVersion;
    txVersion = c.txVersion;
  }
}

class ExtrinsicContext implements DC<clib.CExtrinsicContext>{
  ChainVersion chainVersion = new ChainVersion();
   account = 0;
   blockHash = 0;
   blockNumber = 0;
   event = 0;
  ArrayCChar extrinsics = new ArrayCChar();

  static freeInstance(clib.CExtrinsicContext instance) {
    ChainVersion.free(instance.chainVersion);
    instance.chainVersion = nullptr;
    if (instance.account != nullptr) {ffi.calloc.free(instance.account);}
    instance.account = nullptr;
    if (instance.blockHash != nullptr) {ffi.calloc.free(instance.blockHash);}
    instance.blockHash = nullptr;
    if (instance.blockNumber != nullptr) {ffi.calloc.free(instance.blockNumber);}
    instance.blockNumber = nullptr;
    if (instance.event != nullptr) {ffi.calloc.free(instance.event);}
    instance.event = nullptr;
    ArrayCChar.free(instance.extrinsics);
    instance.extrinsics = nullptr;

  }
    
  static free(Pointer<clib.CExtrinsicContext> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static ExtrinsicContext fromC(Pointer<clib.CExtrinsicContext> ptr) {
    var d = new ExtrinsicContext();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CExtrinsicContext> toCPtr() {
    var ptr = allocateZero<clib.CExtrinsicContext>(sizeOf<clib.CExtrinsicContext>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CExtrinsicContext> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CExtrinsicContext c) {
    if (c.chainVersion == nullptr) {c.chainVersion = allocateZero<clib.CChainVersion>(sizeOf<clib.CChainVersion>());}
    chainVersion.toC(c.chainVersion);
    c.account.value = account;
    c.blockHash.value = blockHash;
    c.blockNumber.value = blockNumber;
    c.event.value = event;
    if (c.extrinsics == nullptr) {c.extrinsics = allocateZero<clib.CArrayCChar>(sizeOf<clib.CArrayCChar>());}
    extrinsics.toC(c.extrinsics);

  }

  @override
  toDart(Pointer<clib.CExtrinsicContext> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CExtrinsicContext c) {
    chainVersion = new ChainVersion();
    chainVersion.toDart(c.chainVersion);
    account = c.account.value;
    blockHash = c.blockHash.value;
    blockNumber = c.blockNumber.value;
    event = c.event.value;
    extrinsics = new ArrayCChar();
    extrinsics.toDart(c.extrinsics);
  }
}

class ArrayCExtrinsicContext implements DC<clib.CArrayCExtrinsicContext>{
  List<ExtrinsicContext> data = <ExtrinsicContext>[];
  
  static free(Pointer<clib.CArrayCExtrinsicContext> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }
  
  static freeInstance(clib.CArrayCExtrinsicContext instance) {
    ExtrinsicContext.free(instance.ptr);
    instance.ptr = nullptr;
  }
  
  static ArrayCExtrinsicContext fromC(Pointer<clib.CArrayCExtrinsicContext> ptr) {
    var d = new ArrayCExtrinsicContext();
    if (ptr == nullptr) {
      return d;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCExtrinsicContext> toCPtr() {
    var c = allocateZero<clib.CArrayCExtrinsicContext>(sizeOf<clib.CArrayCExtrinsicContext>());
    toC(c);
    return c;
  }
  
  @override
  toC(Pointer<clib.CArrayCExtrinsicContext> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CArrayCExtrinsicContext c) {
    if (c.ptr != nullptr) {
      ExtrinsicContext.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CExtrinsicContext>(sizeOf<clib.CExtrinsicContext>(),count : data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length;i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCExtrinsicContext> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }
  @override
  toDartInstance(clib.CArrayCExtrinsicContext c) {
    data =  <ExtrinsicContext>[];
    for (var i = 0; i < c.len;i++) {
      data.add(new ExtrinsicContext());      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}


class TokenAddress implements DC<clib.CTokenAddress>{
   walletId = 0;
   chainType = 0;
   tokenId = 0;
   addressId = 0;
   balance = 0;

  static freeInstance(clib.CTokenAddress instance) {
    if (instance.walletId != nullptr) {ffi.calloc.free(instance.walletId);}
    instance.walletId = nullptr;
    if (instance.chainType != nullptr) {ffi.calloc.free(instance.chainType);}
    instance.chainType = nullptr;
    if (instance.tokenId != nullptr) {ffi.calloc.free(instance.tokenId);}
    instance.tokenId = nullptr;
    if (instance.addressId != nullptr) {ffi.calloc.free(instance.addressId);}
    instance.addressId = nullptr;
    if (instance.balance != nullptr) {ffi.calloc.free(instance.balance);}
    instance.balance = nullptr;

  }
    
  static free(Pointer<clib.CTokenAddress> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static TokenAddress fromC(Pointer<clib.CTokenAddress> ptr) {
    var d = new TokenAddress();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CTokenAddress> toCPtr() {
    var ptr = allocateZero<clib.CTokenAddress>(sizeOf<clib.CTokenAddress>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CTokenAddress> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CTokenAddress c) {
    c.walletId.value = walletId;
    c.chainType.value = chainType;
    c.tokenId.value = tokenId;
    c.addressId.value = addressId;
    c.balance.value = balance;

  }

  @override
  toDart(Pointer<clib.CTokenAddress> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CTokenAddress c) {
    walletId = c.walletId.value;
    chainType = c.chainType.value;
    tokenId = c.tokenId.value;
    addressId = c.addressId.value;
    balance = c.balance.value;
  }
}

class ArrayCTokenAddress implements DC<clib.CArrayCTokenAddress>{
  List<TokenAddress> data = <TokenAddress>[];
  
  static free(Pointer<clib.CArrayCTokenAddress> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }
  
  static freeInstance(clib.CArrayCTokenAddress instance) {
    TokenAddress.free(instance.ptr);
    instance.ptr = nullptr;
  }
  
  static ArrayCTokenAddress fromC(Pointer<clib.CArrayCTokenAddress> ptr) {
    var d = new ArrayCTokenAddress();
    if (ptr == nullptr) {
      return d;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCTokenAddress> toCPtr() {
    var c = allocateZero<clib.CArrayCTokenAddress>(sizeOf<clib.CArrayCTokenAddress>());
    toC(c);
    return c;
  }
  
  @override
  toC(Pointer<clib.CArrayCTokenAddress> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CArrayCTokenAddress c) {
    if (c.ptr != nullptr) {
      TokenAddress.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CTokenAddress>(sizeOf<clib.CTokenAddress>(),count : data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length;i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCTokenAddress> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }
  @override
  toDartInstance(clib.CArrayCTokenAddress c) {
    data =  <TokenAddress>[];
    for (var i = 0; i < c.len;i++) {
      data.add(new TokenAddress());      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}


class EthChainTokenAuth implements DC<clib.CEthChainTokenAuth>{
   chainTokenSharedId = 0;
   netType = 0;
  int position = 0;
   contractAddress = 0;
  EthChainTokenShared ethChainTokenShared = new EthChainTokenShared();

  static freeInstance(clib.CEthChainTokenAuth instance) {
    if (instance.chainTokenSharedId != nullptr) {ffi.calloc.free(instance.chainTokenSharedId);}
    instance.chainTokenSharedId = nullptr;
    if (instance.netType != nullptr) {ffi.calloc.free(instance.netType);}
    instance.netType = nullptr;
    if (instance.contractAddress != nullptr) {ffi.calloc.free(instance.contractAddress);}
    instance.contractAddress = nullptr;
    EthChainTokenShared.free(instance.ethChainTokenShared);
    instance.ethChainTokenShared = nullptr;

  }
    
  static free(Pointer<clib.CEthChainTokenAuth> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static EthChainTokenAuth fromC(Pointer<clib.CEthChainTokenAuth> ptr) {
    var d = new EthChainTokenAuth();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEthChainTokenAuth> toCPtr() {
    var ptr = allocateZero<clib.CEthChainTokenAuth>(sizeOf<clib.CEthChainTokenAuth>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEthChainTokenAuth> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CEthChainTokenAuth c) {
    c.chainTokenSharedId.value = chainTokenSharedId;
    c.netType.value = netType;
    c.position = position;
    c.contractAddress.value = contractAddress;
    if (c.ethChainTokenShared == nullptr) {c.ethChainTokenShared = allocateZero<clib.CEthChainTokenShared>(sizeOf<clib.CEthChainTokenShared>());}
    ethChainTokenShared.toC(c.ethChainTokenShared);

  }

  @override
  toDart(Pointer<clib.CEthChainTokenAuth> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CEthChainTokenAuth c) {
    chainTokenSharedId = c.chainTokenSharedId.value;
    netType = c.netType.value;
    position = c.position;
    contractAddress = c.contractAddress.value;
    ethChainTokenShared = new EthChainTokenShared();
    ethChainTokenShared.toDart(c.ethChainTokenShared);
  }
}

class ArrayCEthChainTokenAuth implements DC<clib.CArrayCEthChainTokenAuth>{
  List<EthChainTokenAuth> data = <EthChainTokenAuth>[];
  
  static free(Pointer<clib.CArrayCEthChainTokenAuth> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }
  
  static freeInstance(clib.CArrayCEthChainTokenAuth instance) {
    EthChainTokenAuth.free(instance.ptr);
    instance.ptr = nullptr;
  }
  
  static ArrayCEthChainTokenAuth fromC(Pointer<clib.CArrayCEthChainTokenAuth> ptr) {
    var d = new ArrayCEthChainTokenAuth();
    if (ptr == nullptr) {
      return d;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCEthChainTokenAuth> toCPtr() {
    var c = allocateZero<clib.CArrayCEthChainTokenAuth>(sizeOf<clib.CArrayCEthChainTokenAuth>());
    toC(c);
    return c;
  }
  
  @override
  toC(Pointer<clib.CArrayCEthChainTokenAuth> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CArrayCEthChainTokenAuth c) {
    if (c.ptr != nullptr) {
      EthChainTokenAuth.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CEthChainTokenAuth>(sizeOf<clib.CEthChainTokenAuth>(),count : data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length;i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCEthChainTokenAuth> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }
  @override
  toDartInstance(clib.CArrayCEthChainTokenAuth c) {
    data =  <EthChainTokenAuth>[];
    for (var i = 0; i < c.len;i++) {
      data.add(new EthChainTokenAuth());      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}


class EthChainTokenNonAuth implements DC<clib.CEthChainTokenNonAuth>{
   chainTokenSharedId = 0;
   netType = 0;
  int position = 0;
   contractAddress = 0;
  EthChainTokenShared ethChainTokenShared = new EthChainTokenShared();

  static freeInstance(clib.CEthChainTokenNonAuth instance) {
    if (instance.chainTokenSharedId != nullptr) {ffi.calloc.free(instance.chainTokenSharedId);}
    instance.chainTokenSharedId = nullptr;
    if (instance.netType != nullptr) {ffi.calloc.free(instance.netType);}
    instance.netType = nullptr;
    if (instance.contractAddress != nullptr) {ffi.calloc.free(instance.contractAddress);}
    instance.contractAddress = nullptr;
    EthChainTokenShared.free(instance.ethChainTokenShared);
    instance.ethChainTokenShared = nullptr;

  }
    
  static free(Pointer<clib.CEthChainTokenNonAuth> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static EthChainTokenNonAuth fromC(Pointer<clib.CEthChainTokenNonAuth> ptr) {
    var d = new EthChainTokenNonAuth();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEthChainTokenNonAuth> toCPtr() {
    var ptr = allocateZero<clib.CEthChainTokenNonAuth>(sizeOf<clib.CEthChainTokenNonAuth>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEthChainTokenNonAuth> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CEthChainTokenNonAuth c) {
    c.chainTokenSharedId.value = chainTokenSharedId;
    c.netType.value = netType;
    c.position = position;
    c.contractAddress.value = contractAddress;
    if (c.ethChainTokenShared == nullptr) {c.ethChainTokenShared = allocateZero<clib.CEthChainTokenShared>(sizeOf<clib.CEthChainTokenShared>());}
    ethChainTokenShared.toC(c.ethChainTokenShared);

  }

  @override
  toDart(Pointer<clib.CEthChainTokenNonAuth> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CEthChainTokenNonAuth c) {
    chainTokenSharedId = c.chainTokenSharedId.value;
    netType = c.netType.value;
    position = c.position;
    contractAddress = c.contractAddress.value;
    ethChainTokenShared = new EthChainTokenShared();
    ethChainTokenShared.toDart(c.ethChainTokenShared);
  }
}

class ArrayCEthChainTokenNonAuth implements DC<clib.CArrayCEthChainTokenNonAuth>{
  List<EthChainTokenNonAuth> data = <EthChainTokenNonAuth>[];
  
  static free(Pointer<clib.CArrayCEthChainTokenNonAuth> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }
  
  static freeInstance(clib.CArrayCEthChainTokenNonAuth instance) {
    EthChainTokenNonAuth.free(instance.ptr);
    instance.ptr = nullptr;
  }
  
  static ArrayCEthChainTokenNonAuth fromC(Pointer<clib.CArrayCEthChainTokenNonAuth> ptr) {
    var d = new ArrayCEthChainTokenNonAuth();
    if (ptr == nullptr) {
      return d;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCEthChainTokenNonAuth> toCPtr() {
    var c = allocateZero<clib.CArrayCEthChainTokenNonAuth>(sizeOf<clib.CArrayCEthChainTokenNonAuth>());
    toC(c);
    return c;
  }
  
  @override
  toC(Pointer<clib.CArrayCEthChainTokenNonAuth> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CArrayCEthChainTokenNonAuth c) {
    if (c.ptr != nullptr) {
      EthChainTokenNonAuth.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CEthChainTokenNonAuth>(sizeOf<clib.CEthChainTokenNonAuth>(),count : data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length;i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCEthChainTokenNonAuth> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }
  @override
  toDartInstance(clib.CArrayCEthChainTokenNonAuth c) {
    data =  <EthChainTokenNonAuth>[];
    for (var i = 0; i < c.len;i++) {
      data.add(new EthChainTokenNonAuth());      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}


class EthChainTokenDefault implements DC<clib.CEthChainTokenDefault>{
   chainTokenSharedId = 0;
   netType = 0;
  int position = 0;
   contractAddress = 0;
  EthChainTokenShared ethChainTokenShared = new EthChainTokenShared();

  static freeInstance(clib.CEthChainTokenDefault instance) {
    if (instance.chainTokenSharedId != nullptr) {ffi.calloc.free(instance.chainTokenSharedId);}
    instance.chainTokenSharedId = nullptr;
    if (instance.netType != nullptr) {ffi.calloc.free(instance.netType);}
    instance.netType = nullptr;
    if (instance.contractAddress != nullptr) {ffi.calloc.free(instance.contractAddress);}
    instance.contractAddress = nullptr;
    EthChainTokenShared.free(instance.ethChainTokenShared);
    instance.ethChainTokenShared = nullptr;

  }
    
  static free(Pointer<clib.CEthChainTokenDefault> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static EthChainTokenDefault fromC(Pointer<clib.CEthChainTokenDefault> ptr) {
    var d = new EthChainTokenDefault();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEthChainTokenDefault> toCPtr() {
    var ptr = allocateZero<clib.CEthChainTokenDefault>(sizeOf<clib.CEthChainTokenDefault>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEthChainTokenDefault> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CEthChainTokenDefault c) {
    c.chainTokenSharedId.value = chainTokenSharedId;
    c.netType.value = netType;
    c.position = position;
    c.contractAddress.value = contractAddress;
    if (c.ethChainTokenShared == nullptr) {c.ethChainTokenShared = allocateZero<clib.CEthChainTokenShared>(sizeOf<clib.CEthChainTokenShared>());}
    ethChainTokenShared.toC(c.ethChainTokenShared);

  }

  @override
  toDart(Pointer<clib.CEthChainTokenDefault> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CEthChainTokenDefault c) {
    chainTokenSharedId = c.chainTokenSharedId.value;
    netType = c.netType.value;
    position = c.position;
    contractAddress = c.contractAddress.value;
    ethChainTokenShared = new EthChainTokenShared();
    ethChainTokenShared.toDart(c.ethChainTokenShared);
  }
}

class ArrayCEthChainTokenDefault implements DC<clib.CArrayCEthChainTokenDefault>{
  List<EthChainTokenDefault> data = <EthChainTokenDefault>[];
  
  static free(Pointer<clib.CArrayCEthChainTokenDefault> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }
  
  static freeInstance(clib.CArrayCEthChainTokenDefault instance) {
    EthChainTokenDefault.free(instance.ptr);
    instance.ptr = nullptr;
  }
  
  static ArrayCEthChainTokenDefault fromC(Pointer<clib.CArrayCEthChainTokenDefault> ptr) {
    var d = new ArrayCEthChainTokenDefault();
    if (ptr == nullptr) {
      return d;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCEthChainTokenDefault> toCPtr() {
    var c = allocateZero<clib.CArrayCEthChainTokenDefault>(sizeOf<clib.CArrayCEthChainTokenDefault>());
    toC(c);
    return c;
  }
  
  @override
  toC(Pointer<clib.CArrayCEthChainTokenDefault> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CArrayCEthChainTokenDefault c) {
    if (c.ptr != nullptr) {
      EthChainTokenDefault.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CEthChainTokenDefault>(sizeOf<clib.CEthChainTokenDefault>(),count : data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length;i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCEthChainTokenDefault> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }
  @override
  toDartInstance(clib.CArrayCEthChainTokenDefault c) {
    data =  <EthChainTokenDefault>[];
    for (var i = 0; i < c.len;i++) {
      data.add(new EthChainTokenDefault());      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}


class EeeChainTokenDefault implements DC<clib.CEeeChainTokenDefault>{
   chainTokenSharedId = 0;
   netType = 0;
  int position = 0;
  EeeChainTokenShared eeeChainTokenShared = new EeeChainTokenShared();

  static freeInstance(clib.CEeeChainTokenDefault instance) {
    if (instance.chainTokenSharedId != nullptr) {ffi.calloc.free(instance.chainTokenSharedId);}
    instance.chainTokenSharedId = nullptr;
    if (instance.netType != nullptr) {ffi.calloc.free(instance.netType);}
    instance.netType = nullptr;
    EeeChainTokenShared.free(instance.eeeChainTokenShared);
    instance.eeeChainTokenShared = nullptr;

  }
    
  static free(Pointer<clib.CEeeChainTokenDefault> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static EeeChainTokenDefault fromC(Pointer<clib.CEeeChainTokenDefault> ptr) {
    var d = new EeeChainTokenDefault();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEeeChainTokenDefault> toCPtr() {
    var ptr = allocateZero<clib.CEeeChainTokenDefault>(sizeOf<clib.CEeeChainTokenDefault>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEeeChainTokenDefault> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CEeeChainTokenDefault c) {
    c.chainTokenSharedId.value = chainTokenSharedId;
    c.netType.value = netType;
    c.position = position;
    if (c.eeeChainTokenShared == nullptr) {c.eeeChainTokenShared = allocateZero<clib.CEeeChainTokenShared>(sizeOf<clib.CEeeChainTokenShared>());}
    eeeChainTokenShared.toC(c.eeeChainTokenShared);

  }

  @override
  toDart(Pointer<clib.CEeeChainTokenDefault> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CEeeChainTokenDefault c) {
    chainTokenSharedId = c.chainTokenSharedId.value;
    netType = c.netType.value;
    position = c.position;
    eeeChainTokenShared = new EeeChainTokenShared();
    eeeChainTokenShared.toDart(c.eeeChainTokenShared);
  }
}

class ArrayCEeeChainTokenDefault implements DC<clib.CArrayCEeeChainTokenDefault>{
  List<EeeChainTokenDefault> data = <EeeChainTokenDefault>[];
  
  static free(Pointer<clib.CArrayCEeeChainTokenDefault> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }
  
  static freeInstance(clib.CArrayCEeeChainTokenDefault instance) {
    EeeChainTokenDefault.free(instance.ptr);
    instance.ptr = nullptr;
  }
  
  static ArrayCEeeChainTokenDefault fromC(Pointer<clib.CArrayCEeeChainTokenDefault> ptr) {
    var d = new ArrayCEeeChainTokenDefault();
    if (ptr == nullptr) {
      return d;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCEeeChainTokenDefault> toCPtr() {
    var c = allocateZero<clib.CArrayCEeeChainTokenDefault>(sizeOf<clib.CArrayCEeeChainTokenDefault>());
    toC(c);
    return c;
  }
  
  @override
  toC(Pointer<clib.CArrayCEeeChainTokenDefault> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CArrayCEeeChainTokenDefault c) {
    if (c.ptr != nullptr) {
      EeeChainTokenDefault.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CEeeChainTokenDefault>(sizeOf<clib.CEeeChainTokenDefault>(),count : data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length;i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCEeeChainTokenDefault> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }
  @override
  toDartInstance(clib.CArrayCEeeChainTokenDefault c) {
    data =  <EeeChainTokenDefault>[];
    for (var i = 0; i < c.len;i++) {
      data.add(new EeeChainTokenDefault());      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}


class BtcChainTokenDefault implements DC<clib.CBtcChainTokenDefault>{
   chainTokenSharedId = 0;
   netType = 0;
  int position = 0;
  BtcChainTokenShared btcChainTokenShared = new BtcChainTokenShared();

  static freeInstance(clib.CBtcChainTokenDefault instance) {
    if (instance.chainTokenSharedId != nullptr) {ffi.calloc.free(instance.chainTokenSharedId);}
    instance.chainTokenSharedId = nullptr;
    if (instance.netType != nullptr) {ffi.calloc.free(instance.netType);}
    instance.netType = nullptr;
    BtcChainTokenShared.free(instance.btcChainTokenShared);
    instance.btcChainTokenShared = nullptr;

  }
    
  static free(Pointer<clib.CBtcChainTokenDefault> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static BtcChainTokenDefault fromC(Pointer<clib.CBtcChainTokenDefault> ptr) {
    var d = new BtcChainTokenDefault();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CBtcChainTokenDefault> toCPtr() {
    var ptr = allocateZero<clib.CBtcChainTokenDefault>(sizeOf<clib.CBtcChainTokenDefault>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CBtcChainTokenDefault> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CBtcChainTokenDefault c) {
    c.chainTokenSharedId.value = chainTokenSharedId;
    c.netType.value = netType;
    c.position = position;
    if (c.btcChainTokenShared == nullptr) {c.btcChainTokenShared = allocateZero<clib.CBtcChainTokenShared>(sizeOf<clib.CBtcChainTokenShared>());}
    btcChainTokenShared.toC(c.btcChainTokenShared);

  }

  @override
  toDart(Pointer<clib.CBtcChainTokenDefault> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CBtcChainTokenDefault c) {
    chainTokenSharedId = c.chainTokenSharedId.value;
    netType = c.netType.value;
    position = c.position;
    btcChainTokenShared = new BtcChainTokenShared();
    btcChainTokenShared.toDart(c.btcChainTokenShared);
  }
}

class ArrayCBtcChainTokenDefault implements DC<clib.CArrayCBtcChainTokenDefault>{
  List<BtcChainTokenDefault> data = <BtcChainTokenDefault>[];
  
  static free(Pointer<clib.CArrayCBtcChainTokenDefault> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }
  
  static freeInstance(clib.CArrayCBtcChainTokenDefault instance) {
    BtcChainTokenDefault.free(instance.ptr);
    instance.ptr = nullptr;
  }
  
  static ArrayCBtcChainTokenDefault fromC(Pointer<clib.CArrayCBtcChainTokenDefault> ptr) {
    var d = new ArrayCBtcChainTokenDefault();
    if (ptr == nullptr) {
      return d;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCBtcChainTokenDefault> toCPtr() {
    var c = allocateZero<clib.CArrayCBtcChainTokenDefault>(sizeOf<clib.CArrayCBtcChainTokenDefault>());
    toC(c);
    return c;
  }
  
  @override
  toC(Pointer<clib.CArrayCBtcChainTokenDefault> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CArrayCBtcChainTokenDefault c) {
    if (c.ptr != nullptr) {
      BtcChainTokenDefault.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CBtcChainTokenDefault>(sizeOf<clib.CBtcChainTokenDefault>(),count : data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length;i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCBtcChainTokenDefault> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }
  @override
  toDartInstance(clib.CArrayCBtcChainTokenDefault c) {
    data =  <BtcChainTokenDefault>[];
    for (var i = 0; i < c.len;i++) {
      data.add(new BtcChainTokenDefault());      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}


class EeeChainTokenAuth implements DC<clib.CEeeChainTokenAuth>{
   chainTokenSharedId = 0;
   netType = 0;
  int position = 0;
  EeeChainTokenShared eeeChainTokenShared = new EeeChainTokenShared();

  static freeInstance(clib.CEeeChainTokenAuth instance) {
    if (instance.chainTokenSharedId != nullptr) {ffi.calloc.free(instance.chainTokenSharedId);}
    instance.chainTokenSharedId = nullptr;
    if (instance.netType != nullptr) {ffi.calloc.free(instance.netType);}
    instance.netType = nullptr;
    EeeChainTokenShared.free(instance.eeeChainTokenShared);
    instance.eeeChainTokenShared = nullptr;

  }
    
  static free(Pointer<clib.CEeeChainTokenAuth> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static EeeChainTokenAuth fromC(Pointer<clib.CEeeChainTokenAuth> ptr) {
    var d = new EeeChainTokenAuth();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEeeChainTokenAuth> toCPtr() {
    var ptr = allocateZero<clib.CEeeChainTokenAuth>(sizeOf<clib.CEeeChainTokenAuth>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEeeChainTokenAuth> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CEeeChainTokenAuth c) {
    c.chainTokenSharedId.value = chainTokenSharedId;
    c.netType.value = netType;
    c.position = position;
    if (c.eeeChainTokenShared == nullptr) {c.eeeChainTokenShared = allocateZero<clib.CEeeChainTokenShared>(sizeOf<clib.CEeeChainTokenShared>());}
    eeeChainTokenShared.toC(c.eeeChainTokenShared);

  }

  @override
  toDart(Pointer<clib.CEeeChainTokenAuth> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CEeeChainTokenAuth c) {
    chainTokenSharedId = c.chainTokenSharedId.value;
    netType = c.netType.value;
    position = c.position;
    eeeChainTokenShared = new EeeChainTokenShared();
    eeeChainTokenShared.toDart(c.eeeChainTokenShared);
  }
}

class ArrayCEeeChainTokenAuth implements DC<clib.CArrayCEeeChainTokenAuth>{
  List<EeeChainTokenAuth> data = <EeeChainTokenAuth>[];
  
  static free(Pointer<clib.CArrayCEeeChainTokenAuth> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }
  
  static freeInstance(clib.CArrayCEeeChainTokenAuth instance) {
    EeeChainTokenAuth.free(instance.ptr);
    instance.ptr = nullptr;
  }
  
  static ArrayCEeeChainTokenAuth fromC(Pointer<clib.CArrayCEeeChainTokenAuth> ptr) {
    var d = new ArrayCEeeChainTokenAuth();
    if (ptr == nullptr) {
      return d;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCEeeChainTokenAuth> toCPtr() {
    var c = allocateZero<clib.CArrayCEeeChainTokenAuth>(sizeOf<clib.CArrayCEeeChainTokenAuth>());
    toC(c);
    return c;
  }
  
  @override
  toC(Pointer<clib.CArrayCEeeChainTokenAuth> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CArrayCEeeChainTokenAuth c) {
    if (c.ptr != nullptr) {
      EeeChainTokenAuth.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CEeeChainTokenAuth>(sizeOf<clib.CEeeChainTokenAuth>(),count : data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length;i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCEeeChainTokenAuth> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }
  @override
  toDartInstance(clib.CArrayCEeeChainTokenAuth c) {
    data =  <EeeChainTokenAuth>[];
    for (var i = 0; i < c.len;i++) {
      data.add(new EeeChainTokenAuth());      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}


class BtcChainTokenAuth implements DC<clib.CBtcChainTokenAuth>{
   chainTokenSharedId = 0;
   netType = 0;
  int position = 0;
  BtcChainTokenShared btcChainTokenShared = new BtcChainTokenShared();

  static freeInstance(clib.CBtcChainTokenAuth instance) {
    if (instance.chainTokenSharedId != nullptr) {ffi.calloc.free(instance.chainTokenSharedId);}
    instance.chainTokenSharedId = nullptr;
    if (instance.netType != nullptr) {ffi.calloc.free(instance.netType);}
    instance.netType = nullptr;
    BtcChainTokenShared.free(instance.btcChainTokenShared);
    instance.btcChainTokenShared = nullptr;

  }
    
  static free(Pointer<clib.CBtcChainTokenAuth> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static BtcChainTokenAuth fromC(Pointer<clib.CBtcChainTokenAuth> ptr) {
    var d = new BtcChainTokenAuth();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CBtcChainTokenAuth> toCPtr() {
    var ptr = allocateZero<clib.CBtcChainTokenAuth>(sizeOf<clib.CBtcChainTokenAuth>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CBtcChainTokenAuth> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CBtcChainTokenAuth c) {
    c.chainTokenSharedId.value = chainTokenSharedId;
    c.netType.value = netType;
    c.position = position;
    if (c.btcChainTokenShared == nullptr) {c.btcChainTokenShared = allocateZero<clib.CBtcChainTokenShared>(sizeOf<clib.CBtcChainTokenShared>());}
    btcChainTokenShared.toC(c.btcChainTokenShared);

  }

  @override
  toDart(Pointer<clib.CBtcChainTokenAuth> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CBtcChainTokenAuth c) {
    chainTokenSharedId = c.chainTokenSharedId.value;
    netType = c.netType.value;
    position = c.position;
    btcChainTokenShared = new BtcChainTokenShared();
    btcChainTokenShared.toDart(c.btcChainTokenShared);
  }
}

class ArrayCBtcChainTokenAuth implements DC<clib.CArrayCBtcChainTokenAuth>{
  List<BtcChainTokenAuth> data = <BtcChainTokenAuth>[];
  
  static free(Pointer<clib.CArrayCBtcChainTokenAuth> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }
  
  static freeInstance(clib.CArrayCBtcChainTokenAuth instance) {
    BtcChainTokenAuth.free(instance.ptr);
    instance.ptr = nullptr;
  }
  
  static ArrayCBtcChainTokenAuth fromC(Pointer<clib.CArrayCBtcChainTokenAuth> ptr) {
    var d = new ArrayCBtcChainTokenAuth();
    if (ptr == nullptr) {
      return d;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCBtcChainTokenAuth> toCPtr() {
    var c = allocateZero<clib.CArrayCBtcChainTokenAuth>(sizeOf<clib.CArrayCBtcChainTokenAuth>());
    toC(c);
    return c;
  }
  
  @override
  toC(Pointer<clib.CArrayCBtcChainTokenAuth> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CArrayCBtcChainTokenAuth c) {
    if (c.ptr != nullptr) {
      BtcChainTokenAuth.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CBtcChainTokenAuth>(sizeOf<clib.CBtcChainTokenAuth>(),count : data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length;i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCBtcChainTokenAuth> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }
  @override
  toDartInstance(clib.CArrayCBtcChainTokenAuth c) {
    data =  <BtcChainTokenAuth>[];
    for (var i = 0; i < c.len;i++) {
      data.add(new BtcChainTokenAuth());      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}


class EeeChainTx implements DC<clib.CEeeChainTx>{
   txHash = 0;
   blockHash = 0;
   blockNumber = 0;
   signer = 0;
   walletAccount = 0;
   fromAddress = 0;
   toAddress = 0;
   value = 0;
   extension1 = 0;
  int status = 0;
  int txTimestamp = 0;
   txBytes = 0;

  static freeInstance(clib.CEeeChainTx instance) {
    if (instance.txHash != nullptr) {ffi.calloc.free(instance.txHash);}
    instance.txHash = nullptr;
    if (instance.blockHash != nullptr) {ffi.calloc.free(instance.blockHash);}
    instance.blockHash = nullptr;
    if (instance.blockNumber != nullptr) {ffi.calloc.free(instance.blockNumber);}
    instance.blockNumber = nullptr;
    if (instance.signer != nullptr) {ffi.calloc.free(instance.signer);}
    instance.signer = nullptr;
    if (instance.walletAccount != nullptr) {ffi.calloc.free(instance.walletAccount);}
    instance.walletAccount = nullptr;
    if (instance.fromAddress != nullptr) {ffi.calloc.free(instance.fromAddress);}
    instance.fromAddress = nullptr;
    if (instance.toAddress != nullptr) {ffi.calloc.free(instance.toAddress);}
    instance.toAddress = nullptr;
    if (instance.value != nullptr) {ffi.calloc.free(instance.value);}
    instance.value = nullptr;
    if (instance.extension1 != nullptr) {ffi.calloc.free(instance.extension1);}
    instance.extension1 = nullptr;
    if (instance.txBytes != nullptr) {ffi.calloc.free(instance.txBytes);}
    instance.txBytes = nullptr;

  }
    
  static free(Pointer<clib.CEeeChainTx> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static EeeChainTx fromC(Pointer<clib.CEeeChainTx> ptr) {
    var d = new EeeChainTx();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEeeChainTx> toCPtr() {
    var ptr = allocateZero<clib.CEeeChainTx>(sizeOf<clib.CEeeChainTx>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEeeChainTx> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CEeeChainTx c) {
    c.txHash.value = txHash;
    c.blockHash.value = blockHash;
    c.blockNumber.value = blockNumber;
    c.signer.value = signer;
    c.walletAccount.value = walletAccount;
    c.fromAddress.value = fromAddress;
    c.toAddress.value = toAddress;
    c.value.value = value;
    c.extension1.value = extension1;
    c.status = status;
    c.txTimestamp = txTimestamp;
    c.txBytes.value = txBytes;

  }

  @override
  toDart(Pointer<clib.CEeeChainTx> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CEeeChainTx c) {
    txHash = c.txHash.value;
    blockHash = c.blockHash.value;
    blockNumber = c.blockNumber.value;
    signer = c.signer.value;
    walletAccount = c.walletAccount.value;
    fromAddress = c.fromAddress.value;
    toAddress = c.toAddress.value;
    value = c.value.value;
    extension1 = c.extension1.value;
    status = c.status;
    txTimestamp = c.txTimestamp;
    txBytes = c.txBytes.value;
  }
}

class ArrayCEeeChainTx implements DC<clib.CArrayCEeeChainTx>{
  List<EeeChainTx> data = <EeeChainTx>[];
  
  static free(Pointer<clib.CArrayCEeeChainTx> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }
  
  static freeInstance(clib.CArrayCEeeChainTx instance) {
    EeeChainTx.free(instance.ptr);
    instance.ptr = nullptr;
  }
  
  static ArrayCEeeChainTx fromC(Pointer<clib.CArrayCEeeChainTx> ptr) {
    var d = new ArrayCEeeChainTx();
    if (ptr == nullptr) {
      return d;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CArrayCEeeChainTx> toCPtr() {
    var c = allocateZero<clib.CArrayCEeeChainTx>(sizeOf<clib.CArrayCEeeChainTx>());
    toC(c);
    return c;
  }
  
  @override
  toC(Pointer<clib.CArrayCEeeChainTx> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CArrayCEeeChainTx c) {
    if (c.ptr != nullptr) {
      EeeChainTx.free(c.ptr);
      c.ptr = nullptr;
    }
    c.ptr = allocateZero<clib.CEeeChainTx>(sizeOf<clib.CEeeChainTx>(),count : data.length);
    c.len = data.length;
    c.cap = data.length;
    for (var i = 0; i < data.length;i++) {
      data[i].toC(c.ptr.elementAt(i));
    }
  }

  @override
  toDart(Pointer<clib.CArrayCEeeChainTx> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }
  @override
  toDartInstance(clib.CArrayCEeeChainTx c) {
    data =  <EeeChainTx>[];
    for (var i = 0; i < c.len;i++) {
      data.add(new EeeChainTx());      data[i].toDart(c.ptr.elementAt(i));
    }
  }
}


class WalletTokenStatus implements DC<clib.CWalletTokenStatus>{
   walletId = 0;
   chainType = 0;
   tokenId = 0;
  int isShow = 0;

  static freeInstance(clib.CWalletTokenStatus instance) {
    if (instance.walletId != nullptr) {ffi.calloc.free(instance.walletId);}
    instance.walletId = nullptr;
    if (instance.chainType != nullptr) {ffi.calloc.free(instance.chainType);}
    instance.chainType = nullptr;
    if (instance.tokenId != nullptr) {ffi.calloc.free(instance.tokenId);}
    instance.tokenId = nullptr;

  }
    
  static free(Pointer<clib.CWalletTokenStatus> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static WalletTokenStatus fromC(Pointer<clib.CWalletTokenStatus> ptr) {
    var d = new WalletTokenStatus();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CWalletTokenStatus> toCPtr() {
    var ptr = allocateZero<clib.CWalletTokenStatus>(sizeOf<clib.CWalletTokenStatus>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CWalletTokenStatus> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CWalletTokenStatus c) {
    c.walletId.value = walletId;
    c.chainType.value = chainType;
    c.tokenId.value = tokenId;
    c.isShow = isShow;

  }

  @override
  toDart(Pointer<clib.CWalletTokenStatus> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CWalletTokenStatus c) {
    walletId = c.walletId.value;
    chainType = c.chainType.value;
    tokenId = c.tokenId.value;
    isShow = c.isShow;
  }
}

class BtcNowLoadBlock implements DC<clib.CBtcNowLoadBlock>{
  int height = 0;
   headerHash = 0;
   timestamp = 0;

  static freeInstance(clib.CBtcNowLoadBlock instance) {
    if (instance.headerHash != nullptr) {ffi.calloc.free(instance.headerHash);}
    instance.headerHash = nullptr;
    if (instance.timestamp != nullptr) {ffi.calloc.free(instance.timestamp);}
    instance.timestamp = nullptr;

  }
    
  static free(Pointer<clib.CBtcNowLoadBlock> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static BtcNowLoadBlock fromC(Pointer<clib.CBtcNowLoadBlock> ptr) {
    var d = new BtcNowLoadBlock();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CBtcNowLoadBlock> toCPtr() {
    var ptr = allocateZero<clib.CBtcNowLoadBlock>(sizeOf<clib.CBtcNowLoadBlock>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CBtcNowLoadBlock> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CBtcNowLoadBlock c) {
    c.height = height;
    c.headerHash.value = headerHash;
    c.timestamp.value = timestamp;

  }

  @override
  toDart(Pointer<clib.CBtcNowLoadBlock> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CBtcNowLoadBlock c) {
    height = c.height;
    headerHash = c.headerHash.value;
    timestamp = c.timestamp.value;
  }
}

class BtcBalance implements DC<clib.CBtcBalance>{
  int balance = 0;
  int height = 0;

  static freeInstance(clib.CBtcBalance instance) {

  }
    
  static free(Pointer<clib.CBtcBalance> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static BtcBalance fromC(Pointer<clib.CBtcBalance> ptr) {
    var d = new BtcBalance();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CBtcBalance> toCPtr() {
    var ptr = allocateZero<clib.CBtcBalance>(sizeOf<clib.CBtcBalance>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CBtcBalance> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CBtcBalance c) {
    c.balance = balance;
    c.height = height;

  }

  @override
  toDart(Pointer<clib.CBtcBalance> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CBtcBalance c) {
    balance = c.balance;
    height = c.height;
  }
}

class EthWalletConnectTx implements DC<clib.CEthWalletConnectTx>{
   from = 0;
   to = 0;
   data = 0;
   gasPrice = 0;
   gas = 0;
   value = 0;
   nonce = 0;
   maxPriorityFeePerGas = 0;
  int typeTxId = 0;

  static freeInstance(clib.CEthWalletConnectTx instance) {
    if (instance.from != nullptr) {ffi.calloc.free(instance.from);}
    instance.from = nullptr;
    if (instance.to != nullptr) {ffi.calloc.free(instance.to);}
    instance.to = nullptr;
    if (instance.data != nullptr) {ffi.calloc.free(instance.data);}
    instance.data = nullptr;
    if (instance.gasPrice != nullptr) {ffi.calloc.free(instance.gasPrice);}
    instance.gasPrice = nullptr;
    if (instance.gas != nullptr) {ffi.calloc.free(instance.gas);}
    instance.gas = nullptr;
    if (instance.value != nullptr) {ffi.calloc.free(instance.value);}
    instance.value = nullptr;
    if (instance.nonce != nullptr) {ffi.calloc.free(instance.nonce);}
    instance.nonce = nullptr;
    if (instance.maxPriorityFeePerGas != nullptr) {ffi.calloc.free(instance.maxPriorityFeePerGas);}
    instance.maxPriorityFeePerGas = nullptr;

  }
    
  static free(Pointer<clib.CEthWalletConnectTx> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static EthWalletConnectTx fromC(Pointer<clib.CEthWalletConnectTx> ptr) {
    var d = new EthWalletConnectTx();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEthWalletConnectTx> toCPtr() {
    var ptr = allocateZero<clib.CEthWalletConnectTx>(sizeOf<clib.CEthWalletConnectTx>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEthWalletConnectTx> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CEthWalletConnectTx c) {
    c.from.value = from;
    c.to.value = to;
    c.data.value = data;
    c.gasPrice.value = gasPrice;
    c.gas.value = gas;
    c.value.value = value;
    c.nonce.value = nonce;
    c.maxPriorityFeePerGas.value = maxPriorityFeePerGas;
    c.typeTxId = typeTxId;

  }

  @override
  toDart(Pointer<clib.CEthWalletConnectTx> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CEthWalletConnectTx c) {
    from = c.from.value;
    to = c.to.value;
    data = c.data.value;
    gasPrice = c.gasPrice.value;
    gas = c.gas.value;
    value = c.value.value;
    nonce = c.nonce.value;
    maxPriorityFeePerGas = c.maxPriorityFeePerGas.value;
    typeTxId = c.typeTxId;
  }
}

class InitParameters implements DC<clib.CInitParameters>{
  DbName dbName = new DbName();
  int isMemoryDb = 0;
   contextNote = 0;

  static freeInstance(clib.CInitParameters instance) {
    DbName.free(instance.dbName);
    instance.dbName = nullptr;
    if (instance.contextNote != nullptr) {ffi.calloc.free(instance.contextNote);}
    instance.contextNote = nullptr;

  }
    
  static free(Pointer<clib.CInitParameters> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static InitParameters fromC(Pointer<clib.CInitParameters> ptr) {
    var d = new InitParameters();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CInitParameters> toCPtr() {
    var ptr = allocateZero<clib.CInitParameters>(sizeOf<clib.CInitParameters>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CInitParameters> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CInitParameters c) {
    if (c.dbName == nullptr) {c.dbName = allocateZero<clib.CDbName>(sizeOf<clib.CDbName>());}
    dbName.toC(c.dbName);
    c.isMemoryDb = isMemoryDb;
    c.contextNote.value = contextNote;

  }

  @override
  toDart(Pointer<clib.CInitParameters> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CInitParameters c) {
    dbName = new DbName();
    dbName.toDart(c.dbName);
    isMemoryDb = c.isMemoryDb;
    contextNote = c.contextNote.value;
  }
}

class CreateWalletParameters implements DC<clib.CCreateWalletParameters>{
   name = 0;
   password = 0;
   mnemonic = 0;
   walletType = 0;

  static freeInstance(clib.CCreateWalletParameters instance) {
    if (instance.name != nullptr) {ffi.calloc.free(instance.name);}
    instance.name = nullptr;
    if (instance.password != nullptr) {ffi.calloc.free(instance.password);}
    instance.password = nullptr;
    if (instance.mnemonic != nullptr) {ffi.calloc.free(instance.mnemonic);}
    instance.mnemonic = nullptr;
    if (instance.walletType != nullptr) {ffi.calloc.free(instance.walletType);}
    instance.walletType = nullptr;

  }
    
  static free(Pointer<clib.CCreateWalletParameters> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static CreateWalletParameters fromC(Pointer<clib.CCreateWalletParameters> ptr) {
    var d = new CreateWalletParameters();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CCreateWalletParameters> toCPtr() {
    var ptr = allocateZero<clib.CCreateWalletParameters>(sizeOf<clib.CCreateWalletParameters>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CCreateWalletParameters> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CCreateWalletParameters c) {
    c.name.value = name;
    c.password.value = password;
    c.mnemonic.value = mnemonic;
    c.walletType.value = walletType;

  }

  @override
  toDart(Pointer<clib.CCreateWalletParameters> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CCreateWalletParameters c) {
    name = c.name.value;
    password = c.password.value;
    mnemonic = c.mnemonic.value;
    walletType = c.walletType.value;
  }
}

class BtcTxParam implements DC<clib.CBtcTxParam>{
   walletId = 0;
   password = 0;
   from_address = 0;
   to_address = 0;
   value = 0;
  int broadcast = 0;

  static freeInstance(clib.CBtcTxParam instance) {
    if (instance.walletId != nullptr) {ffi.calloc.free(instance.walletId);}
    instance.walletId = nullptr;
    if (instance.password != nullptr) {ffi.calloc.free(instance.password);}
    instance.password = nullptr;
    if (instance.from_address != nullptr) {ffi.calloc.free(instance.from_address);}
    instance.from_address = nullptr;
    if (instance.to_address != nullptr) {ffi.calloc.free(instance.to_address);}
    instance.to_address = nullptr;
    if (instance.value != nullptr) {ffi.calloc.free(instance.value);}
    instance.value = nullptr;

  }
    
  static free(Pointer<clib.CBtcTxParam> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static BtcTxParam fromC(Pointer<clib.CBtcTxParam> ptr) {
    var d = new BtcTxParam();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CBtcTxParam> toCPtr() {
    var ptr = allocateZero<clib.CBtcTxParam>(sizeOf<clib.CBtcTxParam>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CBtcTxParam> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CBtcTxParam c) {
    c.walletId.value = walletId;
    c.password.value = password;
    c.from_address.value = from_address;
    c.to_address.value = to_address;
    c.value.value = value;
    c.broadcast = broadcast;

  }

  @override
  toDart(Pointer<clib.CBtcTxParam> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CBtcTxParam c) {
    walletId = c.walletId.value;
    password = c.password.value;
    from_address = c.from_address.value;
    to_address = c.to_address.value;
    value = c.value.value;
    broadcast = c.broadcast;
  }
}

class DecodeAccountInfoParameters implements DC<clib.CDecodeAccountInfoParameters>{
   encodeData = 0;
  ChainVersion chainVersion = new ChainVersion();

  static freeInstance(clib.CDecodeAccountInfoParameters instance) {
    if (instance.encodeData != nullptr) {ffi.calloc.free(instance.encodeData);}
    instance.encodeData = nullptr;
    ChainVersion.free(instance.chainVersion);
    instance.chainVersion = nullptr;

  }
    
  static free(Pointer<clib.CDecodeAccountInfoParameters> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static DecodeAccountInfoParameters fromC(Pointer<clib.CDecodeAccountInfoParameters> ptr) {
    var d = new DecodeAccountInfoParameters();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CDecodeAccountInfoParameters> toCPtr() {
    var ptr = allocateZero<clib.CDecodeAccountInfoParameters>(sizeOf<clib.CDecodeAccountInfoParameters>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CDecodeAccountInfoParameters> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CDecodeAccountInfoParameters c) {
    c.encodeData.value = encodeData;
    if (c.chainVersion == nullptr) {c.chainVersion = allocateZero<clib.CChainVersion>(sizeOf<clib.CChainVersion>());}
    chainVersion.toC(c.chainVersion);

  }

  @override
  toDart(Pointer<clib.CDecodeAccountInfoParameters> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CDecodeAccountInfoParameters c) {
    encodeData = c.encodeData.value;
    chainVersion = new ChainVersion();
    chainVersion.toDart(c.chainVersion);
  }
}

class StorageKeyParameters implements DC<clib.CStorageKeyParameters>{
  ChainVersion chainVersion = new ChainVersion();
   module = 0;
   storageItem = 0;
   account = 0;

  static freeInstance(clib.CStorageKeyParameters instance) {
    ChainVersion.free(instance.chainVersion);
    instance.chainVersion = nullptr;
    if (instance.module != nullptr) {ffi.calloc.free(instance.module);}
    instance.module = nullptr;
    if (instance.storageItem != nullptr) {ffi.calloc.free(instance.storageItem);}
    instance.storageItem = nullptr;
    if (instance.account != nullptr) {ffi.calloc.free(instance.account);}
    instance.account = nullptr;

  }
    
  static free(Pointer<clib.CStorageKeyParameters> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static StorageKeyParameters fromC(Pointer<clib.CStorageKeyParameters> ptr) {
    var d = new StorageKeyParameters();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CStorageKeyParameters> toCPtr() {
    var ptr = allocateZero<clib.CStorageKeyParameters>(sizeOf<clib.CStorageKeyParameters>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CStorageKeyParameters> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CStorageKeyParameters c) {
    if (c.chainVersion == nullptr) {c.chainVersion = allocateZero<clib.CChainVersion>(sizeOf<clib.CChainVersion>());}
    chainVersion.toC(c.chainVersion);
    c.module.value = module;
    c.storageItem.value = storageItem;
    c.account.value = account;

  }

  @override
  toDart(Pointer<clib.CStorageKeyParameters> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CStorageKeyParameters c) {
    chainVersion = new ChainVersion();
    chainVersion.toDart(c.chainVersion);
    module = c.module.value;
    storageItem = c.storageItem.value;
    account = c.account.value;
  }
}

class EeeTransferPayload implements DC<clib.CEeeTransferPayload>{
   fromAccount = 0;
   toAccount = 0;
   value = 0;
  int index = 0;
  ChainVersion chainVersion = new ChainVersion();
   extData = 0;
   password = 0;

  static freeInstance(clib.CEeeTransferPayload instance) {
    if (instance.fromAccount != nullptr) {ffi.calloc.free(instance.fromAccount);}
    instance.fromAccount = nullptr;
    if (instance.toAccount != nullptr) {ffi.calloc.free(instance.toAccount);}
    instance.toAccount = nullptr;
    if (instance.value != nullptr) {ffi.calloc.free(instance.value);}
    instance.value = nullptr;
    ChainVersion.free(instance.chainVersion);
    instance.chainVersion = nullptr;
    if (instance.extData != nullptr) {ffi.calloc.free(instance.extData);}
    instance.extData = nullptr;
    if (instance.password != nullptr) {ffi.calloc.free(instance.password);}
    instance.password = nullptr;

  }
    
  static free(Pointer<clib.CEeeTransferPayload> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static EeeTransferPayload fromC(Pointer<clib.CEeeTransferPayload> ptr) {
    var d = new EeeTransferPayload();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEeeTransferPayload> toCPtr() {
    var ptr = allocateZero<clib.CEeeTransferPayload>(sizeOf<clib.CEeeTransferPayload>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEeeTransferPayload> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CEeeTransferPayload c) {
    c.fromAccount.value = fromAccount;
    c.toAccount.value = toAccount;
    c.value.value = value;
    c.index = index;
    if (c.chainVersion == nullptr) {c.chainVersion = allocateZero<clib.CChainVersion>(sizeOf<clib.CChainVersion>());}
    chainVersion.toC(c.chainVersion);
    c.extData.value = extData;
    c.password.value = password;

  }

  @override
  toDart(Pointer<clib.CEeeTransferPayload> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CEeeTransferPayload c) {
    fromAccount = c.fromAccount.value;
    toAccount = c.toAccount.value;
    value = c.value.value;
    index = c.index;
    chainVersion = new ChainVersion();
    chainVersion.toDart(c.chainVersion);
    extData = c.extData.value;
    password = c.password.value;
  }
}

class RawTxParam implements DC<clib.CRawTxParam>{
   rawTx = 0;
   walletId = 0;
   password = 0;

  static freeInstance(clib.CRawTxParam instance) {
    if (instance.rawTx != nullptr) {ffi.calloc.free(instance.rawTx);}
    instance.rawTx = nullptr;
    if (instance.walletId != nullptr) {ffi.calloc.free(instance.walletId);}
    instance.walletId = nullptr;
    if (instance.password != nullptr) {ffi.calloc.free(instance.password);}
    instance.password = nullptr;

  }
    
  static free(Pointer<clib.CRawTxParam> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static RawTxParam fromC(Pointer<clib.CRawTxParam> ptr) {
    var d = new RawTxParam();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CRawTxParam> toCPtr() {
    var ptr = allocateZero<clib.CRawTxParam>(sizeOf<clib.CRawTxParam>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CRawTxParam> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CRawTxParam c) {
    c.rawTx.value = rawTx;
    c.walletId.value = walletId;
    c.password.value = password;

  }

  @override
  toDart(Pointer<clib.CRawTxParam> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CRawTxParam c) {
    rawTx = c.rawTx.value;
    walletId = c.walletId.value;
    password = c.password.value;
  }
}

class EthTransferPayload implements DC<clib.CEthTransferPayload>{
   fromAddress = 0;
   toAddress = 0;
   contractAddress = 0;
   value = 0;
   nonce = 0;
   gasPrice = 0;
   gasLimit = 0;
  int decimal = 0;
   extData = 0;

  static freeInstance(clib.CEthTransferPayload instance) {
    if (instance.fromAddress != nullptr) {ffi.calloc.free(instance.fromAddress);}
    instance.fromAddress = nullptr;
    if (instance.toAddress != nullptr) {ffi.calloc.free(instance.toAddress);}
    instance.toAddress = nullptr;
    if (instance.contractAddress != nullptr) {ffi.calloc.free(instance.contractAddress);}
    instance.contractAddress = nullptr;
    if (instance.value != nullptr) {ffi.calloc.free(instance.value);}
    instance.value = nullptr;
    if (instance.nonce != nullptr) {ffi.calloc.free(instance.nonce);}
    instance.nonce = nullptr;
    if (instance.gasPrice != nullptr) {ffi.calloc.free(instance.gasPrice);}
    instance.gasPrice = nullptr;
    if (instance.gasLimit != nullptr) {ffi.calloc.free(instance.gasLimit);}
    instance.gasLimit = nullptr;
    if (instance.extData != nullptr) {ffi.calloc.free(instance.extData);}
    instance.extData = nullptr;

  }
    
  static free(Pointer<clib.CEthTransferPayload> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static EthTransferPayload fromC(Pointer<clib.CEthTransferPayload> ptr) {
    var d = new EthTransferPayload();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEthTransferPayload> toCPtr() {
    var ptr = allocateZero<clib.CEthTransferPayload>(sizeOf<clib.CEthTransferPayload>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEthTransferPayload> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CEthTransferPayload c) {
    c.fromAddress.value = fromAddress;
    c.toAddress.value = toAddress;
    c.contractAddress.value = contractAddress;
    c.value.value = value;
    c.nonce.value = nonce;
    c.gasPrice.value = gasPrice;
    c.gasLimit.value = gasLimit;
    c.decimal = decimal;
    c.extData.value = extData;

  }

  @override
  toDart(Pointer<clib.CEthTransferPayload> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CEthTransferPayload c) {
    fromAddress = c.fromAddress.value;
    toAddress = c.toAddress.value;
    contractAddress = c.contractAddress.value;
    value = c.value.value;
    nonce = c.nonce.value;
    gasPrice = c.gasPrice.value;
    gasLimit = c.gasLimit.value;
    decimal = c.decimal;
    extData = c.extData.value;
  }
}

class EthRawTxPayload implements DC<clib.CEthRawTxPayload>{
   fromAddress = 0;
   rawTx = 0;

  static freeInstance(clib.CEthRawTxPayload instance) {
    if (instance.fromAddress != nullptr) {ffi.calloc.free(instance.fromAddress);}
    instance.fromAddress = nullptr;
    if (instance.rawTx != nullptr) {ffi.calloc.free(instance.rawTx);}
    instance.rawTx = nullptr;

  }
    
  static free(Pointer<clib.CEthRawTxPayload> ptr) {
    if (ptr == nullptr) {
      return;
    }
    freeInstance(ptr.ref);
    ffi.calloc.free(ptr);
  }


  static EthRawTxPayload fromC(Pointer<clib.CEthRawTxPayload> ptr) {
    var d = new EthRawTxPayload();
    if (ptr == nullptr) {
      return d ;
    }
    d.toDart(ptr);
    return d;
  }

  @override
  Pointer<clib.CEthRawTxPayload> toCPtr() {
    var ptr = allocateZero<clib.CEthRawTxPayload>(sizeOf<clib.CEthRawTxPayload>());
    toC(ptr);
    return ptr;
  }

  @override
  toC(Pointer<clib.CEthRawTxPayload> c) {
    if (c == nullptr) {
      return;
    }
    toCInstance(c.ref);
  }
  
  @override
  toCInstance(clib.CEthRawTxPayload c) {
    c.fromAddress.value = fromAddress;
    c.rawTx.value = rawTx;

  }

  @override
  toDart(Pointer<clib.CEthRawTxPayload> c) {
    if (c == nullptr) {
      return;
    }
    toDartInstance(c.ref);
  }

  @override
  toDartInstance(clib.CEthRawTxPayload c) {
    fromAddress = c.fromAddress.value;
    rawTx = c.rawTx.value;
  }
}
