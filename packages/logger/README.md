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
    -   // 可选参数logFileName---log文件名.      默认值cashbox.log

初始化示例代码如下：
```
import 'package:logger/logger.dart';

Logger logger = new Logger();
Logger logger = new Logger(logFileName: "123test");
logger.d("tag999", " message999", isSave2File: false);
// logger().d("tag", "message");
```
-   参数 logFileName
    -   实例化对象时，通过方法名logFileName，可自定义log的文件名

使用log
```
    logger.e("testTag", "TestMessage"); // param1 ： Tag名称， param2： 具体信息
    logger.d("testTag1", "TestMessage1");
    输出内容能显示在控制台，和log文件中保存
```
-   参数 isSave2File
    -   调用日志输出时，通过参数isSave2File的值。为true时，可输出到控制台+文件，false只输出到控制台。 默认值：true

-   参数 日志等级 d/i/w/e
    -   在flutter中使用时，所有print输出到控制台的，默认等级是info级别。
    -   此处加入等级，是为了方便查看在日志文件中，区分日志等级来筛选使用的。