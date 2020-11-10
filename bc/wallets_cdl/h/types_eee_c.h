//
// Created by Peace on 11/10/2020.
//

#ifndef BC_TYPES_EEE_C_H
#define BC_TYPES_EEE_C_H

#include "./types_c.h"

// eee
typedef struct EeeChainToken {
    TokenShared* tokenShared;
}EeeChainToken;

typedef struct EeeChain {
    ChainShared* chainShared;
    Address*        address;
    EeeChainToken*  tokens;
    CU64 tokensLength;
}EeeChain;

#endif //BC_TYPES_EEE_C_H
