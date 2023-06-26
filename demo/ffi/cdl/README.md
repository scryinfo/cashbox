# prepare
1. cargo install bindgen
2. cargo install --force cbindgen

# bindgen( rust )
bindgen wallets_c.h -o wallets_c.rs

#valgrind in ubuntu
1. cargo install cargo-valgrind
2. apt install valgrind
3. cargo valgrind --test units  // test name in Cargo.toml; 
4. valgrind target/debug/deps/units-ee9e2e5d59af158a  //编译的名字可能不一样，注意查看编译输出
5. output :
```
==38153== HEAP SUMMARY:
==38153==     in use at exit: 0 bytes in 0 blocks
==38153==   total heap usage: 722 allocs, 722 frees, 73,860 bytes allocated
==38153== 
==38153== All heap blocks were freed -- no leaks are possible
```
"All heap blocks were freed -- no leaks are possible" ok