// It is used to realize the packaging of each module and the packaging of ios and android jni interfaces
use wallets::StatusCode;
use jni::JNIEnv;
type JniResult<T> = jni::errors::Result<T>;

pub mod wallet;
pub mod chain;
pub mod digit;

