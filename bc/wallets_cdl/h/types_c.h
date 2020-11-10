//
// Created by Peace on 11/10/2020.
//

#ifndef BC_TYPES_C_H
#define BC_TYPES_C_H

typedef unsigned short CBool;
const CBool CFalse = 0;
const CBool CTrue = 1;
typedef unsigned long long CU64;

typedef struct CError{
    CU64 code;
    char * message;
} CError;
const CU64 Success = 0;
void CError_free(CError * error);

struct EthChain;
typedef struct EthChain EthChain;
struct EeeChain;
typedef struct EeeChain EeeChain;
struct BtcChain;
typedef struct BtcChain BtcChain;

typedef struct Wallet {
    char* id;
    char* nextId;
    EthChain * ethChains;
    EeeChain * eeeChains;
    BtcChain * btcChains;
}Wallet;

typedef struct Address {
    char* id;
    char*  walletId;
    char* chainType;
    char*  address;
    char*  publicKey;
}Address;

typedef struct TokenShared {
    char*  id;
    char*  nextId;
    char*  name;
    char*  symbol;
}TokenShared;

typedef struct ChainShared {
    char*  id;
    char*  walletId;
    char*  chainType;
    /// 钱包地址
    Address* walletAddress;
}ChainShared;


#endif //BC_TYPES_C_H
