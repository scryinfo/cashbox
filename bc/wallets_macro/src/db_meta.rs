use std::{fs, path};
use std::collections::{BTreeMap, HashMap};
use std::io::Write;
use std::sync::Mutex;

use once_cell::sync::OnceCell;
use proc_macro_roids::DeriveInputStructExt;
use quote::ToTokens;
use syn::{AngleBracketedGenericArguments, Fields, GenericArgument, PathArguments, PathSegment, Type, TypePath};

use crate::to_snake_name;

#[derive(Default, Debug)]
pub struct TableMeta {
    //type name
    pub type_name: String,
    //所有参数都准备好后，会生成sql语句，一但生成就不会再有变化
    sql: String,
    //带有参数的sql模板
    pub template: String,
    pub cols: String,
    //key: sub struct name, value: {name}
    //Sample: Eee: {Eee}
    subs: HashMap<String, String>,
    pub write_file: bool,
    pub is_sub: bool,
}

impl TableMeta {
    fn type_name_to_key(type_name: &str) -> String {
        format!("{{{}}}", type_name)
    }

    //return {Eee}
    fn set_sub(&mut self, type_name: &str) -> String {
        let v = TableMeta::type_name_to_key(type_name);
        self.subs.insert(type_name.to_owned(), v.clone());
        v
    }
}

#[derive(Default, Debug)]
pub struct DbMeta {
    // pub metas: Vec<syn::DeriveInput>,
    // key：table name, value: sql
    table_metas: BTreeMap<String, TableMeta>,
    // key: sub struct name, value: cols
    sub_struct: HashMap<String, String>,
}

impl DbMeta {
    ///使用 static 变量，生成一个线程安全的共享对象
    pub fn get() -> &'static Mutex<DbMeta> {
        static mut INSTANCE: OnceCell<Mutex<DbMeta>> = OnceCell::new();
        unsafe {
            INSTANCE.get_or_init(|| {
                Mutex::new(DbMeta::default())
            })
        }
    }

    /// 加入表
    pub fn push(&mut self, ast: &syn::DeriveInput) {
        let mut tm = self.generate_table_meta(&ast);
        tm.is_sub = false;
        self.table_metas.insert(tm.type_name.clone(), tm);
        self.full_template();
    }

    /// 加入sub struct
    pub fn push_sub_struct(&mut self, ast: &syn::DeriveInput) {
        let mut tm = self.generate_table_meta(&ast);
        if !tm.subs.is_empty() {
            panic!("do not support sub --> sub struct: {}", tm.type_name);
        }
        tm.is_sub = true;
        self.sub_struct.insert(tm.type_name, tm.cols);
        self.full_template();
    }

    ///处理 struct中的字段
    fn full_template(&mut self) {
        let mut dones = Vec::new();
        for (table_name, tm) in &mut self.table_metas {
            if tm.sql.is_empty() {
                let mut all = true;
                for key in tm.subs.keys() {
                    if !self.sub_struct.contains_key(key) {
                        all = false;
                        break;
                    }
                }
                if all {
                    let mut sql = tm.template.clone();
                    for (key, value) in &tm.subs {
                        let cols = self.sub_struct.get(key).expect("self.sub_struct.get");
                        //检查是否是最后一个
                        let mut ex_value = value.clone();
                        ex_value.push(',');
                        if sql.find(ex_value.as_str()).is_some() {
                            let index = cols.rfind("\n  ").expect("cols.rfind('\n')");
                            let mut temp = cols.clone();
                            temp.insert(index, ',');
                            sql = sql.replace(ex_value.as_str(), temp.as_str());
                        } else {
                            sql = sql.replace(value, cols);
                        }
                    }
                    tm.sql = sql;
                    dones.push(table_name.clone());
                }
            } else {
                dones.push(table_name.clone());
            }
        }
        if !dones.is_empty() {
            let mut all_sql = String::new();
            for name in &dones {
                let tm = self.table_metas.get_mut(name).unwrap();
                if !tm.write_file {
                    let table_name = gen_table_name(tm.type_name.as_str());
                    let file = get_path((table_name + ".sql").as_str());
                    recreate_file(tm.sql.as_str(), file.as_str());
                    tm.write_file = true;
                }
                all_sql.push_str(tm.sql.as_str());
            }

            let all_file = get_path("all.sql");
            recreate_file(all_sql.as_str(), all_file.as_str());
        }
    }

    /// 生成创建表的语句
    fn generate_table_meta(&mut self, ast: &syn::DeriveInput) -> TableMeta {
        let mut tm = generate_table_script(&ast.ident.to_string(), ast.fields());
        tm.template.insert_str(0, format!("-- {}\n", ast.ident.to_string()).as_str());
        tm
    }
}

