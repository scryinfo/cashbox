# Rust Features Introduction

Rust is a system-level programming language with security, high performance, safe concurrency, and modern features.

## High Performance

Rust has high performance and runs directly through static compilation into machine code, which has significant advantages
compared to common popular languages.

### Python

Faster, lower memory consumption

### Java

No JVM consumption, GC pauses, lower memory consumption,

### C/C++

There are no segfaults, null pointers, buffer overflows, data competition issues, and inconsistent compilation methods.

### Go

No GC interrupts, low memory usage, no null pointer problems, better error handling, thread safety, zero-cost abstraction,
and dependency management.

## Safety

### Type System

Rust is a strongly typed and type-safe static language. Everything in Rust is an expression, expressions have values, and
values ​​have types, so everything in Rust is a type; types include

- Basic primitive types `u8, u32, i32, usize, bool`
- Compound types, such as custom struct
- Life cycle scope tags
- Option<T>, Result<T, E>
- never, refers to the situation where the value cannot be returned at all, such as thread crash, break, continue, etc.

In the type system, the use of pattern matching can efficiently perform data logic processing

```rust
// Option<T> is an enum that is either Some(T) or None
if let Some(f)=my_vec.find(|t|t>=42){
    /*found*/
}
```

For the operations of Option<T>, Result<T, E>, the commonly used methods are:

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

For more methods, you can query the standard library documentation, and enter `Cargo doc` directly on the command line to
view the locally downloaded documentation

### Ownership Management

Each variable has an owner. The owner is responsible for the release and read and write permissions of the corresponding
content of the variable, and there is only one owner at a time. When the scope of the variable ends, the variable and other
representatives The values ​​will disappear.
In Rust, whether to copy or transfer ownership is distinguished by whether to implement the Copy trait.

```rust
let x = Vec::new();
let y = x;
drop(x); //illegal, y is now owner

```

**Note:** For the case of assignment, when the type on the right of the equal sign is to implement `Copy` Trait, the copy
method will be automatically called, and the problem of ownership transfer will not occur; if the type does not implement
the copy method, it will Occurrence of ownership transfer.
For the basic types, the Copy trait has been automatically implemented in the standard library. For the above code, if the
code can be compiled normally, you can call the clone method to make a deep copy of x.

```rust

    let mut x = vec![1,2,3];
    let first = &x[0];
    let y = x;
    println!("{}",*first);//illegal first become invalid when x was moved.
```

In the rust variable declaration, by default, the value corresponding to the variable is immutable. When there is a
possibility of variable changes, you need to add the `mut` tag in the declaration

```rust
let v = Vec::new();
//this compile just fine
println("len:{}",v.len());
//this will not compile;would need mutable access
v.push(42);
```

**Reference** is a pointer semantic provided by Rust and is based on pointer implementation. The difference between it and
the pointer is that the pointer saves the address pointing to the memory, and the reference can be regarded as an alias of a
certain memory
The use of references also needs to meet various safety inspection rules of the compiler. References are divided into
immutable references and variable references. The & symbol is used to indicate immutable references, and the &mut is used to
indicate variable references.

Following the principle of "sharing is immutable and mutable and not sharing" when in actual use, you can avoid unsafe
events caused by data.

### Safe Concurrency

The Rust implementation avoids data competition through the two traits Send and Sync.

- If type T implements `Send` Trait, it means that it is safe to pass ownership of variables of this type in different
  threads;
- If the type T implements `Sync` Trait, it means that it is safe for variables of this type to access the same variable
  using `&T` in different threads;

(More content to be improved)

### Error Handling

By using the two enumeration types Option and Result for error handling, their definitions are as follows:

```rust
enum Option<T>{
    Some(T),
    None,
}
enum Result<T,E>{
    Ok(T),
    Err(E),
}
// v is Option<&T>, not &T - cannot use without checking for None
let v = my_vec.find(|t| t>=42);
// n is Result<i32,ParseIntError> - cannot use without checking for Err
let n ="42".parse::<i32>();
//? suffix is ​​"return Err if Err,otherwise unwrap Ok"
let n = "42".parse::<i32>()?;
```

If there is no processing for the result of the statement execution, the compilation will be checked during the compilation
stage, prompting you to improve.

## Modernization

### Construct Tool

- rust official provides mature build tool Cargo, compared to go using go, go mod, java using Maven, Gradle, C/C++ using
  Makefile, Cmake, Automake,
  Cargo's experience in dependency management and compilation is much better.
- Provides a wealth of extension tools as long as the content starting with `///` in the code, through the command cargo-doc
  can automatically output the document in the code to form a document, where the document contains the complete code, then
  this part of the code is being generated Will also be compiled when

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

- cargo fmt provides code formatting tools;
- cargo clippy can give optimization suggestions for the code;

### unit test

You can write unit tests anywhere in the code. Using `#[test]` on the written unit tests will automatically detect when you
use the `Cargo test` command;

```rust
#[test]
fn it_works(){
    assert_eq!(1+1,2)
}
```

### Direction of development

Open source programming language fully driven by the community. All decisions are made through open discussions
at [github](https://github.com/rust-lang) and a stable update cycle;

## Disadvantages

- Compared with java and go, the current rust compiler is more time-consuming;
- There is no pre-compilation, and all referenced crates must be compiled once at the time of final compilation. There is no
  direct link to dynamic libraries and other functions like C and C++;
- Too strict life cycle and ownership inspection. In some scenarios, code that does not cause life cycle security issues
  will fail to compile as long as it does not meet the current life cycle inspection rules.
