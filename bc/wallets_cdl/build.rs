//use std::fs::OpenOptions;
//use std::io::Write;

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
    // {//test
    //     let mut file = OpenOptions::new().append(true).create(true).write(true).open("/home/scry/data.txt").unwrap();
    //     file.write("\n".as_bytes());
    //     file.write(v.as_bytes());
    //     file.flush();
    // }
    consts.add_value("CARGO_BUILD_TARGET","&str",v);
}