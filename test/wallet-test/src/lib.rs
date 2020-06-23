// 用于实现对各个模块的封装，实现ios、android jni接口的封装
use wallets::StatusCode;
use jni::JNIEnv;

pub mod wallet;
pub mod chain;
pub mod digit;