///通过 struct name生成表名
fn gen_table_name(type_name: &str) -> String {
    let mut type_name = type_name.to_owned();
    let names: Vec<&str> = type_name.split("::").collect();
    type_name = names.last().expect("gen_table_name -- names.last()").to_string();
    type_name = to_snake_name(&type_name);
    type_name
}

/// 生成创建表的sql script
fn generate_table_script(type_name: &str, fields: &Fields) -> TableMeta {
    let mut tm = TableMeta::default();
    tm.type_name = type_name.to_owned();
    let mut cols = String::new();
    for field in fields {
        let col_name = field.ident.as_ref().expect("field.ident.as_ref()").to_string();
        let type_name = if let Type::Path(TypePath { path, .. }) = &field.ty {
            if let Some(PathSegment { ident, arguments }) = path.segments.last() {
                match arguments {
                    PathArguments::None => ident.to_string(),
                    PathArguments::AngleBracketed(AngleBracketedGenericArguments { args, .. }) => {
                        if let Some(GenericArgument::Type(Type::Path(TypePath { path, .. }))) = args.last() {
                            format!("{}<{}>", ident.to_string(), path.segments.last().expect("ident.to_string(),path.segments.last()").ident.to_string())
                        } else {
                            panic!("{}", format!("generate create table is not support type {} -- {} -- AngleBracketed args is None", type_name, col_name))
                        }
                    }
                    PathArguments::Parenthesized(_) => panic!("{}", format!("generate create table is not support type {} -- {} -- Parenthesized", type_name, col_name)),
                }
            } else {
                panic!("{}", format!("generate create table is not support type {} -- {} -- not TypePath", type_name, col_name))
            }
        } else {
            panic!("{}", format!("generate create table is not support type {} -- {} -- not TypePath", type_name, col_name))
        };

        let col = match type_name.as_str() {
            "String" | "BigDecimal" => if col_name == "id" { format!("{} TEXT PRIMARY KEY,", col_name) } else { format!("{} TEXT NOT NULL,", col_name) },
            "Option<String>" | "Option<BigDecimal>" => format!("{} TEXT DEFAULT NULL,", col_name),
            "i64" | "u64" | "i32" | "u32" | "i16" | "u16" => format!("{} INTEGER NOT NULL,", col_name),
            "Option<i64>" | "Option<u64>" | "Option<i32>" | "Option<u32>" | "Option<i16>" | "Option<u16>" => format!("{} INTEGER DEFAULT NULL,", col_name),
            "f32" | "f64" => format!("{} REAL NOT NULL,", col_name),
            "Option<f32>" | "Option<f64>" => format!("{} REAL DEFAULT NULL,", col_name),
            "bool" => format!("{} BOOLEAN NOT NULL,", col_name),
            "Option<bool>" => format!("{} BOOLEAN DEFAULT NULL,", col_name),
            _ => {
                //#[serde(skip)]
                let skip = field.attrs.iter().any(|it| {
                    if it.path().segments.iter().any(|p| p.ident == "serde") {
                        //todo 找到具体的path,而不用整个生成字符串
                        it.to_token_stream().to_string().find("skip").is_some()
                    } else {
                        false
                    }
                });
                if skip {
                    continue;
                }
                //#[serde(flatten)]
                let flatten = field.attrs.iter().any(|it| {
                    if it.path().segments.iter().any(|p| p.ident.to_string() == "serde") {
                        //todo 找到具体的path,而不用整个生成字符串
                        it.to_token_stream().to_string().find("flatten").is_some()
                    } else {
                        false
                    }
                });
                if flatten {
                    format!("{},", tm.set_sub(type_name.as_str()))
                } else {
                    panic!("{}", format!("generate create table is not support type {} -- {}", type_name, col_name))
                }
            }
        };
        cols.push_str("    ");
        cols.push_str(col.as_str());
        cols.push_str("\n");
    }

    if let Some(index) = cols.rfind(',') {
        cols.remove(index);
    }
    {
        let mut temp = cols.clone();
        temp.insert_str(0, format!("-- {} start\n", type_name).as_str());
        temp.insert_str(temp.len(), format!("    -- {} end\n", type_name).as_str());
        tm.cols = temp;
    }

    let mut template = cols;
    template.insert_str(0, format!("CREATE TABLE IF NOT EXISTS {} (  \n", gen_table_name(type_name)).as_str());
    template.push_str(" );\n");
    tm.template = template;
    tm
}

