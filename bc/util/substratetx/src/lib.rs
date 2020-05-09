#[macro_use]
extern crate serde_derive;

mod crypto;
mod error;

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}
