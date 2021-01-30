use proc_macro::TokenStream;

use quote::{format_ident, quote, ToTokens};
use syn::{Fields, PathSegment, Type, TypePath};

use crate::to_snake_name;

// #[allow(non_upper_case_globals)]
// const TypeName_CArray: &str = "CArray";
const TYPE_NAME_C_CHAR: &str = "c_char";

pub fn dl_cr(type_name: &str, fields: &Fields) -> TokenStream {
    const NAME: &str = "";//CExtrinsicContext
    let r_name = {
        let mut str = type_name.to_owned();
        str.remove(0);
        format_ident!("{}",str)
    };
    //test
    if type_name == NAME {
        println!("===gen impl dl_cr start:  {}", type_name);
    }
    let mut to_c_quote = Vec::new();
    let mut ptr_rust_quote = Vec::new();
    for field in fields.iter() {
        if let Some(ident) = field.ident.as_ref() {
            let c_field_name = ident;
            let r_field_name = format_ident!("{}",to_snake_name(&c_field_name.to_string()));
            //test
            if type_name == NAME {
                println!("field name:  {}:", c_field_name.to_string());
            }
            if let Type::Ptr(t) = &field.ty {
                let type_stream = if let Type::Path(TypePath { path, .. }) = t.elem.as_ref() {
                    //test
                    if type_name == NAME {
                        println!("ptr: {}:", t.elem.to_token_stream());
                        println!("ptr -path: {}", path.to_token_stream().to_string());
                    }

                    if let Some(PathSegment { ident, .. }) = path.segments.last() {
                        // if ident.to_string().as_str() == TypeName_CArray {
                            Some(ident.to_token_stream())
                        // } else {
                        //     match arguments {
                        //         PathArguments::None => Some(ident.to_token_stream()),
                        //         PathArguments::AngleBracketed(AngleBracketedGenericArguments { args, .. }) => {
                        //             if let Some(GenericArgument::Type(Type::Path(TypePath { path, .. }))) = args.last() {
                        //                 if let Some(path_segment) = path.segments.last() {
                        //                     let arg_type = &path_segment.ident;
                        //                     let q = quote! { #ident::<#arg_type> };
                        //                     Some(q)
                        //                 } else {
                        //                     println!("if let Some(path_segment) = path.segments.last()");
                        //                     None
                        //                 }
                        //             } else {
                        //                 println!("let Some(GenericArgument::Type(Type::Path(TypePath ");
                        //                 None
                        //             }
                        //         }
                        //         PathArguments::Parenthesized(_) => None,
                        //     }
                        // }
                    } else {
                        None
                    }
                } else {
                    None
                };

                let type_stream = type_stream.expect(&format!("can not find the type of field {}::{}\nfield type: \n{:?}", type_name, c_field_name, field));
                match type_stream.to_string().as_str() {
                    //*mut c_char类型
                    TYPE_NAME_C_CHAR => {
                        to_c_quote.push(quote! {
                            c.#c_field_name =  to_c_char(&r.#r_field_name)
                        });
                        ptr_rust_quote.push(quote! {
                            r.#r_field_name = to_str(c.#c_field_name).to_owned()
                        });
                    }
                    "" => {
                        panic!("dl_cr can not find the type of field {} -- {} -- not TypePath,\nfield type: \n{:?}", type_name, c_field_name,field);
                    }
                    _ => {
                        let c_type = type_stream;
                        //test
                        if type_name == NAME {
                            println!("field type : {}", c_type);
                        }
                        to_c_quote.push(quote! {
                            c.#c_field_name =  #c_type::to_c_ptr(&r.#r_field_name)
                        });
                        ptr_rust_quote.push(quote! {
                            r.#r_field_name = #c_type::ptr_rust(c.#c_field_name)
                        });
                    }
                }
            } else {
                to_c_quote.push(quote! {
                    c.#c_field_name =  r.#r_field_name
                });

                ptr_rust_quote.push(quote! {
                    r.#r_field_name = c.#c_field_name
                });
            }
        }
    }

    let c_name = format_ident!("{}",type_name);
    let gen = quote! {
        impl CR<#c_name,#r_name> for #c_name {
            fn to_c(r: &#r_name) -> #c_name {
                let mut c = #c_name::default();
                #(#to_c_quote;)*
                c
            }

            fn to_c_ptr(r: &#r_name) -> *mut #c_name {
                Box::into_raw(Box::new(#c_name::to_c(r)))
            }

            fn to_rust(c: &#c_name) -> #r_name {
                let mut r = #r_name::default();
                #(#ptr_rust_quote;)*
                r
            }

            fn ptr_rust(c: *mut #c_name) -> #r_name {
                #c_name::to_rust(unsafe { &*c })
            }
        }
    };

    if cfg!(feature = "print_macro") {
        println!("............gen impl dl_cr {}:", c_name);
        println!("{}", gen);
        // let _ = rustfmt::run(rustfmt::Input::Text(gen.to_string()), &rustfmt::config::Config::default());
    }

    //test
    if type_name == NAME {
        println!("===gen impl dl_cr end:  {}, {}", type_name, r_name);
        // let _ = rustfmt::run(rustfmt::Input::Text(gen.to_string()), &rustfmt::config::Config::default());
        println!("{}", gen);
    }
    gen.into()
}

#[cfg(test)]
mod tests {
    #[test]
    fn dl_cr_test() {
        //can not test the fn
    }
}