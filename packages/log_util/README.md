# log_util

一个log日志组件。
## Getting Started

### 其他package项目引用说明
1. 在 dev_dependencies下面, 加入log_util引用，格式如下所示:
```
dev_dependencies:
  log_util:
    path: ../log_util
```
2. 在具体文件内使用：
-   生成log文件
    -   // 可选参数logFileName---log文件名.      默认值cashbox.log
    -   // 默认日志生成的文件名，格式为： “日期+cashbox”. eg 2020_01_01_cashbox.log
    -   // 根据日期，每天生成一个新的log文件
```
import 'package:log_util/log_util.dart';

LogUtil logUtil = new LogUtil();
// LogUtil logUtil = LogUtil(logFileName: "123test");
// LogUtil.instance().d("tag", "message");
// LogUtil.instance(logFileName: "123test").d("tag", "message");
```

-   使用log
```
    logUtil.e("testTag", "TestMessage"); // param1 ： Tag名称， param2： 具体信息
    输出内容能显示在控制台，和log文件中保存
```

-   清除log文件
```
    log.clearObsoleteFiles(fileRetainDays: 8);
    可选参数fileRetainDays，默认值为：10
    设置fileRetainDays，来保存fileRetainDays天数以内的日志文件。如今天20210127，参数为7，即20210120前的log文件，全会被清除。
```
