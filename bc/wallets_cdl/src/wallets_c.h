#pragma once

/* Generated with cbindgen:0.15.0 */

#include <stdint.h>

typedef uint64_t CU64;

typedef struct CError {
    CU64 code;
    char *message;
} CError;

typedef struct CDbName {
    char *path;
    char *prefix;
    char *cashbox_wallets;
    char *cashbox_mnemonic;
    char *wallet_mainnet;
    char *wallet_private;
    char *wallet_testnet;
    char *wallet_testnet_private;
} CDbName;

typedef struct CInitParameters {
    CDbName *dbName;
    char *contextNote;
} CInitParameters;

typedef struct CContext {
    char *id;
    char *contextNote;
} CContext;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayCContext {
    CContext *ptr;
    CU64 len;
    CU64 cap;
} CArrayCContext;

typedef struct CAddress {
    char *id;
    char *walletId;
    char *chainType;
    char *address;
    char *publicKey;
} CAddress;

typedef struct CChainShared {
    char *walletId;
    char *chainType;
    /**
     * 钱包地址
     */
    CAddress *walletAddress;
} CChainShared;

typedef struct CTokenShared {
    char *chainType;
    char *name;
    char *symbol;
    char *logoUrl;
    char *logoBytes;
    char *project;
    bool auth;
} CTokenShared;

typedef struct CEthChainTokenShared {
    CTokenShared *tokenShared;
} CEthChainTokenShared;

typedef struct CEthChainToken {
    CEthChainTokenShared *ethChainTokenShared;
} CEthChainToken;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayCEthChainToken {
    CEthChainToken *ptr;
    CU64 len;
    CU64 cap;
} CArrayCEthChainToken;

typedef struct CEthChain {
    CChainShared *chainShared;
    CArrayCEthChainToken *tokens;
} CEthChain;

typedef struct CEeeChainTokenShared {
    CTokenShared *tokenShared;
} CEeeChainTokenShared;

typedef struct CEeeChainToken {
    CEeeChainTokenShared *eeeChainTokenShared;
} CEeeChainToken;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayCEeeChainToken {
    CEeeChainToken *ptr;
    CU64 len;
    CU64 cap;
} CArrayCEeeChainToken;

typedef struct CEeeChain {
    CChainShared *chainShared;
    CAddress *address;
    CArrayCEeeChainToken *tokens;
} CEeeChain;

typedef struct CBtcChainTokenShared {
    CTokenShared *tokenShared;
} CBtcChainTokenShared;

typedef struct CBtcChainToken {
    CBtcChainTokenShared *btcChainTokenShared;
} CBtcChainToken;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayCBtcChainToken {
    CBtcChainToken *ptr;
    CU64 len;
    CU64 cap;
} CArrayCBtcChainToken;

typedef struct CBtcChain {
    CChainShared *chainShared;
    CArrayCBtcChainToken *tokens;
} CBtcChain;

typedef struct CWallet {
    char *id;
    char *nextId;
    CEthChain *ethChain;
    CEeeChain *eeeChain;
    CBtcChain *btcChain;
} CWallet;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayCWallet {
    CWallet *ptr;
    CU64 len;
    CU64 cap;
} CArrayCWallet;

typedef struct CCreateWalletParameters {
    char *name;
    char *password;
    char *mnemonic;
    char *walletType;
} CCreateWalletParameters;

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

/**
 * dart中不要复制Context的内存，在调用 [Wallets_uninit] 后，调用Context的内存函数释放它
 */
const CError *Wallets_init(CInitParameters *parameter, CContext **context);

const CError *Wallets_uninit(CContext *ctx);

/**
 * 返回所有的Context,如果没有返回空，且Error::SUCCESS()
 */
const CError *Wallets_Contexts(CArrayCContext **contexts);

/**
 * 返回最后的Context,如果没有返回空，且Error::SUCCESS()
 */
const CError *Wallets_lastContext(CContext **context);

/**
 * 返回最后的Context,如果没有返回空，且Error::SUCCESS()
 */
const CError *Wallets_firstContext(CContext **context);

const CError *Wallets_lockRead(CContext *ctx);

const CError *Wallets_unlockRead(CContext *ctx);

const CError *Wallets_lockWrite(CContext *ctx);

const CError *Wallets_unlockWrite(CContext *ctx);

const CError *Wallets_all(CContext *ctx, CArrayCWallet **arrayWallet);

const CError *Wallets_generateMnemonic(char **mnemonic);

const CError *Wallets_createWallet(CContext *ctx, CCreateWalletParameters *parameters, CWallet **wallet);

const CError *Wallets_deleteWallet(CContext *ctx, char *walletId);

/**
 * Success: true; Fail: false
 */
const CError *Wallets_hasOne(CContext *ctx);

const CError *Wallets_findById(CContext *ctx, char *walletId, CWallet **wallet);

const CError *Wallets_findByName(CContext *ctx, char *name, CArrayCWallet **arrayWallet);

CContext **CContext_dAlloc(void);

void CContext_dFree(CContext **dPtr);

CArrayCContext **CArrayCContext_dAlloc(void);

void CArrayCContext_dFree(CArrayCContext **dPtr);

void CStr_dFree(char **dcs);

char **CStr_dAlloc(void);

void CError_free(CError *error);

CWallet **CWallet_dAlloc(void);

void CWallet_dFree(CWallet **dPtr);

CArrayCWallet **CArrayCWallet_dAlloc(void);

void CArrayCWallet_dFree(CArrayCWallet **dPtr);

#ifdef __cplusplus
} // extern "C"
#endif // __cplusplus
