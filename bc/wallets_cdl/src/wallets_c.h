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

typedef uint16_t CBool;

typedef struct InitParameters {
    uint64_t code;
} InitParameters;

typedef struct UnInitParameters {
    uint64_t code;
} UnInitParameters;

typedef struct Context {

} Context;

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

CArrayWallet *CArrayWallet_alloc(void);

void CArrayWallet_free(CArrayWallet *ptr);

void CChar_free(char *cs);

CBool Wallets_lockRead(void);

CBool Wallets_unlockRead(void);

CBool Wallets_lockWrite(void);

CBool Wallets_unlockWrite(void);

const CError *Wallets_init(InitParameters *params);

const CError *Wallets_uninit(UnInitParameters *params);

const CError *Wallets_all(Context *ctx, CArrayWallet *ptr);

#ifdef __cplusplus
} // extern "C"
#endif // __cplusplus
