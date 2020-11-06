

int add(int a, int b);

//调用函数Str_free 释放内存返回的字符
char *addStr(char *cs);

//释放由动态库分配的内存
void Str_free(char *cs);


typedef struct Data {
    int intType;
    char *charType;

    int *arrayInt;
    unsigned long long arrayIntLength;

    struct Data *arrayData;
    unsigned long long arrayDataLength;

    struct Data *pointData;
} Data;

Data *Data_new();

void Data_free(Data *cd);

Data *Data_use(Data *cd);