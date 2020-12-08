pub mod ma;
pub mod kits;
pub mod db;
pub use db::Error;

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}
