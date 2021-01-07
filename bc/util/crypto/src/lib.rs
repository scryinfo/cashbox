use tiny_keccak::Keccak;

pub trait Keccak256<T> {
    fn keccak256(&self) -> T
        where T: Sized;
}

pub fn hexstr_to_vec(hexstr: &str) -> Result<Vec<u8>, hex::FromHexError> {
    let hexstr = hexstr
        .trim_matches('\"')
        .to_string()
        .trim_start_matches("0x")
        .trim()
        .to_string();
    hex::decode(&hexstr)
}

impl<T> Keccak256<[u8; 32]> for T where T: AsRef<[u8]> {
    fn keccak256(&self) -> [u8; 32] {
        let mut keccak = Keccak::new_keccak256();
        let mut result = [0u8; 32];
        keccak.update(self.as_ref());
        keccak.finalize(&mut result);
        result
    }
}

//Symmetric encryption algorithm for encapsulation and use for upper-layer services
pub mod aes {
    use crypto::buffer::{BufferResult, ReadBuffer, WriteBuffer};
    use crypto::symmetriccipher::{Decryptor, Encryptor, SynchronousStreamCipher};
    use crypto::{aes, buffer};

    #[derive(Debug)]
    pub enum EncryptMethod {
        Aes128Ctr,
        Aes256Ctr,
    }
    fn create_aes_instance(method: EncryptMethod,key: &[u8], iv: &[u8])-> Box<dyn SynchronousStreamCipher> {
        match method {
            EncryptMethod::Aes128Ctr => aes::ctr(aes::KeySize::KeySize128, &key[0..16], iv),
            EncryptMethod::Aes256Ctr => aes::ctr(aes::KeySize::KeySize256, key, iv),
        }
    }
    //Use the specified encryption method to encrypt the incoming data symmetrically
    pub fn encrypt(medthod: EncryptMethod, data: &[u8], key: &[u8], iv: &[u8]) -> Result<Vec<u8>, String> {

        let mut encryptor = create_aes_instance(medthod,key,iv);
        let mut final_result = Vec::<u8>::new();
        let mut read_buffer = buffer::RefReadBuffer::new(data);
        let mut buffer = [0; 4096];
        let mut write_buffer = buffer::RefWriteBuffer::new(&mut buffer);
        loop {
            let result = encryptor
                .encrypt(&mut read_buffer, &mut write_buffer, true)
                .unwrap();
            final_result.extend(
                write_buffer
                    .take_read_buffer()
                    .take_remaining()
                    .iter()
                    .clone(),
            );

            match result {
                BufferResult::BufferUnderflow => break,
                BufferResult::BufferOverflow => {}
            }
        }
        Ok(final_result)
    }

    // Decrypt the encrypted content. Note: In the case of incorrect password, the decryption function here cannot be detected, and can only be judged by the hash value before encryption
    pub fn decrypt(medthod: EncryptMethod,encrypted_data: &[u8], key: &[u8],iv: &[u8],) -> Result<Vec<u8>, String> {
        let mut decryptor  = create_aes_instance(medthod,key,iv);
        let mut final_result = Vec::new();
        let mut read_buffer = buffer::RefReadBuffer::new(encrypted_data);
        let mut buffer = [0u8; 4096];
        let mut write_buffer = buffer::RefWriteBuffer::new(&mut buffer);
        loop {
            let result = decryptor.decrypt(&mut read_buffer, &mut write_buffer, true).unwrap();
            final_result.extend(
                write_buffer
                    .take_read_buffer()
                    .take_remaining()
                    .iter()
                    .clone(),
            );
            match result {
                BufferResult::BufferUnderflow => break,
                BufferResult::BufferOverflow => {}
            }
        }
        Ok(final_result)
    }
}

#[cfg(test)]
mod tests {
    use crate::aes;
    #[test]
    fn encrypt_test() {
        let iv = b"1234567812345678";
        let key = b"1234567812345678";
        let data = "hello world";
        let encrypt_ret = aes::encrypt(aes::EncryptMethod::Aes128Ctr, data.as_bytes(), key, iv);
        let enc_bytes = &encrypt_ret.unwrap()[..];
        let decrypt_ret = aes::decrypt(aes::EncryptMethod::Aes128Ctr, enc_bytes, b"1234567812345678", iv);
        let content = String::from_utf8(decrypt_ret.unwrap());
        assert_eq!(data, content.unwrap());
    }
}
