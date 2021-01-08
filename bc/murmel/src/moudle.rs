//moudle will difine in cashbox/bc/mav/src/ma in future(That will generate creat db sql script by proc_macro)
pub mod chain;
pub mod detail;

use rbatis_macro_driver::crud_enable;
use serde::{Serialize, Deserialize};