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
use failure::_core::any::TypeId;

macro_rules! from_value(
    ($t:ty) => (
        impl From<$t> for ToSqlOutput<'_> {
            fn from(t: $t) -> Self { ToSqlOutput::Owned(t.into())}
        }
    )
);

pub struct QueryParams{
    data:Value,
}

impl<T> QueryParams{
    fn new(data:T)->Self{

    }
}

/*#[macro_export]
macro_rules! params {
    () => {
        $crate::NO_PARAMS
    };
    ($($param:expr),+ $(,)?) => {
        &[$(&$param as &dyn $crate::wallet_db::ToSql),+] as &[&dyn $crate::wallet_db::ToSql]
    };
}*/


#[macro_export]
macro_rules! params {
    ($($param:expr),+ $(,)?) => (
    {
        let mut values = ::std::vec::Vec::<QueryParams>::new();
        $(
          let type_value = $param.type_id();

          let value = {
            if TypeId::of::<i64>()==type_value{
                QueryParams{data:Value::Integer($param)}
            }else if(TypeId::of::<String>()==type_value){
                QueryParams{data:Value::String($param)}
            }else{
                QueryParams{data:Value::Null, }
            }
          };

    /*      let value = match type_value{
           TypeId::of::<i64>()=>QueryParams{data:Value::Integer($param),},
           TypeId::of::<String>()=>QueryParams{data:Value::String($param),},
           _=>QueryParams{data:Value::Null, },
          };*/
         values.push( value);
         )*
       values
    }
       // [$($param as  sqlite::Bindable),+].iter()
    );
}
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
    use std::any::Any;

   /* let d1 = QueryParams{
        data:Value::Integer(1i64),
    };
    let d2 = QueryParams{
        data:Value::String("s".into()),
    };
    let mut vec = vec![d1,d2];*/
  /*  let target = TypeId::of::<i64>();
    let test1 = 4i64;



    let target2 = TypeId::of::<String>();
    let test2 = String::from("hello");
    assert_eq!(test2.type_id(),target2);*/
    let param = 23i64;
    let type_value = param.type_id();

    let value = {
        if TypeId::of::<i64>()==type_value{
            QueryParams{data:Value::Integer(param)}
        }else if(TypeId::of::<String>()==type_value){
            QueryParams{data:Value::String(param)}
        }else{
            QueryParams{data:Value::Null, }
        }
    };

   // let vec = params![1i64,3i64,4i64];
  //  let vec = params!["hello".to_string()];
  //  assert_eq!(vec.len(),2);
}
