#pragma once

/* Generated with cbindgen:0.15.0 */

#include <stdint.h>

typedef uint64_t CU64;

typedef struct CError {
    CU64 code;
    char *message;
} CError;

typedef struct Address {
    char *id;
    char *walletId;
    char *chainType;
    char *address;
    char *publicKey;
} Address;

typedef struct ChainShared {
    char *id;
    char *walletId;
    char *chainType;
    /**
     * 钱包地址
     */
    Address *walletAddress;
} ChainShared;

typedef struct TokenShared {
    char *id;
    char *nextId;
    char *name;
    char *symbol;
} TokenShared;

typedef struct EthChainToken {
    TokenShared *tokenShared;
} EthChainToken;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayEthChainToken {
    EthChainToken *ptr;
    CU64 len;
    CU64 cap;
} CArrayEthChainToken;

typedef struct EthChain {
    ChainShared *chain_shared;
    CArrayEthChainToken *tokens;
} EthChain;

typedef struct EeeChainToken {
    TokenShared *tokenShared;
} EeeChainToken;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayEeeChainToken {
    EeeChainToken *ptr;
    CU64 len;
    CU64 cap;
} CArrayEeeChainToken;

typedef struct EeeChain {
    ChainShared *chainShared;
    Address *address;
    CArrayEeeChainToken *tokens;
} EeeChain;

typedef struct BtcChainToken {
    TokenShared *tokenShared;
} BtcChainToken;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayBtcChainToken {
    BtcChainToken *ptr;
    CU64 len;
    CU64 cap;
} CArrayBtcChainToken;

typedef struct BtcChain {
    ChainShared *chainShared;
    CArrayBtcChainToken *tokens;
} BtcChain;

typedef struct Wallet {
    char *id;
    char *nextId;
    EthChain *ethChains;
    EeeChain *eeeChains;
    BtcChain *btcChains;
} Wallet;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayWallet {
    Wallet *ptr;
    CU64 len;
    CU64 cap;
} CArrayWallet;

typedef struct DbName {
    char *cashboxWallets;
    char *cashboxMnemonic;
    char *walletMainnet;
    char *walletPrivate;
    char *walletTestnet;
    char *walletTestnetPrivate;
} DbName;

typedef struct InitParameters {
    DbName *dbName;
} InitParameters;

typedef struct Context {
    char *id;
} Context;

typedef struct UnInitParameters {

} UnInitParameters;

typedef uint16_t CBool;

#define CFalse 0

#define CTrue 1

#define Success 0

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

void CStr_free(char *cs);

void CError_free(CError *error);

Wallet *Wallet_alloc(void);

void Wallet_free(Wallet *ptr);

CArrayWallet **CArrayWallet_dAlloc(void);

void CArrayWallet_dFree(CArrayWallet **dPtr);

void CChar_free(char *cs);

/**
 * dart中不要复制Context的内存，会在调用 [Wallets_uninit] 释放内存
 */
const CError *Wallets_init(InitParameters *parameter, Context **ctx);

const CError *Wallets_uninit(Context *ctx, UnInitParameters *parameter);

CBool Wallets_lockRead(Context *ctx);

CBool Wallets_unlockRead(Context *ctx);

CBool Wallets_lockWrite(Context *ctx);

CBool Wallets_unlockWrite(Context *ctx);

const CError *Wallets_all(Context *ctx, CArrayWallet *arrayWallet);

Context **Context_dAlloc(void);

void Context_dFree(Context **dPtr);

#ifdef __cplusplus
} // extern "C"
#endif // __cplusplus
