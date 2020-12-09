use std::{fmt, io};

pub struct Error {
    pub err: String,
}

impl fmt::Debug for Error {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        fmt::Debug::fmt(&self.err, f)
    }
}

impl fmt::Display for Error {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "Db Error: {}", self.err)
    }
}

impl From<rbatis_core::Error> for Error {
    fn from(e: rbatis_core::Error) -> Self { Error::from(e.to_string().as_str()) }
}

impl From<&str> for Error {
    fn from(e: &str) -> Self { Self { err: e.to_owned() } }
}

impl From<io::Error> for Error {
    fn from(err: io::Error) -> Self { Error::from(err.to_string().as_str()) }
}