# logger
功能说明： 一个log日志组件。

## Getting Started

### 部分功能原理说明：

#### log日志文件名生成规则：
默认文件名cashbox.log，可在实例化对象的时候，传入参数，来自定义文件名

#### log日志的写入和清理规则：
1. 默认根据文件名，只使用2个日志文件。（假如给的文件名是cashbox.log。则只有cashbox.log和cashbox.log.backup文件）
2. 默认先写入命名文件，如cashbox.log文件中，此次写入结束时，判断如果当前文件大小超过给定的限制大小。清空另一个文件（此时是清除cashbox.log.backup文件），开始往另一个文件里面写。
同规则，当此场景下cashbox.log.backup文件也写满时，清空cashbox.log文件，下次开始往cashbox.log里面写入内容。 依次循环清空文件，写入。

### 使用说明：
1. 在其他package项目的pubspec.yaml配置文件中，在 dependencies下面, 加入logger引用，格式如下所示:
```
dev_dependencies:
  logger:
    path: ../logger
```
2. 在具体文件内使用：
-   生成log文件
    -   可选参数logFileName---log文件名.      默认值cashbox.log

初始化示例代码如下：
```
import 'package:logger/logger.dart';

Logger logger = new Logger();
Logger logger = new Logger(logFileName: "123test");
logger.initConfig();           //***切记执行这行***
logger.d("tag999", " message999", isSave2File: false);
logger().d("tag", "message");
```
-   initConfig()
    -   ***必须执行 此方法***
    -   通过config()方法注册一个唯一的新线程，其他在调用日志输出的方法，都会调用到这个唯一线程来操作。
    -   通过唯一线程，来支持多线程使用logger实例。

-   参数 logFileName
    -   实例化对象时，通过方法名logFileName，可自定义log的文件名

使用log
```
    logger.e("testTag", "TestMessage"); // param1 ： Tag名称， param2： 具体信息
    logger.d("testTag1", "TestMessage1");
    输出内容，能显示在控制台，和在log文件中保存
```
-   参数 isSave2File
    -   调用日志输出时，通过参数isSave2File的值。为true时，可输出到控制台+文件，false只输出到控制台。 默认值：true

-   参数 日志等级 d/i/w/e
    -   在flutter中使用时，所有print输出，都会显示在控制台，日志等级是info级别。
    -   此处调用时，加入日志等级，是为了方便在查看日志文件时，根据日志等级来筛选使用的。
