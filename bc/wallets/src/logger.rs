#[cfg(target_os = "android")]
pub fn init_logger_once() {
    android_logger::init_once(
        android_logger::Config::default()
            .with_min_level(log::Level::Trace) // limit log level
            .with_tag("rust") // logs will show under mytag tag
            .with_filter( // configure messages for specific crate
                          android_logger::FilterBuilder::new()
                              .parse("debug,hello::crate=error")
                              .build())
    );
    log::trace!("init logger");
}