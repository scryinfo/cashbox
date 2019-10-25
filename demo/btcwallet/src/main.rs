mod constructor;
mod chaindb;
mod error;
mod headercache;

use log::warn;

fn main() {
    println!("Hello, world!");
    simple_logger::init().unwrap();

    warn!("This is an example message.");
}

