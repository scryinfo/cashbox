use super::*;
use std::borrow::Cow;
use sqlite::{Bindable, Value};

mod db_helper;

pub mod table_desc;
pub mod wallet;
pub mod chain;
pub mod digit;

pub use db_helper::DataServiceProvider;
pub use wallet_db::table_desc::DigitExport;

#[derive(Clone, Debug, PartialEq)]
#[non_exhaustive]
pub enum ToSqlOutput<'a> {
    /// A borrowed SQLite-representable value.
    Borrowed(ValueRef<'a>),

    /// An owned SQLite-representable value.
    Owned(Value),

    /// `feature = "blob"` A BLOB of the given length that is filled with
    /// zeroes.
    #[cfg(feature = "blob")]
    ZeroBlob(i32),

    /// `feature = "array"`
    #[cfg(feature = "array")]
    Array(Array),
}

#[derive(Copy, Clone, Debug, PartialEq)]
pub enum ValueRef<'a> {
    /// The value is a `NULL` value.
    Null,
    /// The value is a signed integer.
    Integer(i64),
    /// The value is a floating point number.
    Real(f64),
    /// The value is a text string.
    String(&'a [u8]),
    /// The value is a blob of data
    Blob(&'a [u8]),
}


// Generically allow any type that can be converted into a ValueRef
// to be converted into a ToSqlOutput as well.
impl<'a, T: ?Sized> From<&'a T> for ToSqlOutput<'a>
    where
        &'a T: Into<ValueRef<'a>>,
{
    fn from(t: &'a T) -> Self {
        ToSqlOutput::Borrowed(t.into())
    }
}

/// A trait for types that can be converted into SQLite values.
pub trait ToSql {
    /// Converts Rust value to SQLite value
    fn to_sql(&self) -> Result<ToSqlOutput<'_>,sqlite::Error>;
}

impl<T: ToSql + ToOwned + ?Sized> ToSql for Cow<'_, T> {
    fn to_sql(&self) -> Result<ToSqlOutput<'_>,sqlite::Error> {
        self.as_ref().to_sql()
    }
}

impl<T: ToSql + ?Sized> ToSql for Box<T> {
    fn to_sql(&self) -> Result<ToSqlOutput<'_>,sqlite::Error> {
        self.as_ref().to_sql()
    }
}

impl<T: ToSql + ?Sized> ToSql for std::rc::Rc<T> {
    fn to_sql(&self) -> Result<ToSqlOutput<'_>,sqlite::Error> {
        self.as_ref().to_sql()
    }
}

impl<T: ToSql + ?Sized> ToSql for std::sync::Arc<T> {
    fn to_sql(&self) -> Result<ToSqlOutput<'_>,sqlite::Error> {
        self.as_ref().to_sql()
    }
}

macro_rules! from_value(
    ($t:ty) => (
        impl From<$t> for ToSqlOutput<'_> {
            fn from(t: $t) -> Self { ToSqlOutput::Owned(t.into())}
        }
    )
);

#[macro_export]
macro_rules! params {
    () => {
        $crate::NO_PARAMS
    };
    ($($param:expr),+ $(,)?) => {
        &[$(&$param as &dyn $crate::wallet_db::ToSql),+] as &[&dyn $crate::wallet_db::ToSql]
    };
}



/*#[macro_export]
macro_rules! params {
    ($($param:expr),+ $(,)?) => (
    {
        let mut values = ::std::vec::Vec::<Value>::new();
        $(
         let value = Value::from($param );
         values.push(value);
         )*
       values
    }
       // [$($param as  sqlite::Bindable),+].iter()
    );
}*/
// &[$(&$param as &dyn sqlite::Bindable),+] as &[&dyn sqlite::Bindable]

//创建数据库表。导入默认数据等操作
pub fn init_wallet_database() -> WalletResult<()> {
    wallet_db::DataServiceProvider::init()?;
    let helper = wallet_db::DataServiceProvider::instance()?;
    helper.tx_begin()?;
    match helper.init_basic_digit() {
        Ok(_) => helper.tx_commint(),
        Err(err) => {
            helper.tx_rollback()?;
            Err(err)
        }
    }
}

pub fn execute(sql: &str, params: &[Value]) -> WalletResult<()>
{
    let helper = wallet_db::DataServiceProvider::instance()?;
    let mut state = helper.db_hander.prepare(sql)?;
    let mut index = 0;
    for param in params.into_iter() {
        index+=1;
        state.bind(index,param);
    }
    state.next().map(|_|()).map_err(|err| err.into())
}
//fn execute(sql:String,pa)

#[test]
fn init_database_test() {
    init_wallet_database();
}

#[test]
fn macro_test(){
    let vec = params![1i64,"s",3i64,4i64];
    assert_eq!(vec.len(),4);
}
