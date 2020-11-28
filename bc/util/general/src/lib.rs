///
/// this package provide some basic function which can be used other modules,such as hex to vec,unit convert etc..
///
use ethereum_types::U256;

pub fn hexstr_to_vec(hexstr: &str) -> Result<Vec<u8>,hex::FromHexError> {
    let hexstr = hexstr
        .trim_matches('\"')
        .to_string()
        .trim_start_matches("0x")
        .to_string();
    hex::decode(&hexstr)
}

//According to the precision, convert the number of string input to the minimum progress to represent
pub fn token_unit_convert(value: &str, decimal: usize) -> Option<U256> {
    //Determine whether the number to be converted is a floating point number
    match value.find('.') {
        Some(index) => {
            let integer_part = value.get(0..index).unwrap();
            let integer_part_256 = U256::from_dec_str(integer_part).unwrap();
            let integer_part_value = integer_part_256.checked_mul(U256::exp10(decimal)).unwrap();
            //Get the fractional part, only retain the data with the specified precision
            let max_distace = if value.len() - index <= decimal {
                value.len()
            } else {
                index + 1 + decimal
            };
            let decimal_part = value.get((index + 1)..max_distace).unwrap();
            let decimal_part_256 = U256::from_dec_str(decimal_part).unwrap();
            //After removing the decimal point, you need to add 0 at the end
            let base = U256::exp10(decimal - decimal_part.len());
            let decimal_part_value = decimal_part_256.checked_mul(base).unwrap();
            integer_part_value.checked_add(decimal_part_value)
        }
        None => {
            let integer_part = U256::from_dec_str(value).unwrap();
            let integer_part_wei = integer_part.checked_mul(U256::exp10(decimal));
            integer_part_wei
        }
    }
}
#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}
