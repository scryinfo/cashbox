//
// extern crate proc_macro;

use proc_macro::TokenStream;
use proc_macro_roids::{FieldsNamedAppend, DeriveInputStructExt};
use quote::quote;
use syn::{parse_macro_input, parse_quote, DeriveInput, FieldsNamed, Type};

#[proc_macro_attribute]
pub fn db_append_shared(_args: TokenStream, input: TokenStream) -> TokenStream {
    let mut ast = parse_macro_input!(input as DeriveInput);

    // Append the fields.
    let fields_additional: FieldsNamed = parse_quote!({
        pub id: String,
        pub create_time: i64,
        pub update_time: i64,
     });
    ast.append_named(fields_additional);

    let name = &ast.ident;

    let imp_base = quote!{
        impl db::Shared for #name {
            fn get_id(&self) -> String {
                self.id.clone()
            }
            fn set_id(&mut self, id: String) {
                self.id = id;
            }
            fn get_create_time(&self) -> i64 {
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


    let gen = TokenStream::from(quote! {
            #ast

            #imp_base
        });
    if !cfg!(feature = "no_print") {
        println!("............gen impl db_append_shared {}:\n {}", name, gen);
    }
    gen
}

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
    if !cfg!(feature = "no_print") {
        println!("............gen impl DbBeforeSave {}:\n {}",name, gen);
    }
    gen.into()
}

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
    if !cfg!(feature = "no_print") {
        println!("............gen impl DbBeforeUpdate {}:\n {}",name, gen);
    }
    gen.into()
}

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
            drop_ctype!(#name);
        });
    if !cfg!(feature = "no_print") {
        println!("............gen impl dl_struct {}:\n {}", name, gen);
    }
    gen
}


#[proc_macro_derive(DlDefault)]
pub fn dl_default(input: TokenStream) -> TokenStream {
    let ast = parse_macro_input!(input as DeriveInput);
    let name = &ast.ident;
    let mut drops = Vec::new();
    for field in ast.fields().iter() {
        if let Some(ident) = field.ident.as_ref() {
            let fname = ident;
            if let Type::Ptr(_) = &field.ty{
                drops.push(quote! {
                    #fname : std::ptr::null_mut()
                });
            }else{
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
    if !cfg!(feature = "no_print") {
        println!("............gen impl dl_default {}:\n {}", name, gen);
    }
    gen
}

#[cfg(test)]
mod tests {
    use syn::{parse_quote, Fields, FieldsNamed, Lit, Meta, NestedMeta, Type};

    // use proc_macro_roids::FieldExt;
    use std::os::raw::c_char;

    #[test]
    fn it_works() {

        let fields_named: FieldsNamed = parse_quote! {{
                pub id: *mut c_char,
                pub count: u32,
                pub name: *mut c_char,
                pub next: *mut Dl,
        }};
        let fields = Fields::from(fields_named);
        for field in fields.iter() {
            let name = field.ident.map_or("",|e|{
                e.to_string().as_str()
            });

            if let Type::Ptr(_) = field.ty {
                println!("ttt: {}, {}", field.ident.as_ref().unwrap().to_string(), "raw ptr");
            }
        }

        // assert_eq!(field.type_name(), "*mut c_char");
    }
}
