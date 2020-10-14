// It is used to realize the packaging of each module and the packaging of ios and android jni interfaces
use jni::JNIEnv;
use jni::sys::{jint, jobject, jbyteArray,jboolean};
use jni::objects::{JObject, JValue, JClass, JString};

use wallets::{StatusCode, WalletError};

type JniResult<T> = jni::errors::Result<T>;

pub mod wallet;
pub mod chain;
pub mod digit;
