//
// Created by Peace on 11/10/2020.
//

#ifndef BC_TYPES_ETH_C_H
#define BC_TYPES_ETH_C_H

#include "./types_c.h"

// eth
typedef struct EthChainToken {
    TokenShared* tokenShared;
}EthChainToken;

typedef struct EthChainTokenDefault {
    TokenShared* tokenShared;
}EthChainTokenDefault;

typedef struct EthChainTokenAuth {
    TokenShared* tokenShared;
}EthChainTokenAuth;

typedef struct EthChain {
    ChainShared* chain_shared;
    EthChainToken* tokens;
    CU64 tokens_length;
}EthChain;

#endif //BC_TYPES_ETH_C_H
