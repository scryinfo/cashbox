#[cfg(target_os = "android")]
pub const BTC_HAMMER_PATH: &str = r#"/data/data/wallet.cashbox.scry.info/files/btc_hammer.db"#;

#[cfg(any(target_os = "linux", target_os = "windows", target_os = "macos"))]
pub const BTC_HAMMER_PATH: &str = r#"btc_hammer.db"#;

#[cfg(target_os = "android")]
pub const BTC_CHAIN_PATH: &str = r#"/data/data/wallet.cashbox.scry.info/files/btc_chain.db"#;

#[cfg(any(target_os = "linux", target_os = "windows", target_os = "macos"))]
pub const BTC_CHAIN_PATH: &str = r#"btc_chain.db"#;

#[cfg(target_os = "android")]
pub const BTC_DETAIL_PATH: &str = r#"/data/data/wallet.cashbox.scry.info/files/btc_detail.db"#;

#[cfg(any(target_os = "linux", target_os = "windows", target_os = "macos"))]
pub const BTC_DETAIL_PATH: &str = r#"btc_detail.db"#;