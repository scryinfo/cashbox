use wallets::Wallets;
use crate::types::{InitParameters, UnInitParameters, CError, CBool, CTrue, CFalse, WalletsContext, Wallet};
use std::os::raw::c_char;
use crate::kits::{CArray, CStruct};

static mut wallets: Wallets = Wallets{};

#[no_mangle]
pub extern "C" fn CChar_free(cs: *mut c_char) {
    unsafe {
        if !cs.is_null() {
            Box::from_raw(cs);
        }
    }
}

#[no_mangle]
pub extern "C" fn CError_free(error: *mut CError) {
    unsafe {
        if !error.is_null() {
            Box::from_raw(error);
        }
    }
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_lockRead() -> CBool {
    if wallets.lock_read() {
        CTrue
    } else {
        CFalse
    }
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_unlockRead() -> CBool {
    if wallets.unlock_read() {
        CTrue
    } else {
        CFalse
    }
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_lockWrite() -> CBool {
    if wallets.lock_write() {
        CTrue
    } else {
        CFalse
    }
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_unlockWrite() -> CBool {
    if wallets.unlock_read() {
        CTrue
    } else {
        CFalse
    }
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_init(params: *mut InitParameters) -> *const CError {
    let cerr = Box::new(CError::default());
    let mut p = wallets_types::InitParameters{};
    let err = wallets.init(&mut p);

    Box::into_raw(cerr)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_uninit(params: *mut UnInitParameters) -> *const CError {
    let cerr = Box::new(CError::default());
    let mut p = wallets_types::UnInitParameters{};
    let err = wallets.uninit(&mut p);

    Box::into_raw(cerr)
}

#[no_mangle]
pub unsafe extern "C" fn Wallets_all(ctx: *mut WalletsContext, ptr: *mut CArray<Wallet>) -> *const CError {
    let cerr = Box::new(CError::default());
    unsafe {
        if ptr.is_null()  {//todo 参数不正确
            // err.code ==
            return Box::into_raw(cerr)
        }
    }

    let mut tctx = wallets_types::WalletsContext{};
    let mut ws= vec![];
    let err = wallets.all(&mut tctx, &mut ws);
    //todo 类型转换
    let mut ws= ws.iter().map(|it| Wallet::default() ).collect();

    let mut cws =  Box::from_raw(ptr);
    cws.set( ws);
    let _ = Box::into_raw(cws);//不要释放内存
    Box::into_raw(cerr)
}

#[no_mangle]
pub extern "C" fn CArrayWallet_alloc() -> *mut CArray<Wallet> {
    Box::into_raw(Box::new(CArray::<Wallet>::default()))
}
#[no_mangle]
pub unsafe extern "C" fn CArrayWallet_free(ptr: *mut CArray<Wallet>) {
    Box::from_raw(ptr);
}

