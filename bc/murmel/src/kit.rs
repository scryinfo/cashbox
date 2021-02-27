pub fn vec_to_string(vec: Vec<u8>) -> String {
    let mut r = String::new();
    for v in vec {
        write!(r, "{:02x}", v).expect("No write");
    }
    r
}