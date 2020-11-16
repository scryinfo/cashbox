#[cfg(test)]
mod tests {
    use cdl::{Data_new, Data_free};

    #[test]
    fn test_struct() {
        let s = unsafe { Box::from_raw(Data_new()) };
        Data_free(Box::into_raw(s));
    }
}