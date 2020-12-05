use proc_macro::TokenStream;

use proc_macro_roids::{DeriveInputStructExt, FieldsNamedAppend};
use quote::quote;
use syn::{AttributeArgs, DeriveInput, FieldsNamed, parse_macro_input, parse_quote, Type};

mod db_meta;
mod cr;

/// 生成数据库通用部分，包括如下：
/// # 三个字段， id: String, create_time: i64,update_time: i64
/// # impl Shared
/// # 选项，如果有“CRUDEnable”参数，那么使用 rbatis的json方式实现 CRUDEnable接口。 如果struct中带有sub struct只能使用这种方式实现
/// # 在目录 “generated_sql”下面生成创建数据表的sql语言，现只支持sqlite，详细说明如下：
/// * 数据库表需要 "#[db_append_shared]" attribute
/// * 每一个字段都需要 "#[serde(default)]" 在使用serde_json时，提供默认值，如果不给 model <==> db时会出错
/// * sub struct上需要使用 "#[serde(flatten)]" 在序列化时它会把sub struct中的字段直接放入parent struct中
/// * 在有sub struct时不能使用"#[derive(CRUDEnable)]"，只能使用[db_append_shared(CRUDEnable)]
/// * 如果没有sub struct 可以使用#[derive(CRUDEnable)]，它是在编译时生成的代码，没有运行开销。
/// * 所有字段不能重名，包含sub struct中的
/// ## 支持类型
/// i16,u16,i32,u32,i64,u64,
/// String,
/// bool, //#[serde(default, deserialize_with = "bool_from_int")]
/// f32,f64
/// bigdecimal::BigDecimal
/// #Sample include sub struct
/// ````
/// #[db_append_shared(CRUDEnable)]
/// #[derive(Serialize, Deserialize, Clone, Debug, Default, DbBeforeSave, DbBeforeUpdate)]
/// struct Big{
///  #[serde(default)]
///  pub name: String,
///  #[serde(flatten)]
///  pub sub: Sub,
/// }
/// #[db_sub_struct]
/// #[derive(Serialize, Deserialize, Clone, Debug, Default)]
/// struct Sub {
///  #[serde(default)]
///  pub count: u64,
/// }
/// ````
/// # Sample no sub struct
/// ````
/// #[db_append_shared]
/// #[derive(Serialize, Deserialize, Clone, Debug, Default,CRUDEnable, DbBeforeSave, DbBeforeUpdate)]
/// struct Big{
///  #[serde(default)]
///  pub name: String,
/// // other fields
/// }
/// ````
#[proc_macro_attribute]
pub fn db_append_shared(args: TokenStream, input: TokenStream) -> TokenStream {
    let mut ast = parse_macro_input!(input as DeriveInput);
    let args = parse_macro_input!(args as AttributeArgs);

    // Append the fields.
    let fields_additional: FieldsNamed = parse_quote!({
        #[serde(default)]
        pub id: String,
        #[serde(default)]
        pub create_time: i64,
        #[serde(default)]
        pub update_time: i64,
     });
    ast.append_named(fields_additional);

    let name = &ast.ident;

    let imp_base = quote! {
            impl Shared for #name {
                fn get_id(&self) -> String {
                    self.id.clone()
                }

                fn set_id(&mut self, id: String) {
                    self.id = id;
                }

                fn get_create_time(&self) -> i64    {
                    self.create_time
                }

                fn set_create_time(&mut self, create_time: i64) {
                    self.create_time = create_time;
                }

                fn get_update_time(&self) -> i64 {
                    self.update_time
                }

                fn set_update_time(&mut self, update_time: i64) {
                    self.update_time = update_time;
                }

            }
    };

    let impl_crud = if args.is_empty() {
        quote! {}
    } else {
        quote! {
            impl CRUDEnable for #name {
                type IdType = String;
            }
        }
    };

    let gen = TokenStream::from(quote! {
            #ast
            #imp_base
            #impl_crud
        });
    if cfg!(feature = "print_macro") {
        println!("\n............gen impl db_append_shared {}:\n {}", name, gen);
    }

    if cfg!(feature = "db_meta") {
        let mut meta = db_meta::DbMeta::get().lock().expect("db_meta::DbMeta::get().lock()");
        (*meta).push(&ast);
    }

    gen
}

/// 标记为 sub struct。只有标记为sub struct的才能被用到表的struct中
#[proc_macro_attribute]
pub fn db_sub_struct(_: TokenStream, input: TokenStream) -> TokenStream {
    let ast = parse_macro_input!(input as DeriveInput);
    let gen = TokenStream::from(quote! {
            #ast
        });

    if cfg!(feature = "print_macro") {
        println!("\n////// gen impl db_sub_struct {}:\n {}", &ast.ident.to_string(), gen);
    }

    if cfg!(feature = "db_meta") {
        let mut meta = db_meta::DbMeta::get().lock().expect("db_meta::DbMeta::get().lock()");
        (*meta).push_sub_struct(&ast);
    }
    gen
}

