//对称加密算法进行封装，为上层业务使用
pub mod aes {
    use crypto::buffer::{BufferResult, ReadBuffer, WriteBuffer};
    use crypto::symmetriccipher::{Decryptor, Encryptor};
    use crypto::{aes, buffer, symmetriccipher};

    #[derive(Debug)]
    pub enum EncryptMethod {
        Aes128Ctr,
        Aes256Ctr,
    }

    //选用指定的加密方式，为传入的数据使用对称方式加密
    pub fn encrypt(medthod: EncryptMethod, data: &[u8], key: &[u8], iv: &[u8]) -> Result<Vec<u8>, String> {
        let mut encryptor = match medthod {
            EncryptMethod::Aes128Ctr => aes::ctr(aes::KeySize::KeySize128,&key[0..16], iv),
            EncryptMethod::Aes256Ctr => aes::ctr(aes::KeySize::KeySize256, key, iv),
        };
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

    // 对加密内容进行解密, 注意：在输入密码错误的情况下，此处的解密函数并不能检测出来，只能依靠加密前的hash值来进行判断
    pub fn decrypt(medthod: EncryptMethod,
                   encrypted_data: &[u8],
                   key: &[u8],
                   iv: &[u8],
    ) -> Result<Vec<u8>,String> {
        let mut decryptor = match medthod {
            EncryptMethod::Aes128Ctr => aes::ctr(aes::KeySize::KeySize128, &key[0..16], iv),
            EncryptMethod::Aes256Ctr => aes::ctr(aes::KeySize::KeySize256, key, iv),
        };
        let mut final_result = Vec::<u8>::new();
        let mut read_buffer = buffer::RefReadBuffer::new(encrypted_data);
        let mut buffer = [0; 4096];
        let mut write_buffer = buffer::RefWriteBuffer::new(&mut buffer);
        loop {
            let result =  decryptor
                .decrypt(&mut read_buffer, &mut write_buffer, true).unwrap();
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
    fn it_works() {
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
