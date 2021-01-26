fn main(){
    let mut consts = build_const::ConstWriter::for_build("constants").unwrap().finish_dependencies();
    let v = match std::env::var("CARGO_BUILD_TARGET"){
        Ok(val) => val,
        Err(_) => {
            match std::env::var("TARGET"){
                Ok(val) => val,
                Err(_) => "any".to_owned(),
            }
        }
    };
    consts.add_value("CARGO_BUILD_TARGET","&str",v);
}