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
    char *cashboxWallets;
    char *cashboxMnemonic;
    char *walletMainnet;
    char *walletPrivate;
    char *walletTestnet;
    char *walletTestnetPrivate;
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

typedef struct CCreateWalletParameters {
    char *name;
    char *password;
    char *mnemonic;
    char *walletType;
} CCreateWalletParameters;

typedef uint32_t CBool;

typedef struct CSyncRecordDetail {
    char *account;
    char *blockNo;
    char *blockHash;
} CSyncRecordDetail;

typedef struct CAccountInfo {
    uint32_t nonce;
    uint32_t ref_count;
    char *free;
    char *reserved;
    char *misc_frozen;
    char *fee_frozen;
} CAccountInfo;

typedef struct CTransferPayload {
    char *fromAccount;
    char *toAccount;
    char *value;
    char *genesisHash;
    uint32_t index;
    uint32_t runtime_version;
    uint32_t tx_version;
    char *extData;
    char *password;
} CTransferPayload;

typedef struct CRawTxParam {
    char *rawTx;
    char *walletId;
    char *password;
} CRawTxParam;

typedef struct CSubChainBasicInfo {
    char *infoId;
    char *genesisHash;
    char *metadata;
    uint32_t runtimeVersion;
    uint32_t txVersion;
    uint32_t ss58Format;
    uint32_t tokenDecimals;
    char *tokenSymbol;
} CSubChainBasicInfo;

typedef uint32_t CU32;

#define CFalse 1

#define CTrue 0

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

/**
 * dart中不要复制Context的内存，在调用 [Wallets_uninit] 后，调用Context的内存函数释放它
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

void CStr_dFree(char **dcs);

char **CStr_dAlloc(void);

void CBool_dFree(CBool **dcs);

CBool **CBool_dAlloc(void);

void CError_free(CError *error);

CWallet **CWallet_dAlloc(void);

void CWallet_dFree(CWallet **dPtr);

CArrayCWallet **CArrayCWallet_dAlloc(void);

void CArrayCWallet_dFree(CArrayCWallet **dPtr);

const CError *ChainEee_updateSyncRecord(CContext *ctx, CSyncRecordDetail *syncRecord);

const CError *ChainEee_getSyncRecord(CContext *ctx, CSyncRecordDetail **syncRecord);

const CError *ChainEee_decodeAccountInfo(CContext *ctx, char *encodeData, CAccountInfo **accountInfo);

const CError *ChainEee_getStorageKey(CContext *ctx, char *module, char *storageItem, char *pubKey, char **accountInfo);

const CError *ChainEee_eeeTransfer(CContext *ctx, CTransferPayload *transferPayload, char **signedResult);

const CError *ChainEee_tokenXTransfer(CContext *ctx, CTransferPayload *transferPayload, char **signedResult);

const CError *ChainEee_txSubmittableSign(CContext *ctx, CRawTxParam *rawTx, char **signedResult);

const CError *ChainEee_txSign(CContext *ctx, CRawTxParam *rawTx, char **signedResult);

const CError *ChainEee_updateBasicInfo(CContext *ctx, CSubChainBasicInfo *basicInfo, CBool *isDefault);

const CError *ChainEee_getBasicInfo(CContext *ctx, char *genesisHash, CU32 *specVersion, CU32 *txVersion,
                                    CSubChainBasicInfo **basicInfo);

#ifdef __cplusplus
} // extern "C"
#endif // __cplusplus
