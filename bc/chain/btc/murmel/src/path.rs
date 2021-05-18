#[cfg(target_os = "android")]
pub const BTC_HAMMER_PATH: &str = r#"/data/data/wallet.cashbox.scry.info/files/btc_hammer.db"#;

#[cfg(any(target_os = "linux", target_os = "windows", target_os = "macos"))]
pub const BTC_HAMMER_PATH: &str = r#"btc_hammer.db"#;

#[cfg(target_os = "android")]
pub const PATH: &str = r#"/data/data/wallet.cashbox.scry.info/files/"#;

#[cfg(any(target_os = "linux", target_os = "windows", target_os = "macos"))]
pub const PATH: &str = r#""#;