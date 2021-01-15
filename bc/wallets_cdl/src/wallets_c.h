#pragma once

/* Generated with cbindgen:0.16.0 */

#include <stdint.h>

typedef uint64_t CU64;

typedef struct CError {
    CU64 code;
    char *message;
} CError;

typedef struct CContext {
    char *id;
    char *contextNote;
} CContext;

typedef struct CAccountInfoSyncProg {
    char *account;
    char *blockNo;
    char *blockHash;
} CAccountInfoSyncProg;

typedef struct CChainVersion {
    char *genesisHash;
    int32_t runtimeVersion;
    int32_t txVersion;
} CChainVersion;

typedef struct CDecodeAccountInfoParameters {
    char *encodeData;
    struct CChainVersion *chainVersion;
} CDecodeAccountInfoParameters;

typedef struct CAccountInfo {
    uint32_t nonce;
    uint32_t ref_count;
    char *free_;
    char *reserved;
    char *misc_frozen;
    char *fee_frozen;
} CAccountInfo;

typedef struct CStorageKeyParameters {
    struct CChainVersion *chainVersion;
    char *module;
    char *storageItem;
    char *account;
} CStorageKeyParameters;

typedef struct CEeeTransferPayload {
    char *fromAccount;
    char *toAccount;
    char *value;
    uint32_t index;
    struct CChainVersion *chainVersion;
    char *extData;
    char *password;
} CEeeTransferPayload;

typedef struct CRawTxParam {
    char *rawTx;
    char *walletId;
    char *password;
} CRawTxParam;

typedef uint32_t CBool;

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
typedef struct CArrayCContext {
    struct CContext *ptr;
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
    struct CAddress *walletAddress;
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
    struct CTokenShared *tokenShared;
} CEthChainTokenShared;

typedef struct CEthChainToken {
    struct CEthChainTokenShared *ethChainTokenShared;
} CEthChainToken;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayCEthChainToken {
    struct CEthChainToken *ptr;
    CU64 len;
    CU64 cap;
} CArrayCEthChainToken;

typedef struct CEthChain {
    struct CChainShared *chainShared;
    struct CArrayCEthChainToken *tokens;
} CEthChain;

typedef struct CEeeChainTokenShared {
    struct CTokenShared *tokenShared;
} CEeeChainTokenShared;

typedef struct CEeeChainToken {
    struct CEeeChainTokenShared *eeeChainTokenShared;
} CEeeChainToken;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayCEeeChainToken {
    struct CEeeChainToken *ptr;
    CU64 len;
    CU64 cap;
} CArrayCEeeChainToken;

typedef struct CEeeChain {
    struct CChainShared *chainShared;
    struct CAddress *address;
    struct CArrayCEeeChainToken *tokens;
} CEeeChain;

typedef struct CBtcChainTokenShared {
    struct CTokenShared *tokenShared;
} CBtcChainTokenShared;

typedef struct CBtcChainToken {
    struct CBtcChainTokenShared *btcChainTokenShared;
} CBtcChainToken;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayCBtcChainToken {
    struct CBtcChainToken *ptr;
    CU64 len;
    CU64 cap;
} CArrayCBtcChainToken;

typedef struct CBtcChain {
    struct CChainShared *chainShared;
    struct CArrayCBtcChainToken *tokens;
} CBtcChain;

