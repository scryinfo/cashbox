// It is used to realize the packaging of each module and the packaging of ios and android jni interfaces

pub mod wallet;
pub mod chain;
pub mod digit;

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}
