#pragma once

/* Generated with cbindgen:0.15.0 */

#include <stdint.h>

typedef struct CContext {
    char *id;
    char *contextNote;
} CContext;

typedef uint64_t CU64;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayCContext {
    CContext *ptr;
    CU64 len;
    CU64 cap;
} CArrayCContext;

typedef uint32_t CBool;

typedef struct CError {
    CU64 code;
    char *message;
} CError;

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
    char *name;
    char *symbol;
    char *logoUrl;
    char *logoBytes;
    char *projectName;
    char *projectHome;
    char *projectNote;
} CTokenShared;

typedef struct CEthChainTokenShared {
    CTokenShared *tokenShared;
    char *tokenType;
    int64_t gasLimit;
    char *gasPrice;
    int32_t decimal;
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
    char *tokenType;
    int64_t gasLimit;
    char *gasPrice;
    int32_t decimal;
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
    CArrayCEeeChainToken *tokens;
} CEeeChain;

typedef struct CBtcChainTokenShared {
    CTokenShared *tokenShared;
    char *tokenType;
    int64_t gas;
    int32_t decimal;
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
    char *name;
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

typedef struct CDbName {
    char *path;
    char *prefix;
    char *cashboxWallets;
    char *cashboxMnemonic;
    char *walletMainnet;
    char *walletPrivate;
    char *walletTestnet;
    char *walletTestnetPrivate;
} CDbName;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayI64 {
    int64_t *ptr;
    CU64 len;
    CU64 cap;
} CArrayI64;

typedef struct CAccountInfoSyncProg {
    char *account;
    char *blockNo;
    char *blockHash;
} CAccountInfoSyncProg;

typedef struct CAccountInfo {
    uint32_t nonce;
    uint32_t refCount;
    char *freeBalance;
    char *reserved;
    char *miscFrozen;
    char *feeFrozen;
} CAccountInfo;

typedef struct CSubChainBasicInfo {
    char *genesisHash;
    char *metadata;
    int32_t runtimeVersion;
    int32_t txVersion;
    int32_t ss58FormatPrefix;
    int32_t tokenDecimals;
    char *tokenSymbol;
    CBool isDefault;
} CSubChainBasicInfo;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayCChar {
    char **ptr;
    CU64 len;
    CU64 cap;
} CArrayCChar;

typedef struct CEthChainTokenDefault {
    char *chainTokenSharedId;
    char *netType;
    int64_t position;
    char *contractAddress;
    CEthChainTokenShared *ethChainTokenShared;
} CEthChainTokenDefault;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayCEthChainTokenDefault {
    CEthChainTokenDefault *ptr;
    CU64 len;
    CU64 cap;
} CArrayCEthChainTokenDefault;

typedef struct CChainVersion {
    char *genesisHash;
    int32_t runtimeVersion;
    int32_t txVersion;
} CChainVersion;

typedef struct CExtrinsicContext {
    CChainVersion *chainVersion;
    char *account;
    char *blockHash;
    char *blockNumber;
    char *event;
    CArrayCChar *extrinsics;
} CExtrinsicContext;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayCExtrinsicContext {
    CExtrinsicContext *ptr;
    CU64 len;
    CU64 cap;
} CArrayCExtrinsicContext;

typedef struct CInitParameters {
    CDbName *dbName;
    char *contextNote;
} CInitParameters;

typedef struct CCreateWalletParameters {
    char *name;
    char *password;
    char *mnemonic;
    char *walletType;
} CCreateWalletParameters;

typedef struct CDecodeAccountInfoParameters {
    char *encodeData;
    CChainVersion *chainVersion;
} CDecodeAccountInfoParameters;

typedef struct CStorageKeyParameters {
    CChainVersion *chainVersion;
    char *module;
    char *storageItem;
    char *account;
} CStorageKeyParameters;

typedef struct CEeeTransferPayload {
    char *fromAccount;
    char *toAccount;
    char *value;
    uint32_t index;
    CChainVersion *chainVersion;
    char *extData;
    char *password;
} CEeeTransferPayload;

typedef struct CRawTxParam {
    char *rawTx;
    char *walletId;
    char *password;
} CRawTxParam;

typedef struct CEeeChainTokenAuth {
    char *chainTokenSharedId;
    char *netType;
    int64_t position;
    CEeeChainTokenShared *eeeChainTokenShared;
} CEeeChainTokenAuth;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayCEeeChainTokenAuth {
    CEeeChainTokenAuth *ptr;
    CU64 len;
    CU64 cap;
} CArrayCEeeChainTokenAuth;

typedef struct CEeeChainTokenDefault {
    char *chainTokenSharedId;
    char *netType;
    int64_t position;
    CEeeChainTokenShared *eeeChainTokenShared;
} CEeeChainTokenDefault;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayCEeeChainTokenDefault {
    CEeeChainTokenDefault *ptr;
    CU64 len;
    CU64 cap;
} CArrayCEeeChainTokenDefault;

typedef struct CEthTransferPayload {
    char *fromAddress;
    char *toAddress;
    char *contractAddress;
    char *value;
    char *nonce;
    char *gasPrice;
    char *gasLimit;
    uint32_t decimal;
    char *extData;
} CEthTransferPayload;

typedef struct CEthRawTxPayload {
    char *fromAddress;
    char *rawTx;
} CEthRawTxPayload;

typedef struct CEthChainTokenAuth {
    char *chainTokenSharedId;
    char *netType;
    int64_t position;
    char *contractAddress;
    CEthChainTokenShared *ethChainTokenShared;
} CEthChainTokenAuth;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayCEthChainTokenAuth {
    CEthChainTokenAuth *ptr;
    CU64 len;
    CU64 cap;
} CArrayCEthChainTokenAuth;

typedef struct CBtcChainTokenDefault {
    char *chainTokenSharedId;
    char *netType;
    int64_t position;
    CBtcChainTokenShared *btcChainTokenShared;
} CBtcChainTokenDefault;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayCBtcChainTokenDefault {
    CBtcChainTokenDefault *ptr;
    CU64 len;
    CU64 cap;
} CArrayCBtcChainTokenDefault;

typedef struct CBtcChainTokenAuth {
    char *chainTokenSharedId;
    char *netType;
    int64_t position;
    CBtcChainTokenShared *btcChainTokenShared;
} CBtcChainTokenAuth;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayCBtcChainTokenAuth {
    CBtcChainTokenAuth *ptr;
    CU64 len;
    CU64 cap;
} CArrayCBtcChainTokenAuth;

#define CFalse 1

#define CTrue 0

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

/**
 * alloc ** [parameters::CContext]
 */
CContext **CContext_dAlloc(void);

/**
 * free ** [parameters::CContext]
 */
void CContext_dFree(CContext **dPtr);

/**
 * alloc ** [CArray]
 */
CArrayCContext **CArrayCContext_dAlloc(void);

void CArrayCContext_dFree(CArrayCContext **dPtr);

void CStr_free(char *dcs);

void CStr_dFree(char **dcs);

char **CStr_dAlloc(void);

void CBool_dFree(CBool **dcs);

CBool **CBool_dAlloc(void);

void CError_free(CError *error);

CWallet **CWallet_dAlloc(void);

void CWallet_dFree(CWallet **dPtr);

CArrayCWallet **CArrayCWallet_dAlloc(void);

void CArrayCWallet_dFree(CArrayCWallet **dPtr);

CDbName **CDbName_dAlloc(void);

void CDbName_dFree(CDbName **dPtr);

CArrayI64 **CArrayInt64_dAlloc(void);

void CArrayInt64_dFree(CArrayI64 **dPtr);

CAccountInfoSyncProg **CAccountInfoSyncProg_dAlloc(void);

void CAccountInfoSyncProg_dFree(CAccountInfoSyncProg **dPtr);

CAccountInfo **CAccountInfo_dAlloc(void);

void CAccountInfo_dFree(CAccountInfo **dPtr);

CSubChainBasicInfo **CSubChainBasicInfo_dAlloc(void);

void CSubChainBasicInfo_dFree(CSubChainBasicInfo **dPtr);

CArrayCChar **CArrayCChar_dAlloc(void);

void CArrayCChar_dFree(CArrayCChar **dPtr);

CArrayCEthChainTokenDefault **CArrayCEthChainTokenDefault_dAlloc(void);

void CArrayCEthChainTokenDefault_dFree(CArrayCEthChainTokenDefault **dPtr);

CArrayCExtrinsicContext **CExtrinsicContext_dAlloc(void);

void CExtrinsicContext_dFree(CArrayCExtrinsicContext **dPtr);

/**
 * 生成数据库文件名，只有数据库文件名不存在（为null或“”）时才创建文件名
 * 如果成功返回 [wallets_types::Error::SUCCESS()]
 */
const CError *Wallets_dbName(CDbName *name, CDbName **outName);

/**
 * 如果成功返回 [wallets_types::Error::SUCCESS()]
 */
const CError *Wallets_init(CInitParameters *parameter, CContext **context);

/**
 * 如果成功返回 [wallets_types::Error::SUCCESS()]
 */
const CError *Wallets_uninit(CContext *ctx);

/**
 * 返回所有的Context, 有可能是0个
 * 如果成功返回 [wallets_types::Error::SUCCESS()]
 */
const CError *Wallets_Contexts(CArrayCContext **contexts);

/**
 * 返回最后的Context, 有可能是空值
 * 如果成功返回 [wallets_types::Error::SUCCESS()]
 */
const CError *Wallets_lastContext(CContext **context);

/**
 * 返回第一个Context, 有可能是空值
 * 如果成功返回 [wallets_types::Error::SUCCESS()]
 */
const CError *Wallets_firstContext(CContext **context);

const CError *Wallets_lockRead(CContext *ctx);

const CError *Wallets_unlockRead(CContext *ctx);

const CError *Wallets_lockWrite(CContext *ctx);

const CError *Wallets_unlockWrite(CContext *ctx);

const CError *Wallets_all(CContext *ctx, CArrayCWallet **arrayWallet);

const CError *Wallets_generateMnemonic(char **mnemonic);

const CError *Wallets_createWallet(CContext *ctx, CCreateWalletParameters *parameters, CWallet **wallet);

const CError *Wallets_removeWallet(CContext *ctx, char *walletId);

const CError *Wallets_renameWallet(CContext *ctx, char *newName, char *walletId);

/**
 * 只有到CError为 Error::SUCCESS()时返值才有意义
 * 返回值 hasAny: true表示至少有一个; Fail: false，没有
 */
const CError *Wallets_hasAny(CContext *ctx, CBool *hasAny);

const CError *Wallets_findById(CContext *ctx, char *walletId, CWallet **wallet);

/**
 *注：只加载了wallet的id name等直接的基本数据，子对象（如链）的数据没有加载
 */
const CError *Wallets_findWalletBaseByName(CContext *ctx, char *name, CArrayCWallet **walletArray);

/**
 * 查询当前wallet 与 chain
 */
const CError *Wallets_currentWalletChain(CContext *ctx, char **walletId, char **chainType);

/**
 *保存当前wallet 与 chain
 */
const CError *Wallets_saveCurrentWalletChain(CContext *ctx, char *walletId, char *chainType);

const char *Wallets_appPlatformType(void);

const CError *ChainEee_updateSyncRecord(CContext *ctx, char *netType, CAccountInfoSyncProg *syncRecord);

const CError *ChainEee_getSyncRecord(CContext *ctx, char *netType, char *account, CAccountInfoSyncProg **syncRecord);

const CError *ChainEee_decodeAccountInfo(CContext *ctx, char *netType, CDecodeAccountInfoParameters *parameters, CAccountInfo **accountInfo);

const CError *ChainEee_getStorageKey(CContext *ctx, char *netType, CStorageKeyParameters *parameters, char **key);

const CError *ChainEee_eeeTransfer(CContext *ctx, char *netType, CEeeTransferPayload *transferPayload, char **signedResult);

const CError *ChainEee_tokenXTransfer(CContext *ctx, char *netType, CEeeTransferPayload *transferPayload, char **signedResult);

const CError *ChainEee_txSubmittableSign(CContext *ctx, char *netType, CRawTxParam *rawTx, char **signedResult);

const CError *ChainEee_txSign(CContext *ctx, char *netType, CRawTxParam *rawTx, char **signedResult);

const CError *ChainEee_updateBasicInfo(CContext *ctx, char *netType, CSubChainBasicInfo *basicInfo);

const CError *ChainEee_getBasicInfo(CContext *ctx, char *netType, CChainVersion *chainVersion, CSubChainBasicInfo **basicInfo);

const CError *ChainEee_saveExtrinsicDetail(CContext *ctx, char *netType, CExtrinsicContext *extrinsicCtx);

const CError *ChainEee_updateAuthDigitList(CContext *ctx, CArrayCEeeChainTokenAuth *authTokens);

const CError *ChainEee_updateDefaultTokenList(CContext *ctx, CArrayCEeeChainTokenDefault *defaultTokens);

const CError *ChainEth_decodeAdditionData(CContext *ctx, char *encodeData, char **additionData);

const CError *ChainEth_txSign(CContext *ctx, char *netType, CEthTransferPayload *txPayload, char *password, char **signResult);

const CError *ChainEth_rawTxSign(CContext *ctx, char *netType, CEthRawTxPayload *rawTxPayload, char *password, char **signResult);

const CError *ChainEth_updateAuthTokenList(CContext *ctx, CArrayCEthChainTokenAuth *authTokens);

const CError *ChainEth_updateDefaultTokenList(CContext *ctx, CArrayCEthChainTokenDefault *defaultTokens);

const CError *ChainEth_addNonAuthDigit(CContext *ctx, CArrayCEthChainTokenAuth *tokens);

const CError *ChainEth_updateDigitBalance(CContext *_ctx, char *_netType, CEthChainTokenDefault *_tokens);

const CError *ChainBtc_updateDefaultTokenList(CContext *ctx, CArrayCBtcChainTokenDefault *defaultTokens);

const CError *ChainBtc_updateAuthDigitList(CContext *ctx, CArrayCBtcChainTokenAuth *authTokens);

#ifdef __cplusplus
} // extern "C"
#endif // __cplusplus
