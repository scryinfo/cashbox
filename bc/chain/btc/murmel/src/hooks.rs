// Conditions for use CondVar
// handhsake -> header -> filter -> getdata
// handhsake -> header -> tx
pub struct Condition {
    header_ready: bool,
    fillter_ready: bool,
}

impl Condition {
    pub fn new(header_ready: bool, fillter_ready: bool) -> Self {
        Condition {
            header_ready,
            fillter_ready,
        }
    }
}

pub trait ShowCondition {
    fn get_header(&self) -> bool;
    fn get_filter(&self) -> bool;
    fn set_filter(&mut self, status: bool);
    fn set_header(&mut self, status: bool);
}

impl ShowCondition for Condition {
    fn get_header(&self) -> bool {
        self.header_ready
    }

    fn get_filter(&self) -> bool {
        self.fillter_ready
    }

    fn set_filter(&mut self, status: bool) {
        self.fillter_ready = status;
    }

    fn set_header(&mut self, status: bool) {
        self.header_ready = status
    }
}