typedef struct CWallet {
    char *id;
    char *nextId;
    char *name;
    struct CEthChain *ethChain;
    struct CEeeChain *eeeChain;
    struct CBtcChain *btcChain;
} CWallet;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayCWallet {
    struct CWallet *ptr;
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

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayCChar {
    char **ptr;
    CU64 len;
    CU64 cap;
} CArrayCChar;

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

typedef struct CInitParameters {
    struct CDbName *dbName;
    char *contextNote;
} CInitParameters;

typedef struct CCreateWalletParameters {
    char *name;
    char *password;
    char *mnemonic;
    char *walletType;
} CCreateWalletParameters;

#define CFalse 1

#define CTrue 0

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

const struct CError *ChainEee_updateSyncRecord(struct CContext *ctx, char *netType, struct CAccountInfoSyncProg *syncRecord);

const struct CError *ChainEee_getSyncRecord(struct CContext *ctx, char *netType, char *account, struct CAccountInfoSyncProg **syncRecord);

const struct CError *ChainEee_decodeAccountInfo(struct CContext *ctx, char *netType, struct CDecodeAccountInfoParameters *parameters, struct CAccountInfo **accountInfo);

const struct CError *ChainEee_getStorageKey(struct CContext *ctx, char *netType, struct CStorageKeyParameters *parameters, char **key);

const struct CError *ChainEee_eeeTransfer(struct CContext *ctx, char *netType, struct CEeeTransferPayload *transferPayload, char **signedResult);

const struct CError *ChainEee_tokenXTransfer(struct CContext *ctx, char *netType, struct CEeeTransferPayload *transferPayload, char **signedResult);

const struct CError *ChainEee_txSubmittableSign(struct CContext *ctx, char *netType, struct CRawTxParam *rawTx, char **signedResult);

const struct CError *ChainEee_txSign(struct CContext *ctx, char *netType, struct CRawTxParam *rawTx, char **signedResult);

const struct CError *ChainEee_updateBasicInfo(struct CContext *ctx, char *netType, struct CSubChainBasicInfo *basicInfo);

const struct CError *ChainEee_getBasicInfo(struct CContext *ctx, char *netType, struct CChainVersion *chainVersion, struct CSubChainBasicInfo **basicInfo);

/**
 * alloc ** [parameters::CContext]
 */
struct CContext **CContext_dAlloc(void);

/**
 * free ** [parameters::CContext]
 */
void CContext_dFree(struct CContext **dPtr);

/**
 * alloc ** [CArray]
 */
struct CArrayCContext **CArrayCContext_dAlloc(void);

void CArrayCContext_dFree(struct CArrayCContext **dPtr);

void CStr_dFree(char **dcs);

char **CStr_dAlloc(void);

void CBool_dFree(CBool **dcs);

CBool **CBool_dAlloc(void);

void CError_free(struct CError *error);

struct CWallet **CWallet_dAlloc(void);

void CWallet_dFree(struct CWallet **dPtr);

struct CArrayCWallet **CArrayCWallet_dAlloc(void);

void CArrayCWallet_dFree(struct CArrayCWallet **dPtr);

struct CDbName **CDbName_dAlloc(void);

void CDbName_dFree(struct CDbName **dPtr);

struct CArrayI64 **CArrayInt64_dAlloc(void);

void CArrayInt64_dFree(struct CArrayI64 **dPtr);

struct CAccountInfoSyncProg **CAccountInfoSyncProg_dAlloc(void);

struct CAccountInfo **CAccountInfo_dAlloc(void);

void CAccountInfo_dFree(struct CAccountInfo **dPtr);

struct CSubChainBasicInfo **CSubChainBasicInfo_dAlloc(void);

void CSubChainBasicInfo_dFree(struct CSubChainBasicInfo **dPtr);

struct CArrayCChar **CArrayCChar_dAlloc(void);

void CArrayCChar_dFree(struct CArrayCChar **dPtr);

const struct CError *ChainEth_decodeAdditionData(struct CContext *ctx, char *encodeData, char **additionData);

const struct CError *ChainEth_txSign(struct CContext *ctx, char *netType, struct CEthTransferPayload *txPayload, char *password, char **signResult);

const struct CError *ChainEth_rawTxSign(struct CContext *ctx, char *netType, struct CEthRawTxPayload *rawTxPayload, char *password, char **signResult);

/**
 * 生成数据库文件名，只有数据库文件名不存在（为null或“”）时才创建文件名
 * 如果成功返回 [wallets_types::Error::SUCCESS()]
 */
const struct CError *Wallets_dbName(struct CDbName *name, struct CDbName **outName);

/**
 * 如果成功返回 [wallets_types::Error::SUCCESS()]
 */
const struct CError *Wallets_init(struct CInitParameters *parameter, struct CContext **context);

/**
 * 如果成功返回 [wallets_types::Error::SUCCESS()]
 */
const struct CError *Wallets_uninit(struct CContext *ctx);

/**
 * 返回所有的Context, 有可能是0个
 * 如果成功返回 [wallets_types::Error::SUCCESS()]
 */
const struct CError *Wallets_Contexts(struct CArrayCContext **contexts);

/**
 * 返回最后的Context, 有可能是空值
 * 如果成功返回 [wallets_types::Error::SUCCESS()]
 */
const struct CError *Wallets_lastContext(struct CContext **context);

/**
 * 返回第一个Context, 有可能是空值
 * 如果成功返回 [wallets_types::Error::SUCCESS()]
 */
const struct CError *Wallets_firstContext(struct CContext **context);

const struct CError *Wallets_lockRead(struct CContext *ctx);

const struct CError *Wallets_unlockRead(struct CContext *ctx);

const struct CError *Wallets_lockWrite(struct CContext *ctx);

const struct CError *Wallets_unlockWrite(struct CContext *ctx);

const struct CError *Wallets_all(struct CContext *ctx, struct CArrayCWallet **arrayWallet);

const struct CError *Wallets_generateMnemonic(char **mnemonic);

const struct CError *Wallets_createWallet(struct CContext *ctx, struct CCreateWalletParameters *parameters, struct CWallet **wallet);

const struct CError *Wallets_removeWallet(struct CContext *ctx, char *walletId);

const struct CError *Wallets_renameWallet(struct CContext *ctx, char *newName, char *walletId);

/**
 * 只有到CError为 Error::SUCCESS()时返值才有意义
 * 返回值 hasAny: true表示至少有一个; Fail: false，没有
 */
const struct CError *Wallets_hasAny(struct CContext *ctx, CBool *hasAny);

const struct CError *Wallets_findById(struct CContext *ctx, char *walletId, struct CWallet **wallet);

/**
 *注：只加载了wallet的id name等直接的基本数据，子对象（如链）的数据没有加载
 */
const struct CError *Wallets_findWalletBaseByName(struct CContext *ctx, char *name, struct CArrayCWallet **walletArray);

/**
 * 查询当前wallet 与 chain
 */
const struct CError *Wallets_currentWalletChain(struct CContext *ctx, char **walletId, char **chainType);

/**
 *保存当前wallet 与 chain
 */
const struct CError *Wallets_saveCurrentWalletChain(struct CContext *ctx, char *walletId, char *chainType);

#ifdef __cplusplus
} // extern "C"
#endif // __cplusplus
