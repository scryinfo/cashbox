# wallets 宏使用说明

## 数据库Model的Sample 
### 有 sub struct
```rust
#[db_append_shared(CRUDEnable)]
#[derive(Serialize, Deserialize, Clone, Debug, Default, DbBeforeSave, DbBeforeUpdate)]
struct Big{
 #[serde(default)]
 pub name_: String,
 #[serde(flatten)]
 pub one: One,
}

#[derive(Serialize, Deserialize, Clone, Debug, Default)]
struct One {
 #[serde(default)]
 pub id_: String,
 #[serde(default)]
 pub count_: u64,
}
```


### 无 sub struct
```rust
#[db_append_shared]
#[derive(Serialize, Deserialize, Clone, Debug, Default, DbBeforeSave, DbBeforeUpdate，CRUDEnable)]
struct Big{
 #[serde(default)]
 pub name_: String,
 ...
}
```

## 说明
- 数据库表需要 `#[db_append_shared]` attribute
- 每一个字段都需要 `#[serde(default)]` 在使用serde_json时，提供默认值，如果不给 model <==> db时会出错
- sub struct上需要使用 `#[serde(flatten)]` 在序列化时它会把sub struct中的字段直接放入parent struct中
- 在有sub struct时不能使用`#[derive(CRUDEnable)]`，只能使用`#[db_append_shared(CRUDEnable)]`
- 如果没有sub struct 可以使用`#[derive(CRUDEnable)]`，它是在编译时生成的代码，没有运行开销。
- 所有字段不能重名，包含sub struct中的
- `id`,`create_time`,`update_time`这三个字段会自动生成，所以不需要手动增加
## 支持类型
i16,u16,    
i32,u32,    
i64,u64,    
String,
bool, //#[serde(default, deserialize_with = "bool_from_int")]  
f32,f64 
bigdecimal::BigDecimal


