use super::*;

pub mod chain;
pub mod digit;
pub mod wallet;


#[test]
fn create_wallet_test() {
    let mnemonic = "swarm grace knock race flip unveil pyramid reveal shoot vehicle renew axis";
    let wallet = wallet::create_wallet("wallet test", mnemonic.as_bytes(), "123456".as_bytes(), 1);
    println!("{:?}", wallet);
}
