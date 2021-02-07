# logger
功能说明： 一个log日志组件。
1. 日志信息可打印到控制台（用于开发调试）。
2. 日志信息可保存在文件里面（信息收集，可供用户反馈信息）。
3. 支持单线程中，多处调用时，只有一个实例。
4. 支持多线程调用时，一个线程中只有一个logger实例。
5. 唯一日志线程：写日志的动作，全部由唯一的日志线程来操作。 各处logger调用时，都会排队写入到日志线程，由日志线程来执行具体的写入操作。
6. 会生成两个日志文件。 cashbox.log和cashbox.log.backup文件。 最新的内容写入到cashbox.log里面，每次写完后判断文件大小超过30M后，交换cashbox.log和cashbox.log.backup文件名，清空cashbox.log内容，继续往cashbox.log里面写入内容。
7. 可控制是否输出日志内容到日志文件。 同时实现，懒注册(lazy register)日志线程功能，只有在判断确实需要写日志文件时，才会注册开启唯一日志线程。
8. 可设置日志级别，来控制日志输出内容。 如：设置info级别时，不会输出debug级别。

## Getting Started

### 使用说明
1. 在其他package项目的pubspec.yaml配置文件中，在dependencies下面, 加入logger引用，格式如下所示:
```
dev_dependencies:
  logger:
    path: ../logger
```
2. 在具体文件内使用
初始化示例代码如下：
-   使用方法1
    -   param1 ： Tag名称， param2 ： 具体信息
```
import 'package:logger/logger.dart';

Logger logger = new Logger();
logger.d("tag999", " message999", isSave2File: false);
logger().d("tag", "message");
```

-   使用方法2

```Logger.getInstance().setLogLevel(LogLevel.Debug); ```

-   使用方法3

```Logger.getInstance().setLogLevel(LogLevel.Debug).d("flutter test demo tag", " d | message------>" + index.toString()); ```

-   方法 setLogLevel(filterLogLevel)
    -   设置限制log输出的日志级别。如level为info的时候，比info级别低的debug级别，就不会输出出来。即>= filterLogLevel的日志可以输出
    
-   参数 isSave2File
    -   调用日志输出时，通过参数isSave2File的值。为true时，可输出到控制台+文件，false只输出到控制台。 默认值：true

-   参数 日志等级 d/i/w/e/f
    -   在flutter中使用时，所有print输出，都会显示在控制台，日志等级是info级别。
    -   此处调用时，加入日志等级，是为了方便在查看日志文件时，根据日志等级来筛选使用的。

### 部分功能原理说明：
#### log日志文件名生成规则：
固定生成的日志文件名是cashbox.log

#### log日志的写入和清理规则：
1. 根据文件名，会使用2个日志文件。（cashbox.log和cashbox.log.backup两个文件）
2. 写入内容到cashbox.log文件中，本次写入结束时，判断cashbox.log文件大小，是否超过给定的限制大小。
超过限制大小后，重命名cashbox.log为cashbox.log.backup, 生成新的（或者选取已经存在的）cashbox.log文件，清空cashbox.log文件里的数据，后续继续往cashbox.log里面写入。

### 日志线程说明
1. 在 多处调用 或 多线程调用 此日志库时，通过registerPortWithName方法，只会生成一个 唯一日志线程 来处理写日志功能。
2. 通过 懒加载(lazy register)的方式，注册此唯一的日志线程。   即：在调者确认有输出日志需求的时候，才会去注册此唯一日志线程。
