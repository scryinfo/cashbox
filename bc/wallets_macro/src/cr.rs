use proc_macro::TokenStream;

use quote::{format_ident, quote};
use syn::{AngleBracketedGenericArguments, Fields, GenericArgument, PathArguments, PathSegment, Type, TypePath};
use syn::export::ToTokens;

use crate::to_snake_name;

pub fn dl_cr(type_name: &str, fields: &Fields) -> TokenStream {
    const NAME: &str = "";
    let r_name = {
        let mut str = type_name.to_owned();
        str.remove(0);
        format_ident!("{}",str)
    };

    let mut to_c_quote = Vec::new();
    let mut ptr_rust_quote = Vec::new();
    for field in fields.iter() {
        if let Some(ident) = field.ident.as_ref() {
            let c_field_name = ident;
            let r_field_name = format_ident!("{}",to_snake_name(&c_field_name.to_string()));
            if let Type::Ptr(t) = &field.ty {
                let type_stream = if let Type::Path(TypePath { path, .. }) = t.elem.as_ref() {
                    //test
                    if type_name == NAME {
                        println!("===gen impl dl_cr {}:", t.elem.to_token_stream());
                    }
                    if let Some(PathSegment { ident, arguments }) = path.segments.last() {
                        match arguments {
                            PathArguments::None => Some(ident.to_token_stream()),
                            PathArguments::AngleBracketed(AngleBracketedGenericArguments { args, .. }) => {
                                if let Some(GenericArgument::Type(Type::Path(TypePath { path, .. }))) = args.last() {
                                    if let Some(path_segment) = path.segments.last() {
                                        let arg_type = &path_segment.ident;
                                        let q = quote! {
                                            #ident::<#arg_type>
                                        };
                                        Some(q)
                                    } else {
                                        None
                                    }
                                } else {
                                    None
                                }
                            }
                            PathArguments::Parenthesized(_) => None,
                        }
                    } else {
                        None
                    }
                } else {
                    None
                };

                let type_stream = type_stream.expect(&format!("can not find the type of field {}::{}", type_name, c_field_name));
                match type_stream.to_string().as_str() {
                    //*mut c_char类型
                    "c_char" => {
                        to_c_quote.push(quote! {
                            c.#c_field_name =  to_c_char(&r.#r_field_name)
                        });
                        ptr_rust_quote.push(quote! {
                            r.#r_field_name = to_str(c.#c_field_name).to_owned()
                        });
                    }
                    "" => {
                        panic!("dl_cr can not find the type of field {} -- {} -- not TypePath", type_name, c_field_name)
                    }
                    _ => {
                        let ctype = type_stream;
                        //test
                        if type_name == NAME {
                            println!("field type : {}", ctype);
                        }
                        to_c_quote.push(quote! {
                            c.#c_field_name =  #ctype::to_c_ptr(&r.#r_field_name)
                        });
                        ptr_rust_quote.push(quote! {
                            r.#r_field_name = #ctype::ptr_rust(c.#c_field_name)
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
        //test
        if type_name == NAME {
            println!("............gen impl dl_cr {}:", type_name);
            for it in ptr_rust_quote.iter() {
                println!("{}", it);
            }
            for it in to_c_quote.iter() {
                println!("{}", it);
            }
        }
    }

    //test
    if type_name == NAME {
        println!("............gen impl dl_cr {}:", type_name);
        println!("{}", r_name)
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
        println!("............gen impl dl_cr {}:\n {}", c_name, gen);
    }

    //test
    if type_name == NAME {
        println!("............gen impl dl_cr {}:\n {}", c_name, gen);
    }
    gen.into()
}

#[cfg(test)]
mod tests {
    use proc_macro_roids::DeriveInputStructExt;
    // use proc_macro_roids::FieldExt;
    use syn::{Fields, FieldsNamed, parse_quote, Variant};

    use crate::cr::dl_cr;

    #[test]
    fn test_dl_cr() {
        let fields_named: FieldsNamed = parse_quote! {{
            pub id: *mut c_char,
            pub data: *mut CArray<T>,
        }};
        let name = "Test";
        let fields = Fields::from(fields_named);
        // let tm = dl_cr(&name, &fields);
        // let code = tm.to_string();
        // // assert_eq!(true, code.contains("id TEXT PRIMARY KEY"));
        // println!("{}", code);
    }
}