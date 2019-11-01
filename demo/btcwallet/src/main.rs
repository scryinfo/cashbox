mod constructor;
mod chaindb;
mod error;
mod headercache;
mod p2p;
mod downstream;
mod timeout;
mod dispatcher;
mod headerdownload;
mod ping;

use log::warn;

fn main() {
    println!("Hello, world!");
    simple_logger::init().unwrap();

    warn!("This is an example message.");
}

