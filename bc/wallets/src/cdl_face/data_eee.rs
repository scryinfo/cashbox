
// eee
#[repr(C)]
#[derive(Clone, Default)]
pub struct EeeChain {
    pub chain_shared: ChainShared,
    pub tokens: Vec<EeeToken>,
}

#[repr(C)]
#[derive(Clone, Default)]
pub struct EeeToken {
    pub token_shared: TokenShared,
}

#[repr(C)]
#[derive(Clone, Default)]
pub struct EeeDefaultToken{
    pub token_shared: TokenShared,

}

#[repr(C)]
#[derive(Clone, Default)]
pub struct EeeAuthToken {
    pub token_shared: TokenShared,
}

// eee end