#pragma once

/* Generated with cbindgen:0.15.0 */

#include <stdint.h>

typedef uint64_t CU64;

typedef struct CError {
    CU64 code;
    char *message;
} CError;

typedef uint16_t CBool;

typedef struct InitParameters {
    uint64_t code;
} InitParameters;

typedef struct UnInitParameters {
    uint64_t code;
} UnInitParameters;

#define CFalse 0

#define CTrue 1

#define Success 0

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

void CChar_free(char *cs);

void CError_free(CError *error);

CBool Wallets_lockRead(void);

CBool Wallets_unlockRead(void);

CBool Wallets_lockWrite(void);

CBool Wallets_unlockWrite(void);

const CError *Wallets_init(InitParameters *params);

const CError *Wallets_uninit(UnInitParameters *params);

#ifdef __cplusplus
} // extern "C"
#endif // __cplusplus
