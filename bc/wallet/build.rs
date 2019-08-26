
extern crate vcpkg;

fn main() {
    if cfg!(windows) && cfg!(target_env = "msvc") {
        vcpkg::find_package("sqlite3").unwrap();
    }
}
