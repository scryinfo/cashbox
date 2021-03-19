# 数据库名称说明

按数据库在程序中使用的目的，划分为`data`,`detail`,`mnemonic`三种类型的数据库，具体使用场景为：

- `mnemonic`: 助记词，主要用于备份
- `detail`: wallet等不同网络类型中共同的部分
- `data`: 链上数据，比如获取链上的交易记录，