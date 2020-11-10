//
// Created by Peace on 11/10/2020.
//

#ifndef BC_TYPES_BTC_C_H
#define BC_TYPES_BTC_C_H

#include "./types_c.h"
#include "./chain_btc_c.h"

// btc
typedef struct BtcChainToken {
    TokenShared* tokenShared;
}BtcChainToken;

typedef struct BtcChain {
    ChainShared* chainShared;
    BtcChainToken* tokens;
    CU64 tokensLength;
}BtcChain;

// btc end

#endif //BC_TYPES_BTC_C_H
