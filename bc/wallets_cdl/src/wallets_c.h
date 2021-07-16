#pragma once

/* Generated with cbindgen:0.18.0 */

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
    struct CContext *ptr;
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
    CBool isWalletAddress;
    CBool show;
} CAddress;

typedef struct CChainShared {
    char *walletId;
    char *chainType;
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
    char *tokenType;
    int64_t gasLimit;
    char *gasPrice;
    int32_t decimal;
} CEthChainTokenShared;

typedef struct CEthChainToken {
    char *chainTokenSharedId;
    CBool show;
    char *contractAddress;
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
    char *tokenType;
    int64_t gasLimit;
    char *gasPrice;
    int32_t decimal;
} CEeeChainTokenShared;

typedef struct CEeeChainToken {
    CBool show;
    char *chainTokenSharedId;
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
    struct CArrayCEeeChainToken *tokens;
} CEeeChain;

typedef struct CBtcChainTokenShared {
    struct CTokenShared *tokenShared;
    char *tokenType;
    int64_t fee_per_byte;
    int32_t decimal;
} CBtcChainTokenShared;

typedef struct CBtcChainToken {
    CBool show;
    char *chainTokenSharedId;
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
    char *walletType;
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

typedef struct CChainVersion {
    char *genesisHash;
    int32_t runtimeVersion;
    int32_t txVersion;
} CChainVersion;

typedef struct CExtrinsicContext {
    struct CChainVersion *chainVersion;
    char *account;
    char *blockHash;
    char *blockNumber;
    char *event;
    struct CArrayCChar *extrinsics;
} CExtrinsicContext;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayCExtrinsicContext {
    struct CExtrinsicContext *ptr;
    CU64 len;
    CU64 cap;
} CArrayCExtrinsicContext;

typedef struct CTokenAddress {
    char *walletId;
    char *chainType;
    char *tokenId;
    char *addressId;
    char *balance;
} CTokenAddress;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayCTokenAddress {
    struct CTokenAddress *ptr;
    CU64 len;
    CU64 cap;
} CArrayCTokenAddress;

typedef struct CEthChainTokenAuth {
    char *chainTokenSharedId;
    char *netType;
    int64_t position;
    char *contractAddress;
    struct CEthChainTokenShared *ethChainTokenShared;
} CEthChainTokenAuth;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayCEthChainTokenAuth {
    struct CEthChainTokenAuth *ptr;
    CU64 len;
    CU64 cap;
} CArrayCEthChainTokenAuth;

typedef struct CEthChainTokenNonAuth {
    char *chainTokenSharedId;
    char *netType;
    int64_t position;
    char *contractAddress;
    struct CEthChainTokenShared *ethChainTokenShared;
} CEthChainTokenNonAuth;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayCEthChainTokenNonAuth {
    struct CEthChainTokenNonAuth *ptr;
    CU64 len;
    CU64 cap;
} CArrayCEthChainTokenNonAuth;

typedef struct CEthChainTokenDefault {
    char *chainTokenSharedId;
    char *netType;
    int64_t position;
    char *contractAddress;
    struct CEthChainTokenShared *ethChainTokenShared;
} CEthChainTokenDefault;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayCEthChainTokenDefault {
    struct CEthChainTokenDefault *ptr;
    CU64 len;
    CU64 cap;
} CArrayCEthChainTokenDefault;

typedef struct CEeeChainTokenDefault {
    char *chainTokenSharedId;
    char *netType;
    int64_t position;
    struct CEeeChainTokenShared *eeeChainTokenShared;
} CEeeChainTokenDefault;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayCEeeChainTokenDefault {
    struct CEeeChainTokenDefault *ptr;
    CU64 len;
    CU64 cap;
} CArrayCEeeChainTokenDefault;

typedef struct CBtcChainTokenDefault {
    char *chainTokenSharedId;
    char *netType;
    int64_t position;
    struct CBtcChainTokenShared *btcChainTokenShared;
} CBtcChainTokenDefault;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayCBtcChainTokenDefault {
    struct CBtcChainTokenDefault *ptr;
    CU64 len;
    CU64 cap;
} CArrayCBtcChainTokenDefault;

typedef struct CEeeChainTokenAuth {
    char *chainTokenSharedId;
    char *netType;
    int64_t position;
    struct CEeeChainTokenShared *eeeChainTokenShared;
} CEeeChainTokenAuth;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayCEeeChainTokenAuth {
    struct CEeeChainTokenAuth *ptr;
    CU64 len;
    CU64 cap;
} CArrayCEeeChainTokenAuth;

typedef struct CBtcChainTokenAuth {
    char *chainTokenSharedId;
    char *netType;
    int64_t position;
    struct CBtcChainTokenShared *btcChainTokenShared;
} CBtcChainTokenAuth;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayCBtcChainTokenAuth {
    struct CBtcChainTokenAuth *ptr;
    CU64 len;
    CU64 cap;
} CArrayCBtcChainTokenAuth;

typedef struct CEeeChainTx {
    char *txHash;
    char *blockHash;
    char *blockNumber;
    char *signer;
    char *walletAccount;
    char *fromAddress;
    char *toAddress;
    char *value;
    char *extension;
    CBool status;
    int64_t txTimestamp;
    char *txBytes;
} CEeeChainTx;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayCEeeChainTx {
    struct CEeeChainTx *ptr;
    CU64 len;
    CU64 cap;
} CArrayCEeeChainTx;

typedef struct CWalletTokenStatus {
    char *walletId;
    char *chainType;
    char *tokenId;
    CBool isShow;
} CWalletTokenStatus;

typedef struct CBtcNowLoadBlock {
    uint64_t height;
    char *headerHash;
    char *timestamp;
} CBtcNowLoadBlock;

typedef struct CBtcBalance {
    uint64_t balance;
    uint64_t height;
} CBtcBalance;

typedef struct CEthWalletConnectTx {
    char *from;
    char *to;
    char *data;
    char *gasPrice;
    char *gas;
    char *value;
    char *nonce;
    char *maxPriorityFeePerGas;
    uint32_t typeTxId;
} CEthWalletConnectTx;

typedef struct CInitParameters {
    struct CDbName *dbName;
    CBool isMemoryDb;
    char *contextNote;
} CInitParameters;

typedef struct CCreateWalletParameters {
    char *name;
    char *password;
    char *mnemonic;
    char *walletType;
} CCreateWalletParameters;

typedef struct CBtcTxParam {
    char *walletId;
    char *password;
    char *from_address;
    char *to_address;
    char *value;
    CBool broadcast;
} CBtcTxParam;

typedef struct CDecodeAccountInfoParameters {
    char *encodeData;
    struct CChainVersion *chainVersion;
} CDecodeAccountInfoParameters;

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

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

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

void CStr_free(char *dcs);

void CStr_dFree(char **dcs);

char **CStr_dAlloc(void);

void CBool_free(CBool *dcs);

CBool *CBool_alloc(void);

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

void CAccountInfoSyncProg_dFree(struct CAccountInfoSyncProg **dPtr);

struct CAccountInfo **CAccountInfo_dAlloc(void);

void CAccountInfo_dFree(struct CAccountInfo **dPtr);

struct CSubChainBasicInfo **CSubChainBasicInfo_dAlloc(void);

void CSubChainBasicInfo_dFree(struct CSubChainBasicInfo **dPtr);

struct CArrayCChar **CArrayCChar_dAlloc(void);

void CArrayCChar_dFree(struct CArrayCChar **dPtr);

struct CArrayCExtrinsicContext **CExtrinsicContext_dAlloc(void);

void CExtrinsicContext_dFree(struct CArrayCExtrinsicContext **dPtr);

struct CArrayCTokenAddress **CArrayCTokenAddress_dAlloc(void);

void CArrayCTokenAddress_dFree(struct CArrayCTokenAddress **dPtr);

struct CArrayCEthChainTokenAuth **CArrayCEthChainTokenAuth_dAlloc(void);

void CArrayCEthChainTokenAuth_dFree(struct CArrayCEthChainTokenAuth **dPtr);

struct CArrayCEthChainTokenNonAuth **CArrayCEthChainTokenNonAuth_dAlloc(void);

void CArrayCEthChainTokenNonAuth_dFree(struct CArrayCEthChainTokenNonAuth **dPtr);

struct CArrayCEthChainTokenDefault **CArrayCEthChainTokenDefault_dAlloc(void);

void CArrayCEthChainTokenDefault_dFree(struct CArrayCEthChainTokenDefault **dPtr);

struct CArrayCEeeChainTokenDefault **CArrayCEeeChainTokenDefault_dAlloc(void);

void CArrayCEeeChainTokenDefault_dFree(struct CArrayCEeeChainTokenDefault **dPtr);

struct CArrayCBtcChainTokenDefault **CArrayCBtcChainTokenDefault_dAlloc(void);

void CArrayCBtcChainTokenDefault_dFree(struct CArrayCBtcChainTokenDefault **dPtr);

struct CArrayCEeeChainTokenAuth **CArrayCEeeChainTokenAuth_dAlloc(void);

void CArrayCEeeChainTokenAuth_dFree(struct CArrayCEeeChainTokenAuth **dPtr);

struct CArrayCBtcChainTokenAuth **CArrayCBtcChainTokenAuth_dAlloc(void);

void CArrayCBtcChainTokenAuth_dFree(struct CArrayCBtcChainTokenAuth **dPtr);

struct CArrayCEeeChainTx **CArrayCEeeChainTx_dAlloc(void);

void CArrayCEeeChainTx_dFree(struct CArrayCEeeChainTx **dPtr);

struct CWalletTokenStatus **CWalletTokenStatus_dAlloc(void);

void CWalletTokenStatus_dFree(struct CWalletTokenStatus **dPtr);

struct CBtcNowLoadBlock **CBtcNowLoadBlock_dAlloc(void);

void CBtcNowLoadBlock_dFree(struct CBtcNowLoadBlock **dPtr);

struct CBtcBalance **CBtcBalance_dAlloc(void);

void CBtcBalance_dFree(struct CBtcBalance **dPtr);

struct CEthWalletConnectTx **CEthWalletConnectTx_dAlloc(void);

void CEthWalletConnectTx_dFree(struct CEthWalletConnectTx **dPtr);

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

const struct CError *Wallets_changeNetType(struct CContext *ctx, char *netType);

const struct CError *Wallets_getCurrentNetType(struct CContext *ctx, char **netType);

const struct CError *Wallets_all(struct CContext *ctx, struct CArrayCWallet **arrayWallet);

const struct CError *Wallets_generateMnemonic(unsigned int mnemonic_num, char **mnemonic);

const struct CError *Wallets_createWallet(struct CContext *ctx, struct CCreateWalletParameters *parameters, struct CWallet **wallet);

const struct CError *Wallets_removeWallet(struct CContext *ctx, char *walletId, char *password);

const struct CError *Wallets_exportWallet(struct CContext *ctx, char *walletId, char *password, char **mnemonic);

const struct CError *Wallets_resetWalletPassword(struct CContext *ctx, char *walletId, char *oldPsd, char *newPsd);

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

/**
 * 返回 AppPlatformType
 */
const char *Wallets_appPlatformType(void);

/**
 * 返回 package version
 */
const char *Wallets_packageVersion(void);

const struct CError *Wallets_queryBalance(struct CContext *ctx, char *walletId, struct CArrayCTokenAddress **tokenAddress);

const struct CError *Wallets_updateBalance(struct CContext *ctx, struct CTokenAddress *tokenAddress);

const struct CError *Wallets_changeTokenShowState(struct CContext *ctx, struct CWalletTokenStatus *tokenStatus);

const struct CError *ChainBtc_updateDefaultTokenList(struct CContext *ctx, struct CArrayCBtcChainTokenDefault *defaultTokens);

const struct CError *ChainBtc_updateAuthDigitList(struct CContext *ctx, struct CArrayCBtcChainTokenAuth *authTokens);

const struct CError *ChainBtc_getAuthTokenList(struct CContext *ctx, unsigned int startItem, unsigned int pageSize, struct CArrayCBtcChainTokenAuth **tokens);

const struct CError *ChainBtc_getDefaultTokenList(struct CContext *ctx, struct CArrayCBtcChainTokenDefault **tokens);

const struct CError *ChainBtc_start(struct CContext *ctx, char *walletId);

const struct CError *ChainBtc_loadNowBlockNumber(struct CContext *ctx, struct CBtcNowLoadBlock **block);

const struct CError *ChainBtc_loadBalance(struct CContext *ctx, struct CBtcBalance **balance);

const struct CError *ChainBtc_txSign(struct CContext *ctx, struct CBtcTxParam *param, char **signedResult);

const struct CError *ChainEee_updateSyncRecord(struct CContext *ctx, struct CAccountInfoSyncProg *syncRecord);

const struct CError *ChainEee_getSyncRecord(struct CContext *ctx, char *account, struct CAccountInfoSyncProg **syncRecord);

const struct CError *ChainEee_decodeAccountInfo(struct CContext *ctx, struct CDecodeAccountInfoParameters *parameters, struct CAccountInfo **accountInfo);

const struct CError *ChainEee_getStorageKey(struct CContext *ctx, struct CStorageKeyParameters *parameters, char **key);

const struct CError *ChainEee_eeeTransfer(struct CContext *ctx, struct CEeeTransferPayload *transferPayload, char **signedResult);

const struct CError *ChainEee_tokenXTransfer(struct CContext *ctx, struct CEeeTransferPayload *transferPayload, char **signedResult);

const struct CError *ChainEee_txSubmittableSign(struct CContext *ctx, struct CRawTxParam *rawTx, char **signedResult);

const struct CError *ChainEee_txSign(struct CContext *ctx, struct CRawTxParam *rawTx, char **signedResult);

const struct CError *ChainEee_updateBasicInfo(struct CContext *ctx, struct CSubChainBasicInfo *basicInfo);

const struct CError *ChainEee_getDefaultBasicInfo(struct CContext *ctx, struct CSubChainBasicInfo **basicInfo);

const struct CError *ChainEee_getBasicInfo(struct CContext *ctx, struct CChainVersion *chainVersion, struct CSubChainBasicInfo **basicInfo);

const struct CError *ChainEee_saveExtrinsicDetail(struct CContext *ctx, struct CExtrinsicContext *extrinsicCtx);

const struct CError *ChainEee_queryChainTxRecord(struct CContext *ctx, char *account, unsigned int startItem, unsigned int pageSize, struct CArrayCEeeChainTx **records);

const struct CError *ChainEee_queryTokenxTxRecord(struct CContext *ctx, char *account, unsigned int startItem, unsigned int pageSize, struct CArrayCEeeChainTx **records);

const struct CError *ChainEee_updateAuthDigitList(struct CContext *ctx, struct CArrayCEeeChainTokenAuth *authTokens);

const struct CError *ChainEee_updateDefaultTokenList(struct CContext *ctx, struct CArrayCEeeChainTokenDefault *defaultTokens);

const struct CError *ChainEee_getAuthTokenList(struct CContext *ctx, unsigned int startItem, unsigned int pageSize, struct CArrayCEeeChainTokenAuth **tokens);

const struct CError *ChainEee_getDefaultTokenList(struct CContext *ctx, struct CArrayCEeeChainTokenDefault **tokens);

const struct CError *ChainEth_decodeAdditionData(struct CContext *ctx, char *encodeData, char **additionData);

const struct CError *ChainEth_txSign(struct CContext *ctx, struct CEthTransferPayload *txPayload, char *password, char **signResult);

const struct CError *ChainEth_rawTxSign(struct CContext *ctx, struct CEthRawTxPayload *rawTxPayload, char *password, char **signResult);

const struct CError *ChainEth_walletConnectTxSign(struct CContext *ctx, struct CEthWalletConnectTx *wallet_connect_tx, char *password, char **signResult);

const struct CError *ChainEth_updateAuthTokenList(struct CContext *ctx, struct CArrayCEthChainTokenAuth *authTokens);

const struct CError *ChainEth_getAuthTokenList(struct CContext *ctx, unsigned int startItem, unsigned int pageSize, struct CArrayCEthChainTokenAuth **tokens);

const struct CError *ChainEth_updateDefaultTokenList(struct CContext *ctx, struct CArrayCEthChainTokenDefault *defaultTokens);

const struct CError *ChainEth_getDefaultTokenList(struct CContext *ctx, struct CArrayCEthChainTokenDefault **tokens);

const struct CError *ChainEth_updateNonAuthTokenList(struct CContext *ctx, struct CArrayCEthChainTokenNonAuth *tokens);

const struct CError *ChainEth_getNonAuthTokenList(struct CContext *ctx, struct CArrayCEthChainTokenNonAuth **tokens);

const struct CError *ChainEth_queryAuthTokenList(struct CContext *ctx, char *tokenName, char *contract, unsigned int startItem, unsigned int pageSize, struct CArrayCEthChainTokenAuth **tokens);

#ifdef __cplusplus
} // extern "C"
#endif // __cplusplus
