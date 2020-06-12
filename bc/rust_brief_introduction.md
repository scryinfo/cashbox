# Rust 特性介绍
Rust是一门具有安全性、高性能、安全并发，现代化特点的系统级编程语言。

## 高性能
Rust 具有高性能的通过静态编译成机器码直接运行，与常见的热门语言比较存在显著的优势
### Python
更快，较低的内存消耗
### Java
没有JVM消耗，GC停顿，较低的内存消耗，
### C/C++
不存在段错误，空指针、缓冲区溢出、数据竞争问题、不统一的编译方式
### Go
没有GC中断、 具有较低的内存使用、没有空指针问题，具有更好的错误处理、线程安全，零成本的抽象，依赖管理

## 安全性
### 类型系统
Rust是一门强类型且类型安全的静态语言，在Rust中一切皆为表达式，表达式都有值，值都有类型，所以在Rust中一切皆为类型；类型包括
- 基本的原始类型 `u8、u32、i32、usize、bool`
- 复合类型,比如自定义的 struct
- 生命周期作用域标记
- Option<T>、Result<T、E>
- never,指根本无法返回值的情况，比如线程奔溃、break、continue等行为    

在类型系统里面，使用模式匹配，可以高效的进行数据逻辑处理
```rust
// Option<T> is an enum that is either Some(T) or None 
if let Some(f)=my_vec.find(|t|t>=42){
    /*found*/
}
```
针对Option<T>、Result<T、E> 类型的操作，常使用的方法有:
```rust
//To inner type

unwrap () -> T
unwrap_or (T) -> T
unwrap_or_else (() -> T) -> T
unwrap_or_default () -> T where T: Default
expect (&str) -> T

//Converting to another type

map ((T) -> U) -> Option<U>
map_or (U, (T) -> U) -> U
map_or_else (() -> U, (T) -> U) -> U
```
更多方法，可以查询标准库文档，直接在命令行中输入`Cargo doc`即可查看到本地下载的文档
### 所有权管理
每个变量都有一个所有者，所有者负责该变量对应内容的释放和读写权限，并且在一个时间点上只有一个拥有者，当变量所在的作用域结束的时候，变量以及它他代表的值都将消失。
在Rust中通过是否实现Copy trait 来区分数据类型的是否发生复制或者所有权转移。 

```rust
let x = Vec::new();
let y = x;
drop(x); //illegal, y is now owner

```
**注意：** 针对赋值的情况，当等号右边的类型为实现了 `Copy` Trait时，会自动调用copy方法，不会发生所有权转移的问题；若该类型没有实现copy方法，则会发生所有权转移的情况。
针对基本类型，标准库里面已经自动实现了Copy trait；针对上述代码，要是代码能够正常编译，可以调用clone方法，对x进行深拷贝。
```rust

    let mut x = vec![1,2,3];
    let first = &x[0];
    let y =x; 
    println!("{}",*first);//illegal  first become invalid when x was moved.
```
在rust 变量声明中，默认情况下，变量对应的值是不可变的。当变量存在变动的可能时，需要在声明是 添加 `mut`标记
```rust
let v = Vec::new();
//this compile just fine
println("len:{}",v.len());
//this will not compile;would need mutable access
v.push(42);
```
**引用**是Rust提供的一种指针语义，是基于指针的实现。它与指针的区别是指针保存的是指向内存的地址，而引用可以看作某块内存的别名
使用引用也需要满足编译器的各种安全检查规则，引用分为不可变引用和可变引用，使用& 符号表示不可变引用，使用&mut 表示可变引用。

在实际使用时遵循 "共享不可变，可变不共享"的原则，就可以避免数据造成不安全的事件发生。
### 安全并发
Rust实现避免数据竞争是通过Send和Sync这两个trait来实现。
- 如果类型T实现了`Send` Trait,那说明这个类型的变量在不同的线程中传递所有权是安全的；
- 如果类型T实现了`Sync` Trait,那说明这个类型的变量在不同的线程中使用`&T`访问同一个变量是安全的；

(更多内容待完善)
### 错误处理
通过使用Option、Result这两个枚举类型进行错误处理，他们的定义如下：
```rust
enum Option<T>{
    Some(T),
    None,
}
enum Result<T,E>{
    Ok(T),
    Err(E),
}
// v is Option<&T>, not &T -- cannot use without checking for None
let v = my_vec.find(|t| t>=42);
// n is Result<i32,ParseIntError> -- cannot use without checking for Err
let n ="42".parse::<i32>();
//？ suffix is "return Err if Err,otherwise unwrap Ok"
let n = "42".parse::<i32>()?;
```
若针对语句执行的结果存在没有处理的情况，在编译阶段编译都会检查出来，提示你进行完善。
## 现代化
###构件工具
- rust官方提供了成熟的构建工具Cargo，相比较go通过go path、go mod,java 使用Maven、Gradle，C/C++使用Makefile、Cmake、Automake,
Cargo在依赖管理、编译的使用体验要好很多。
- 提供了丰富的扩展工具只要在代码中以`///`开始的内容，通过命令cargo-doc能够自动将代码中文档输出形成文档，所在文档中包含完整的代码，那这部分代码在生成的时候也会通过编译；
```rust
/// Return one more than its argument
///
///```
///assert_eq!(one_more(42),43);
///```
fn one_more(n:i32)->i32{
    n+1
}
```
- cargo fmt提供了代码格式工具；
- cargo clippy能够针对代码给出优化建议；
### 单元测试
在代码中的任何地方都可以编写单元测试，在编写的单元测试上使用`#[test]`就能在当使用`Cargo test`命令时进行自动检测；
```rust
#[test]
fn it_works(){
    assert_eq!(1+1,2)
}
```
### 发展方向
完全靠社区驱动的开源编程语言，所有的决议都是通过在[github](https://github.com/rust-lang)进行公开讨论，稳定的更新周期；
##缺点
- 与java、go相比较，当前rust编译程序比较耗时；
- 没有预编译，所有引用的crate在最终编译的时候都要编译一次，没有像C、C++那样直接链接动态库等功能；
- 过于严格的生命周期、所有权检查。在某些场景下不会引发生命周期安全问题的代码，只要不满足当前的生命周期检查规则，都不能通过编译。
 

