// 用于实现对各个模块的封装，实现ios、android jni接口的封装
pub mod wallet;
pub mod chain;
pub mod digit;
pub mod substrate;

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}
