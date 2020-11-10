//
// Created by Peace on 11/10/2020.
//

#ifndef BC_WALLETS_C_H
#define BC_WALLETS_C_H

#include "./types_c.h"

CBool Wallets_lockRead();
CBool Wallets_unlockRead();
CBool Wallets_lockWrite();
CBool Wallets_unlockWrite();

typedef struct InitParameters {

} InitParameters;
const CError* Wallets_init(const InitParameters * params);

typedef struct UnInitParameters {

} UnInitParameters;
const CError* Wallets_uninit(const UnInitParameters * params);
#endif //BC_WALLETS_C_H
