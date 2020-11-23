#[macro_use]
extern crate rbatis_macro_driver;

mod ma;
mod kits;

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}