/// impl BeforeSave
#[proc_macro_derive(DbBeforeSave)]
pub fn db_before_save(input: TokenStream) -> TokenStream {
    let ast = parse_macro_input!(input as DeriveInput);
    let name = &ast.ident;
    let gen = quote! {
        impl db::BeforeSave for #name {
            fn before_save(&mut self){
                if self.get_id().is_empty() {
                    self.set_id(kits::uuid());
                    self.set_update_time(kits::now_ts_seconds());
                    self.set_create_time(self.get_update_time());
                } else {
                    self.set_update_time(kits::now_ts_seconds());
                }
            }
        }
    };
    if cfg!(feature = "print_macro") {
        println!("\n............gen impl DbBeforeSave {}:\n {}", name, gen);
    }
    gen.into()
}

/// impl BeforeUpdate
#[proc_macro_derive(DbBeforeUpdate)]
pub fn db_before_update(input: TokenStream) -> TokenStream {
    let ast = parse_macro_input!(input as DeriveInput);
    let name = &ast.ident;
    let gen = quote! {
        impl db::BeforeUpdate for #name {
            fn before_update(&mut self){
                self.set_update_time(kits::now_ts_seconds());
            }
        }
    };
    if cfg!(feature = "print_macro") {
        println!("\n............gen impl DbBeforeUpdate {}:\n {}", name, gen);
    }
    gen.into()
}

/// impl CStruct + Drop
#[proc_macro_derive(DlStruct)]
pub fn dl_struct(input: TokenStream) -> TokenStream {
    let ast = parse_macro_input!(input as DeriveInput);
    let name = &ast.ident;
    let mut drops = Vec::new();
    for field in ast.fields().iter() {
        if let (Type::Ptr(_), Some(ident)) = (&field.ty, field.ident.as_ref()) {
            let fname = ident;
            drops.push(quote! {
                self.#fname.free();
            });
        }
    }

    let gen = TokenStream::from(quote! {
            // #ast

            impl CStruct for #name {
                fn free(&mut self) {
                    #(#drops)*
                }
            }
            impl Drop for #name {
                fn drop(&mut self) {
                    self.free();
                }
            }
        });
    if cfg!(feature = "print_macro") {
        println!("\n............gen impl dl_struct {}:\n {}", name, gen);
    }
    gen
}

/// impl Default
#[proc_macro_derive(DlDefault)]
pub fn dl_default(input: TokenStream) -> TokenStream {
    let ast = parse_macro_input!(input as DeriveInput);
    let name = &ast.ident;
    let mut drops = Vec::new();
    for field in ast.fields().iter() {
        if let Some(ident) = field.ident.as_ref() {
            let fname = ident;
            if let Type::Ptr(_) = &field.ty {
                drops.push(quote! {
                    #fname : std::ptr::null_mut()
                });
            } else {
                drops.push(quote! {
                    #fname : Default::default()
                });
            }
        }
    }

    let gen = TokenStream::from(quote! {
            impl Default for #name {
                fn default() -> Self {
                    #name {
                        #(#drops,)*
                    }
                }
            }
        });
    if cfg!(feature = "print_macro") {
        println!("............gen impl dl_default {}:\n {}", name, gen);
    }
    gen
}

/// impl CR
#[proc_macro_derive(DlCR)]
pub fn dl_cr(input: TokenStream) -> TokenStream {
    let ast = parse_macro_input!(input as DeriveInput);
    cr::dl_cr(&ast.ident.to_string(), &ast.fields())
}

/// camel to snake
/// Sample
/// camelName to camel_name
pub(crate) fn to_snake_name(name: &String) -> String {
    let chs = name.chars();
    let mut new_name = String::new();
    let mut index = 0;
    let chs_len = name.len();
    for x in chs {
        if x.is_uppercase() {
            if index != 0 && (index + 1) != chs_len {
                new_name.push_str("_");
            }
            new_name.push_str(x.to_lowercase().to_string().as_str());
        } else {
            new_name.push(x);
        }
        index += 1;
    }
    return new_name;
}

#[cfg(test)]
mod tests {
    use syn::{Fields, FieldsNamed, parse_quote, Type};

    #[test]
    fn it_works() {
        let fields_named: FieldsNamed = parse_quote! {{
                pub id: *mut c_char,
                pub count: u32,
                pub name: *mut c_char,
                pub next: *mut Dl,
        }};
        let fields = Fields::from(fields_named);
        let mut count = 0;
        for field in fields.iter() {
            if let Type::Ptr(_) = field.ty {
                count += 1;
                println!("\nttt: {}, {}", field.ident.as_ref().unwrap().to_string(), "raw ptr");
            }
        }

        assert_eq!(3, count);
    }
}
