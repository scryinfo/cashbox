
// eth
#[repr(C)]
#[derive(Clone, Default)]
pub struct EthChain {
    pub chain_shared: ChainShared,
    pub eth: EthToken,
    pub tokens: Vec<EthToken>,
}

#[repr(C)]
#[derive(Clone, Default)]
pub struct EthToken {
    pub token_shared: TokenShared,
}

#[repr(C)]
#[derive(Clone, Default)]
pub struct EthDefaultToken{
    pub token_shared: TokenShared,

}

#[repr(C)]
#[derive(Clone, Default)]
pub struct EthAuthToken {
    pub token_shared: TokenShared,
}
// eth end