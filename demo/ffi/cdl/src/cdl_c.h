#pragma once

/* Generated with cbindgen:0.24.5 */

#include <stdint.h>

typedef struct Data {
    int intType;
    char *charType;
    int *arrayInt;
    unsigned long long arrayIntLength;
    struct Data *arrayData;
    unsigned long long arrayDataLength;
    struct Data *pointData;
} Data;

typedef uint64_t CU64;

/**
 * c的数组需要定义两个字段，所定义一个结构体进行统一管理
 * 注：c不支持范型，所以cbindgen工具会使用具体的类型来代替
 */
typedef struct CArrayCChar {
    char **ptr;
    CU64 len;
    CU64 cap;
} CArrayCChar;

typedef struct CSample {
    uint32_t len;
    char *name;
    struct CArrayCChar list;
} CSample;

typedef uint32_t CBool;

#define CFalse 0u

#define CTrue 1u

#ifdef __cplusplus
extern "C" {
#endif // __cplusplus

int add(int a, int b);

uint32_t multi_i32(int32_t **v);

char *addStr(char *cs);

void Str_free(char *cs);

struct Data *Data_new(void);

void Data_free(struct Data *cd);

struct Data *Data_use(struct Data *cd);

struct Data Data_noPtr(void);

struct CSample **CSample_dAlloc(void);

void CSample_dFree(struct CSample **ptr);

void CSample_create(struct CSample **ptr);

#ifdef __cplusplus
} // extern "C"
#endif // __cplusplus
