

use std::sync::{Mutex};
use once_cell::sync::OnceCell;
use proc_macro_roids::{DeriveInputStructExt, FieldExt};
use std::io::Write;
use std::fs;
use syn::{TypePath, Type, PathSegment, PathArguments, AngleBracketedGenericArguments,GenericArgument};
use std::any::Any;

#[derive(Default)]
pub struct DbMeta{
    pub metas: Vec<syn::DeriveInput>,
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
        generate_create_table(&ast);
        self.metas.push(ast);
        // println!("=====metas len: {}", self.metas.len());
    }
}

fn gen_table_name(ast:&syn::Ident) ->String{
    let mut table_name = ast.to_string();
    let names: Vec<&str> = table_name.split("::").collect();
    table_name = names.get(names.len() - 1).unwrap().to_string();
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

fn generate_create_table(ast: &syn::DeriveInput) {
    let name = gen_table_name(&ast.ident);
    let file_name = std::path::Path::new(get_path().as_str()).join(name + ".sql");
    let script = generate_create_table_script(ast);
    create_table_file(script.as_str(), file_name.to_str().unwrap());
}
fn generate_create_table_script(ast: &syn::DeriveInput) -> String {
    let mut sql = String::new();
    let name = gen_table_name(&ast.ident);

    sql.push_str(format!("CREATE TABLE {} (  \n", name).as_str());
    for field in ast.fields() {
        let mut type_name = field.type_name().to_string();
        let col_name = field.ident.as_ref().unwrap().to_string();
        let mut type_name = if let Type::Path(TypePath { path, .. }) = &field.ty {
            if let Some(PathSegment{ident, arguments}) = path.segments.last(){
                match arguments {
                    PathArguments::None => ident.to_string(),
                    PathArguments::AngleBracketed(AngleBracketedGenericArguments{args,..}) => {
                        if let Some(GenericArgument::Type(Type::Path(TypePath{path, ..}))) = args.last() {
                            format!("{}<{}>",ident.to_string(),path.segments.last().unwrap().ident.to_string())
                        }else{
                            panic!( format!("generate create table is not support type {} -- {} -- AngleBracketed args is None", &ast.ident, col_name))
                        }
                    },
                    PathArguments::Parenthesized(_) => panic!( format!("generate create table is not support type {} -- {} -- Parenthesized", &ast.ident, col_name)),
                }
            }else{
                panic!( format!("generate create table is not support type {} -- {} -- not TypePath", &ast.ident, col_name))
            }
        }else{
            panic!( format!("generate create table is not support type {} -- {} -- not TypePath", &ast.ident, col_name))
        };
        let col = match type_name.as_str() {
            "String" | "BigDecimal" => format!("{} TEXT NOT NULL", col_name),
            "Option<String>" | "Option<BigDecimal>" => format!("{} TEXT", col_name),
            "i64" | "u64"| "i32" | "u32" | "i16" | "u16" => format!("{} INTEGER NOT NULL", col_name),
            "bool" => format!("{} BOOLEAN NOT NULL", col_name),
            _ => format!("{} TEXT", col_name), //todo do not support sub struct
            // _ => panic!( format!("generate create table is not support type {} -- {} -- {}", &ast.ident, col_name, type_name))
        };
        sql.push_str("    ");
        sql.push_str(col.as_str());
        sql.push_str(",\n");

        //test
        if name == "mnemonic" {
            if let Type::Path(TypePath { path, .. }) = &field.ty {
                println!("+++ {:?} -- {} ---- {} ",path.segments,  type_name, col_name);
            }
        }

    }

    sql.remove(sql.len()-2);
    sql.push_str(" );\n");

    sql
}

fn create_table_file(script: &str, file_name: &str) {
    if fs::metadata(file_name).is_err() {
        let f = std::path::Path::new(file_name);
        let dir = f.parent().unwrap();
        let _ = fs::create_dir_all(dir);
    }else{
        let _ = fs::remove_file(file_name);
    }

    let mut file = fs::File::create(file_name).unwrap();
    let _ = file.write_all(script.as_bytes());
}

fn get_path() -> String {
    let cur = "sql".to_owned();
    if fs::metadata(cur.as_str()).is_err() {
        let _ = fs::create_dir(cur.as_str());
    }
    cur
}
