use uuid::Uuid;

pub fn uuid() -> String{
    Uuid::new_v4().to_string()
}
pub fn now_ts_seconds() -> i64{
    chrono::offset::Utc::now().timestamp()
}
