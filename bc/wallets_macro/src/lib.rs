//
// extern crate proc_macro;

use proc_macro::TokenStream;
use proc_macro_roids::FieldsNamedAppend;
use quote::quote;
use syn::{parse_macro_input, parse_quote, DeriveInput, FieldsNamed};

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
        impl DbBase for #name {
            fn get_id(&self) -> String {
                self.id.clone()
            }
            fn set_id(&mut self, id: String) {
                self.id = id;
            }
            fn get_create_time(&self) -> i64 {
                self.create_time
            }
            fn set_create_time(&mut self, createTime: i64) {
                self.create_time = createTime;
            }
            fn get_update_time(&self) -> i64 {
                self.update_time
            }
            fn set_update_time(&mut self, updateTime: i64) {
                self.update_time = updateTime;
            }
        }
    };


    let ts = TokenStream::from(quote! {
            #ast

            #imp_base
        });
    if !cfg!(feature = "no_print") {
        println!("............gen impl CRUDEnable:\n {}", ts);
    }
    ts
}


#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}
