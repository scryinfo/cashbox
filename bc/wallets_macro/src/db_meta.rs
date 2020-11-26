use std::{fs,path};
use std::io::Write;
use std::sync::Mutex;

use once_cell::sync::OnceCell;
use proc_macro_roids::DeriveInputStructExt;
use syn::{AngleBracketedGenericArguments, GenericArgument, PathArguments, PathSegment, Type, TypePath, Fields};

#[derive(Default)]
pub struct DbMeta {
    // pub metas: Vec<syn::DeriveInput>,
    all_sql: String,
}

impl DbMeta {
    pub fn get() -> &'static Mutex<DbMeta> {
        static mut INSTANCE: OnceCell<Mutex<DbMeta>> = OnceCell::new();
        unsafe {
            INSTANCE.get_or_init(|| {
                Mutex::new(DbMeta::default())
            })
        }
    }

    pub fn push(&mut self, ast: syn::DeriveInput) {
        let script = generate_table(&ast);
        let all_file = path::Path::new(get_path().as_str()).join("all.sql");
        let all_file = all_file.to_str().expect("push -- all_file.to_str()");

        if self.all_sql.is_empty() {
            recreate_file(script.as_str(), all_file);
        }else{
            append_file(script.as_str(), all_file);
        }
        self.all_sql.push_str(script.as_str());
    }
}

fn gen_table_name(ast: &syn::Ident) -> String {
    let mut table_name = ast.to_string();
    let names: Vec<&str> = table_name.split("::").collect();
    table_name = names.get(names.len() - 1).expect("gen_table_name -- names.get(names.len() - 1)").to_string();
    table_name = to_snake_name(&table_name);
    table_name
}

fn to_snake_name(name: &String) -> String {
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

fn generate_table(ast: &syn::DeriveInput) -> String {
    let name = gen_table_name(&ast.ident);
    let file_name = path::Path::new(get_path().as_str()).join(name.clone() + ".sql");
    let mut script = generate_table_script(name.as_str(), ast.fields());
    script.insert_str(0,format!("-- {}\n",ast.ident.to_string()).as_str());
    recreate_file(script.as_str(), file_name.to_str().expect("Path::new(get_path().as_str()).join(name + \".sql\")"));
    script
}

fn generate_table_script(name: &str, fields: &Fields) -> String {
    let mut sql = String::new();
    sql.push_str(format!("CREATE TABLE IF NOT EXISTS {} (  \n", name).as_str());
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
                            panic!(format!("generate create table is not support type {} -- {} -- AngleBracketed args is None", name, col_name))
                        }
                    }
                    PathArguments::Parenthesized(_) => panic!(format!("generate create table is not support type {} -- {} -- Parenthesized", name, col_name)),
                }
            } else {
                panic!(format!("generate create table is not support type {} -- {} -- not TypePath", name, col_name))
            }
        } else {
            panic!(format!("generate create table is not support type {} -- {} -- not TypePath", name, col_name))
        };

        let col = match type_name.as_str() {
            "String" | "BigDecimal" => if col_name == "id" {format!("{} TEXT PRIMARY KEY,", col_name)} else{format!("{} TEXT NOT NULL,", col_name)},
            "Option<String>" | "Option<BigDecimal>" => format!("{} TEXT DEFAULT NULL,", col_name),
            "i64" | "u64" | "i32" | "u32" | "i16" | "u16" => format!("{} INTEGER NOT NULL,", col_name),
            "Option<i64>" | "Option<u64>" | "Option<i32>" | "Option<u32>" | "Option<i16>" | "Option<u16>" => format!("{} INTEGER DEFAULT NULL,", col_name),
            "f32" | "f64" => format!("{} REAL NOT NULL,", col_name),
            "Option<f32>" | "Option<f64>" => format!("{} REAL DEFAULT NULL,", col_name),
            "bool" => format!("{} BOOLEAN NOT NULL,", col_name),
            "Option<bool>" => format!("{} BOOLEAN DEFAULT NULL,", col_name),
            _ => format!("{} TEXT, -- is struct! ", col_name), //todo do not support sub struct
            // _ => panic!( format!("generate create table is not support type {} -- {} -- {}", &ast.ident, col_name, type_name))
        };
        sql.push_str("    ");
        sql.push_str(col.as_str());
        sql.push_str("\n");

        // //test
        // if name == "mnemonic" {
        //     if let Type::Path(TypePath { path, .. }) = &field.ty {
        //         println!("+++ {:?} -- {} ---- {} ",path.segments,  type_name, col_name);
        //     }
        // }
    }

    sql.remove(sql.len() - 2);
    sql.push_str(" );\n");

    sql
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


fn append_file(script: &str, file_name: &str) {
    let mut file = {
        if fs::metadata(file_name).is_err() {
            let f = path::Path::new(file_name);
            let dir = f.parent().expect("append_file -- f.parent()");
            let _ = fs::create_dir_all(dir);
            fs::File::create(file_name).expect("append_file -- fs::File::create(file_name)")
        } else {
            fs::OpenOptions::new().append(true).open(file_name).expect("append_file -- fs::File::open(file_name)")
        }
    };
    let _ = file.write_all(script.as_bytes());
}

fn get_path() -> String {
    let cur = "generated_sql".to_owned();
    if fs::metadata(cur.as_str()).is_err() {
        let _ = fs::create_dir(cur.as_str());
    }
    cur
}

#[cfg(test)]
mod tests {
    // use proc_macro_roids::FieldExt;
    use syn::{Fields, FieldsNamed, parse_quote, };

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
        }};
        let fields = Fields::from(fields_named);
        let name = "test_generate";
        let sql = crate::db_meta::generate_table_script(name,&fields);

        assert_eq!(true,sql.contains("id TEXT PRIMARY KEY"));

        assert_eq!(true,sql.contains("d_str TEXT NOT NULL"));
        assert_eq!(true,sql.contains("o_str TEXT DEFAULT NULL"));

        assert_eq!(true,sql.contains("d_i16 INTEGER NOT NULL"));
        assert_eq!(true,sql.contains("d_u16 INTEGER NOT NULL"));
        assert_eq!(true,sql.contains("d_i32 INTEGER NOT NULL"));
        assert_eq!(true,sql.contains("d_u32 INTEGER NOT NULL"));
        assert_eq!(true,sql.contains("d_i64 INTEGER NOT NULL"));
        assert_eq!(true,sql.contains("d_u64 INTEGER NOT NULL"));

        assert_eq!(true,sql.contains("o_i16 INTEGER DEFAULT NULL"));
        assert_eq!(true,sql.contains("o_u16 INTEGER DEFAULT NULL"));
        assert_eq!(true,sql.contains("o_i32 INTEGER DEFAULT NULL"));
        assert_eq!(true,sql.contains("o_u32 INTEGER DEFAULT NULL"));
        assert_eq!(true,sql.contains("o_i64 INTEGER DEFAULT NULL"));
        assert_eq!(true,sql.contains("o_u64 INTEGER DEFAULT NULL"));

        assert_eq!(true,sql.contains("d_bool BOOLEAN NOT NULL"));
        assert_eq!(true,sql.contains("o_bool BOOLEAN DEFAULT NULL"));

        assert_eq!(true,sql.contains("d_f32 REAL NOT NULL"));
        assert_eq!(true,sql.contains("d_f64 REAL NOT NULL"));
        assert_eq!(true,sql.contains("o_f32 REAL DEFAULT NULL"));
        assert_eq!(true,sql.contains("o_f64 REAL DEFAULT NULL"));

        println!("{}",sql);
    }
}