fn recreate_file(script: &str, file_name: &str) {
    if fs::metadata(file_name).is_err() {
        let f = path::Path::new(file_name);
        let dir = f.parent().expect("std::path::Path::new(file_name)");
        let _ = fs::create_dir_all(dir);
    } else {
        let _ = fs::remove_file(file_name);
    }

    let mut file = fs::File::create(file_name).expect("fs::File::create(file_name)");
    let _ = file.write_all(script.as_bytes());
}

fn get_path(short_name: &str) -> String {
    const CARGO_MANIFEST_DIR: &str = "CARGO_MANIFEST_DIR";
    let mut cur = "generated_sql".to_owned();
    if let Ok(p) = std::env::var(CARGO_MANIFEST_DIR) {
        let p = path::Path::new(p.as_str()).join(cur);
        cur = p.to_str().expect("cur = p.to_str().expect").to_owned();
    }

    if fs::metadata(cur.as_str()).is_err() {
        let _ = fs::create_dir(cur.as_str());
    }
    let full = path::Path::new(cur.as_str()).join(short_name);
    return full.to_str().expect("full.to_str().").to_owned();
}

#[cfg(test)]
mod tests {
    // use proc_macro_roids::FieldExt;
    use syn::{Fields, FieldsNamed, parse_quote};

    #[test]
    fn generate_table_script() {
        let fields_named: FieldsNamed = parse_quote! {{
            pub id: String,

            pub d_str: String,
            pub o_str: Option<String>,

            pub d_i16: i16,
            pub d_u16: u16,
            pub d_i32: i32,
            pub d_u32: u32,
            pub d_i64: i64,
            pub d_u64: u64,

            pub o_i16: Option<i16>,
            pub o_u16: Option<u16>,
            pub o_i32: Option<i32>,
            pub o_u32: Option<u32>,
            pub o_i64: Option<i64>,
            pub o_u64: Option<u64>,

            pub d_bool: bool,
            pub o_bool: Option<bool>,

            pub d_f32: f32,
            pub d_f64: f64,

            pub o_f32: Option<f32>,
            pub o_f64: Option<f64>,

            pub d_big: BigDecimal,
            pub o_big: Option<BigDecimal>,
        }};
        let fields = Fields::from(fields_named);
        let name = "TestGenerate";
        let tm = crate::db_meta::generate_table_script(name, &fields);
        let sql = tm.template;

        assert_eq!(true, sql.contains("id TEXT PRIMARY KEY"));

        assert_eq!(true, sql.contains("d_str TEXT NOT NULL"));
        assert_eq!(true, sql.contains("o_str TEXT DEFAULT NULL"));

        assert_eq!(true, sql.contains("d_i16 INTEGER NOT NULL"));
        assert_eq!(true, sql.contains("d_u16 INTEGER NOT NULL"));
        assert_eq!(true, sql.contains("d_i32 INTEGER NOT NULL"));
        assert_eq!(true, sql.contains("d_u32 INTEGER NOT NULL"));
        assert_eq!(true, sql.contains("d_i64 INTEGER NOT NULL"));
        assert_eq!(true, sql.contains("d_u64 INTEGER NOT NULL"));

        assert_eq!(true, sql.contains("o_i16 INTEGER DEFAULT NULL"));
        assert_eq!(true, sql.contains("o_u16 INTEGER DEFAULT NULL"));
        assert_eq!(true, sql.contains("o_i32 INTEGER DEFAULT NULL"));
        assert_eq!(true, sql.contains("o_u32 INTEGER DEFAULT NULL"));
        assert_eq!(true, sql.contains("o_i64 INTEGER DEFAULT NULL"));
        assert_eq!(true, sql.contains("o_u64 INTEGER DEFAULT NULL"));

        assert_eq!(true, sql.contains("d_bool BOOLEAN NOT NULL"));
        assert_eq!(true, sql.contains("o_bool BOOLEAN DEFAULT NULL"));

        assert_eq!(true, sql.contains("d_f32 REAL NOT NULL"));
        assert_eq!(true, sql.contains("d_f64 REAL NOT NULL"));
        assert_eq!(true, sql.contains("o_f32 REAL DEFAULT NULL"));
        assert_eq!(true, sql.contains("o_f64 REAL DEFAULT NULL"));

        assert_eq!(true, sql.contains("d_big TEXT NOT NULL"));
        assert_eq!(true, sql.contains("o_big TEXT DEFAULT NULL"));

        println!("{}", sql);
    }

    #[test]
    fn sub_struct() {
        // let flatten = "#[serde(flatten)]";
        // let flatten = "flatten".to_string();

        // let fields_named: FieldsNamed = parse_quote! {
        //     pub id: String,
        //     //#[serde(flatten)]
        //     pub d_str: String,
        // };
        // let fields = Fields::from(fields_named);
        // for f in &fields {
        //     println!("{:?}", f);
        // }
    }
}
