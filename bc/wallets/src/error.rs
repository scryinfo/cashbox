use std::io;
use std::error;
use std::fmt;

#[derive(Debug)]
pub enum WalletError{
    Io(io::Error),
    Db(sqlite::Error),
}

impl fmt::Display for WalletError{
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
      /*  match *self {
            WalletError::Io(ref err)=>write!("IO error:{}",err),
            WalletError::Db(ref err)=>write!("Parse database error:{}",err),
        }*/
        unimplemented!()
    }
}

impl error::Error for WalletError {
    fn description(&self) -> &str {
        // Both underlying errors already impl `Error`, so we defer to their
        // implementations.
      /*  match *self {
            WalletError::Io(ref err) => err.description(),
            WalletError::Db(ref err) => err.description(),
        }*/
        unimplemented!()
    }

    fn cause(&self) -> Option<&error::Error> {
      /* match *self {
           WalletError::Io(ref err) => Some(err),
           WalletError::Db(ref err) => Some(err),
        }*/
        unimplemented!()
    }
}