//! mod for rust-wallet

use bitcoin::blockdata::opcodes;
use bitcoin::blockdata::script::Builder;

use bitcoin::hashes::hex::FromHex;
use bitcoin::util::psbt::serialize::Serialize;
use bitcoin::{Network, OutPoint, Script, SigHashType, Transaction, TxIn, TxOut};
use bitcoin_hashes::sha256d;
use bitcoin_wallet::account::{Account, AccountAddressType, MasterAccount, Unlocker};
use bitcoin_wallet::mnemonic::Mnemonic;
use hex::decode as hex_decode;
use log::error;

const PASSPHRASE: &str = "";

pub fn create_master() -> Transaction {
    let words = "lawn duty beauty guilt sample fiction name zero demise disagree cram hand";
    let mnemonic = Mnemonic::from_str(&words).expect("don't have right mnemonic");
    let mut master =
        MasterAccount::from_mnemonic(&mnemonic, 0, Network::Testnet, PASSPHRASE, None).unwrap();
    let mut unlocker = Unlocker::new_for_master(&master, PASSPHRASE).unwrap();
    let account = Account::new(&mut unlocker, AccountAddressType::P2PKH, 0, 0, 10).unwrap();
    master.add_account(account);

    let account = master.get_mut((0, 0)).unwrap();
    let instance_key = account.next_key().unwrap();
    let source = instance_key.address.clone();
    let public_key = instance_key.public.clone();
    let public_compressed = public_key.serialize();
    let public_compressed = hex::encode(public_compressed);
    error!("source {}", &source);
    error!("public_compressed {:#?}", &public_compressed);

    let account = Account::new(&mut unlocker, AccountAddressType::P2PKH, 0, 1, 10).unwrap();
    master.add_account(account);
    let account = master.get_mut((0, 1)).unwrap();
    let instance_key = account.next_key().unwrap();
    let target = instance_key.address.clone();
    let public_key = instance_key.public.clone();
    let public_compressed = public_key.serialize();
    let public_compressed = hex::encode(public_compressed);
    error!("target {:?}", &target);
    error!("public_compressed {:?}", &public_compressed);

    const RBF: u32 = 0xffffffff - 2;
    //a transaction that spend spend spend source to target
    let mut spending_transaction = Transaction {
        input: vec![TxIn {
            previous_output: OutPoint {
                txid: sha256d::Hash::from_hex(
                    "d2730654899df6efb557e5cd99b00bcd42ad448d4334cafe88d3a7b9ce89b916",
                )
                .unwrap(),
                vout: 1,
            },
            sequence: RBF,
            witness: Vec::new(),
            script_sig: Script::new(),
        }],
        output: vec![TxOut {
            script_pubkey: target.script_pubkey(),
            value: 21000,
        }],
        lock_time: 0,
        version: 2,
    };

    let script = Builder::new()
        .push_opcode(opcodes::all::OP_DUP)
        .push_opcode(opcodes::all::OP_HASH160)
        .push_slice(&hex_decode("44af04fb17f6d79b93513e49c79c15ca29d56290").unwrap())
        .push_opcode(opcodes::all::OP_EQUALVERIFY)
        .push_opcode(opcodes::all::OP_CHECKSIG)
        .into_script();

    master
        .sign(
            &mut spending_transaction,
            SigHashType::All,
            &(|_| {
                Some(TxOut {
                    value: 21000,
                    script_pubkey: script.clone(),
                })
            }),
            &mut unlocker,
        )
        .expect("can not sign");

    error!("tx {:#?}", &spending_transaction);
    spending_transaction
}

// create mnemonic from bc/wallet
// the function is generate_mnemonic
// pub fn generate_mnemonic() {
//     let mnemonic = wallets::Wallets::generate_mnemonic(12);
//     println!("{}", mnemonic);
// }

#[cfg(test)]
mod test {
    use crate::kit::vec_to_string;
    use crate::walletlib::create_master;
    use bitcoin::consensus::serialize as btc_serialize;
    use bitcoin::consensus::{deserialize, serialize};
    use bitcoin::hashes::sha256d;
    use bitcoin::util::misc::hex_bytes;
    use bitcoin::{
        Address, BitcoinHash, Network, OutPoint, Script, SigHashType, Transaction, TxIn, TxOut,
    };
    use bitcoin_hashes::hex::ToHex;
    use bitcoin_hashes::Hash;
    use bitcoin_wallet::account::{Account, AccountAddressType, MasterAccount, Unlocker};
    use bitcoin_wallet::mnemonic::Mnemonic;
    use futures::executor::block_on;
    use mav::{kits, CTrue, NetType, WalletType};
    use std::collections::HashMap;
    use std::fmt::Write;
    use std::str::FromStr;

    #[test]
    pub fn bitcoin_hash_test() {
        let tx = create_master();
        let ser = serialize(&tx);
        let hash = tx.bitcoin_hash().to_hex();

        println!("tx {:#?}", &tx);
        println!("hash {:#?}", &hash);
        println!("hex_bytes {:0x?}", &ser);
        let hex_tx = hex_bytes(&vec_to_string(ser)).unwrap();
        let tx_deser: Result<Transaction, _> = deserialize(&hex_tx);
        assert_eq!(tx, tx_deser.unwrap());
    }

    #[test]
    pub fn test_create_master() {
        let tx = create_master();
        let vouts = tx.output;
        for (index, vout) in vouts.iter().enumerate() {
            let vout = vout.to_owned();
            let script = vout.script_pubkey;
            if script.is_p2pkh() {
                let asm = script.asm();
                let mut iter = asm.split_ascii_whitespace();
                let a = iter.next();
                println!("1  {}", a.unwrap());
                let a = iter.next();
                println!("2  {}", a.unwrap());
                let a = iter.next();
                println!("3  {}", a.unwrap());
                let a = iter.next();
                println!("4  {}", a.unwrap());
            }
        }
    }

    // #[test]
    // pub fn bitcoin_txinput_test2() {
    //     let hex_tx = hex_bytes("02000000440735ab4dc68f78139dbb2917d74da8adb80b30e26351402593ad59dd25822dfb0000000023220020c5cb2845cf040b8ddf7e08a49a4ae82a90ca51b010db0a36fe6a66c7117dbd8afdffffffd9ec2c53821d62c3f96447b89e6dbd85735cce69869a7c39bb5201d6b16a54aa00000000232200200f367512cfb2ba1a16411f5bd2c065fd89151accdea281562fdf01e23129909efdffffff67fd6cda37f2530e7a939cf6ae6576ab5070b06a5a55a320f8139eb0907c259d0000000023220020b82920607065ed70bdd0fe915eca9542c2fed6b95ec4d7866768d569acda368bfdffffff24814c88695d1898312dd6bb8068944333f034c0dd25530c2738487ecec43a7f01000000232200206a0b495283b08505a048baac900ddadd756548e8297aa9c996e2d3757b563550fdffffff3215e15956dbaac7c776c16041b0eba88aec1dda01db807916924d49045a2eba0000000023220020bf3a63a31a8a7e07f3fe817af400e84400d376ac797b75add3f56cfdd2b04365fdffffffe8ad94f360c2dc0e6bc9385aadac8aae0f96340ba90d1a447fda7931a19f2cce010000002322002053c7c33571fdcbfd1883b3eb49242a4b456d4eb94f2b9f6105fa1770b898a60efdffffff6dbae0da8b6bd1bce8045fa501b1da3d73ad41ac4e046ca11fef8adb1f17f64f01000000232200200b9c860d33e2e0c86c99878b460000c1a6dc9d76f477ed7fd16389b78e072b34fdffffffe2f68ab41cbf221ed735652d7b9145106008fb69353737fcaef64d6b0a2be1350000000023220020165999fe6ad97ee2afd85ff712e931aafc8e547f6c96d6376f05377263a26f31fdffffffe4793d2e7dcce19619bc1db203a7595f362dbe7a79de56da05650bb374a14846010000002322002095a353f13e77e588ffad52e54df3deb0e77bc2ab93375674e6972184277fb3a7fdfffffffdcd001ca77e7291921f4c85e2c810118e42f26dea1e641a6cf78caa61da5e9200000000232200208c990d0745b540bb50bd49cbdab6840f3bf75e4f53e55206035278d3dbc3388bfdffffff4f82cb4c90f9dd2b01b61fbee2b8b6c2347dac999c4bfa501d50e59cbc8fdf660000000023220020605286bd035430bfcd781ace7d6bea22a0ffc41e21efc539c230006a2b617a0cfdffffff011348278945c15b293103b73ccbc192bc77d5fa9b495548194cd9fce3b765420000000023220020a2453c99eba18177cb0cf07763d89d5ba5a2ed4b050a74537314057d58a97a77fdffffffe8675100c8e6788925cbbe17ac1ea5b5173141b72fe9656f3f2d6817862fd4a00000000023220020a5f98edf1c321d4a212639645a21a91d4c4fbe78f8676ecc126d2ab55eaa81defdffffffafb99320f74eef4235907a2b4aefba4647eb281fb0d600196d76e6e22e1190100100000023220020a9a56ade9aeb42c43b318e327786279e5870ed676e8df52945fee19d22b0cf5bfdffffff2e69bd50f9eb9031cd0f7016caa073858e0ae3f4ff18d1b4daeb785b5cb554020100000023220020f40ee45ed3140f216f4fe0a59f033b0bde0641445f90d16b71a108a081a13f81fdffffff2300aa47555a4991d2992a3d720124e04c753c92c02d5d8228a921738e40cd8f0000000023220020a6813294a8547c977f9c2644449a79720c54fc1e6ac773290b093060c153b057fdffffff06de9ea1dbfc7793fdddc7158615da62e6dc41dd588926b105ad996ffadaee440100000023220020d3a8ca61bcc406f101780f5de8a0a7ccc394ca1bf15aa2aa0811b5b7ede4bffefdffffff48c01a389d58736a24f398eaea885bf1571982da4ce4d1f3c258e2bf4944803a0000000023220020d4fe624e52c93ce970cf9d60bd8dbc1e69db9c0cc11cc00e4065b5a4e381ff59fdffffff4a9996758f92e667a8625c053d56ff5df3dbf982774939db4cd5eedb6d2e9fcb0100000023220020d8360682053d9847f72297e5e8ac12221bba3c48b9c5157ba581d0002f444f70fdffffff88ec3b707cd79dd18589900a02c041b43f963e15ab1483a2651a0bb3c97934b1010000002322002026dc8a3f05eba4c9319e0a1c7919c3b0eb8e491bd38f38a97a53b59cc67e3097fdffffff62d984fd19677501a655fde3153f30e63ff257c82f048c0331304afca6794d7b010000002322002026dc8a3f05eba4c9319e0a1c7919c3b0eb8e491bd38f38a97a53b59cc67e3097fdffffff82ff059be8be36bc7adc6f297821a933d03a36e722e9c02959b063b45b03368f010000002322002026dc8a3f05eba4c9319e0a1c7919c3b0eb8e491bd38f38a97a53b59cc67e3097fdffffff48f882adab8aa7580da83c4ffcf1b690bc71bdca7a521907dc63ad27b4865d9b01000000232200204a97825c3beea1a6bfe047c8311946e85ac1ca16ee29f85e8011a446756cc656fdffffffeb47360bdc8082276096815c882cc8582979e6f98f25a0e142512ba1c78acd3f0100000023220020d4fe624e52c93ce970cf9d60bd8dbc1e69db9c0cc11cc00e4065b5a4e381ff59fdfffffff979758abe0d3b6ff9ae655285e2ec87783829936bf417e3c7500e391555cb840100000023220020d4fe624e52c93ce970cf9d60bd8dbc1e69db9c0cc11cc00e4065b5a4e381ff59fdffffff63e39053e0510c72e882bf3a1d25bfb8b758a5229064da20a48f9ebc42c4124401000000232200205943b4b5e63194315f0c1f5e17382c1523bc024ca5ff490df5667606687b6c8cfdfffffffc8d22a2001a8753fe6fdde14d31df9a90ab77412d1645274744ab8ce4ed0f7a00000000232200205943b4b5e63194315f0c1f5e17382c1523bc024ca5ff490df5667606687b6c8cfdffffff0528799d865e3c66205c1a8ff8f36749bbee777a33cfd8dd5d1b6b6ec9e6a99f01000000232200205943b4b5e63194315f0c1f5e17382c1523bc024ca5ff490df5667606687b6c8cfdffffff325af76d6d15c62670e224c28b3b8be526cf83b7afa9001865ba714e50ec7df0010000002322002094f3951cf1c77454723dd9ea6c0fbbed2bf567c3ec06b2cb3ba7cb0799c6fb85fdffffffa48ca0a576818cde4476068a27522377532e03ede58eab43b72ac80e427d07a4000000002322002094f3951cf1c77454723dd9ea6c0fbbed2bf567c3ec06b2cb3ba7cb0799c6fb85fdffffff05d90b8ded307c1f13ab06fc83faf87597f1e1087dfd9bc92be20d4f82674bf6000000002322002094f3951cf1c77454723dd9ea6c0fbbed2bf567c3ec06b2cb3ba7cb0799c6fb85fdffffff07415d9622b3a66ffb0fa16b856387ffc9330a05337b04081d8b187e1d645ea201000000232200204a97825c3beea1a6bfe047c8311946e85ac1ca16ee29f85e8011a446756cc656fdffffff474a42bb42bd1e764ee314a4d06a7d6d62119f22c54da8926d939a85f6f2f0cc0100000023220020d4fe624e52c93ce970cf9d60bd8dbc1e69db9c0cc11cc00e4065b5a4e381ff59fdffffff2e9dfaa815cb437e5f4c2dd2d535f0a1845967b060f68c73770b5476563825870000000023220020705007ae3023ac4a2dedc775e5b3ac3e1a4a44c009f54a07e65a4db7e43669c7fdffffff7ed940881ffe923b47287af143da3ac021298995da1fdb64a9a7b7abee90f0bc0000000023220020705007ae3023ac4a2dedc775e5b3ac3e1a4a44c009f54a07e65a4db7e43669c7fdffffff5154315b173587a996fff1ee6011cec9cc0321ca5f926c6c9d09a33a0e1fe85e270000002322002094f3951cf1c77454723dd9ea6c0fbbed2bf567c3ec06b2cb3ba7cb0799c6fb85fdffffff118b1cf95718d33a74ed3f3932c3f64fb2f0c6e4518b15747b733555b75991bd0000000023220020e8ced8e40c4e22e6ab74ef55a110b0e9c613b2b7a9f02acc67afabdbad7f3356fdffffffc63e39f7689496014a5857cbb78061924f0470a93b279764de92981bd36835ca00000000232200207b68a4b0f8fddf8e0361a86c69676cab16b1028153e9e39f63574276dc4b661ffdffffff39090fab3b5f16b38253595b815c5bd5bdb26566e9019477035e7c41aee372c800000000232200207b68a4b0f8fddf8e0361a86c69676cab16b1028153e9e39f63574276dc4b661ffdffffff3f10ba06de3593b235590c768cd04234cb1872798f377849caf0ab768ab79d0200000000232200207b68a4b0f8fddf8e0361a86c69676cab16b1028153e9e39f63574276dc4b661ffdffffffd96535bd40580821ee7cb764193e3b6541b7690322a70bd6a221a0af54342f5200000000232200200d04d7e00bb0142760d85390271aee054b4e433ef51ff94cc36d6e0e67b031a8fdffffffc391cd1eb472cee0e15b6b5a5041199e46f199d0e6cdc3c9e69324981ffab2de0000000023220020587f32734410b52ff4c2e8e5270ef93f549da72ccf300f28c4ad1110db07f467fdffffff451c69339b4f86b74491410c6ec0d4db380f58b06e00de3811dc6fc88729a8fe000000002322002003f278d79595e5b902b07386525a0ccaaf7d99307e299aeac1147825f20c4338fdffffff86ca04d5136844983aec64c389ed432981bd235989df872fbb006b5b9af1e9a3000000002322002003f278d79595e5b902b07386525a0ccaaf7d99307e299aeac1147825f20c4338fdffffff0d330e37c4584ab00561f748c0e4b400afa92e14f42a6b48a17c153a299ef9640100000023220020701b227dca90b841b28bf0328541f5625b6c117c58a23e77cac4ece8cb8a7778fdffffffec1bdb7c63c544dde3f579ada1226df77506978691b2579c7fbc781e34b047520000000023220020430838065d3cdda3c482cb742a96449c1d0bf4a4058bf94564daa35f01655eb3fdffffff8e03c7408f509d7b56c0ba781376071b4e32011b73d509e16dbb54dd269584c90000000023220020430838065d3cdda3c482cb742a96449c1d0bf4a4058bf94564daa35f01655eb3fdffffffb2560ad6510da1f8d496ca4c2292d7c37728ba7c3853df34438e70a779a2bd8c0000000023220020bf0d4a77e40a5889bfd84db1acef18fa6772543f55e8adec85d5ae81c08e780cfdffffff500ffe2ba7f58f55c98822e9180945d479e5718ddd6bffe01ef7a3733dd4879c0000000023220020680b4eae9cc4de5977d876acd5dcbd03fea3f7559760d5a413e9ad89ede671d7fdffffff6343917d55915286dfc87ceee1c7e4a509c56fe60f5747867b7611ca1f2dd07f0000000023220020dac2ed63bde6187bad2070e14c54d3c9901e0db7b70f091ec1d0d32091d8642efdfffffffe8d06499cdb510452e440ce099fe6374129847378e49d6df8543ee085c320ec010000002322002083e06f376b92cb8957439f0fb1b4f2d2490c878e71752d4699af784e205f5060fdffffffb829912f9bad8888fb0656c895cefee659ab48d31aac26a97700356555dc0f2b000000002322002083e06f376b92cb8957439f0fb1b4f2d2490c878e71752d4699af784e205f5060fdffffffadfe829a172268aec9a7bdeec251d0dbb160f7088e85da73cd47ffd09ffff2ef000000002322002083e06f376b92cb8957439f0fb1b4f2d2490c878e71752d4699af784e205f5060fdffffffaa9818abc51db791491c04e91e25c4e74d16db86b1020174c6ecad75605cb6950000000023220020ffc58ae0e6e93e110850b650626419883c322fe25f7c87b5c3a060eecca59a79fdffffff258b09df7edaa286383d5ba4557f5f455871ee8a50b47bb6946a9d35d424bd1a0000000023220020ffc58ae0e6e93e110850b650626419883c322fe25f7c87b5c3a060eecca59a79fdffffff632bc03f330d41e39f7d000e745cca4ab59f4af2d50cddbd64d19009bfc5ec450000000023220020bb23e5397679504762bb9fe453eb9973b10b306be086e4af25b2d11a38c5bf60fdffffff376449daff9b7e3a363a9fd866755509b098cff086af89655455eeba913789a401000000232200208694599b7ad76f6bbdaa981151745a06d951dec724893691801f3337e8af360bfdffffff5ed9088749c0f15f782ff1761e34eceed380afabc9cfa2f05cd00d3776d7ee3c00000000232200206ec0db726d1c788476244a53513ad009c263ebc5ece32dcf9979b0e703784ba6fdffffffe45fb67db4b342b030a2e5292859395cd7e07c5f5211f4f651408bd2543fa46b00000000232200207102b46de60d584f9e9acc76cb40a8dbb0192872dd02ab0c7d52953f2247355afdffffff7d57159712a19f665e41468b27a9c5006751a6f7bc2dfe43881c84b7590ea01c0000000023220020d5abe96f8429f455372bb070423d67a20ce63db37b6c00d71800d4cb1e5969cafdffffff40f725efcb2bbcc3b1b4ebc18a8b94ad157af07dace8a3b2efb9a8d411e4b240000000002322002041293326a22cffc40cd35233c573291a577bafd9a2faf5e428a87dcc7328b99efdffffffe641be0cd372c0af5e7ee6648d8a470ae7db1f1b9aa0d8267188756a8a712ab5010000002322002041293326a22cffc40cd35233c573291a577bafd9a2faf5e428a87dcc7328b99efdffffffd03ec57d1bfe41f3f953d0fd1dbe73c83bbf6bc1cee69f1d7bae80f1028c3d21010000002322002041293326a22cffc40cd35233c573291a577bafd9a2faf5e428a87dcc7328b99efdffffff7810afd7f1c13c2af25f5a1600fb8bacb2b6f577ac64bba9f8682c65ca3f3c38000000002322002051f696125fff93f88f97c2a6236abfbf0c19681cf4cb4939f6ea127f75eb7d8afdffffff2118f7b0dfc8ce89cfda2a050e4b5e01f31d9ac2c2dbef78740e6410b47d624e000000002322002051f696125fff93f88f97c2a6236abfbf0c19681cf4cb4939f6ea127f75eb7d8afdfffffff1e2244e1de0d0f0df12c43e1cfb7b160c1e2409b781f54a34898f59c5f9051e000000002322002051f696125fff93f88f97c2a6236abfbf0c19681cf4cb4939f6ea127f75eb7d8afdffffff7ec3f6fb6403c26f2daacc9697e9317cfd365b9817af0b825eba36509c94158b00000000232200207b0b63784765a9c37cfda6e7183d9b8daa8bc2836d975f9d03794834517e615ffdffffff9821f789df94e1c2ecbb2cb3b5281fdd09e9316d27383deb1d982f327fba696700000000232200207b0b63784765a9c37cfda6e7183d9b8daa8bc2836d975f9d03794834517e615ffdffffff026ca554000000000017a9146713a00ebface724d051bfc9e82871b6787be0758700ca9a3b0000000017a9144f1096a70fcf40943cc0ad98fab0819b373471268714801900").unwrap();
    //     let tx: Result<Transaction, _> = deserialize(&hex_tx);
    //     let tx = tx.unwrap();
    //     println!("{:#?}", tx);
    //
    //     let vec = block_on(RB_DETAIL.list_btc_output_tx());
    //     let mut output_map = HashMap::new();
    //     for output in vec {
    //         output_map.insert(output.btc_tx_hash, output.idx);
    //     }
    //     println!("output_map {:#?}", &output_map);
    //
    //     let inputs = tx.clone().input;
    //     for (index, txin) in inputs.iter().enumerate() {
    //         let txin = txin.to_owned();
    //         let outpoint = txin.previous_output;
    //         let tx_id = outpoint.txid.to_hex();
    //         let vout = outpoint.vout;
    //
    //         match output_map.get(&tx_id) {
    //             Some(idx) if idx.to_owned() == vout => {
    //                 let sig_script = txin.script_sig.asm();
    //                 let sequence = txin.sequence;
    //                 let btc_tx_hash = tx.bitcoin_hash().to_hex();
    //                 let btc_tx_hexbytes = btc_serialize(&tx);
    //                 let btc_tx_hexbytes = vec_to_string(btc_tx_hexbytes);
    //
    //                 println!("txid {:#?}", tx_id);
    //                 println!("vout {:#?}", vout);
    //                 println!("sig_script {:#?}", sig_script);
    //                 println!("sequence {:#?}", sequence);
    //                 println!("btc_tx_hash {:#?}", btc_tx_hash);
    //                 println!("btc_tx_hexbytes {:#?}", btc_tx_hexbytes);
    //                 println!("idx {:#?}", index);
    //             }
    //             _ => {}
    //         }
    //     }
    // }

    // #[test]
    // pub fn mnemonic_test() {
    //     generate_mnemonic();
    // }
    //
    // pub fn init_parameters() -> InitParameters {
    //     let mut p = InitParameters::default();
    //     // p.is_memory_db = CTrue;
    //     p.net_type = NetType::Test.to_string();
    //     p.db_name.0 = mav::ma::DbName::new("test_", "");
    //     p.context_note = format!("test_{}", "murmel");
    //     p
    // }
    //
    // pub fn create_wallet_parameters() -> CreateWalletParameters {
    //     let words = "lawn duty beauty guilt sample fiction name zero demise disagree cram hand";
    //     CreateWalletParameters {
    //         name: "murmel".to_string(),
    //         password: "".to_string(),
    //         mnemonic: words.to_string(),
    //         // wallet_type 依然有特定的字符串 Test 和 Normal
    //         wallet_type: WalletType::Test.to_string(),
    //     }
    // }
    //
    // #[test]
    // pub fn create_wallet_try() {
    //     let i = init_parameters();
    //     let c = create_wallet_parameters();
    //     let mut wallets = Wallets::default();
    //     block_on(async {
    //         // must init wallet before create wallet
    //         let ctx = wallets.init(&i).await;
    //         ctx.map_or_else(
    //             |e| {
    //                 println!("init failed {:?}", e);
    //             },
    //             |c| println!("init succeeded context {:?}", c),
    //         );
    //         let w = wallets.create_wallet(c).await;
    //         match w {
    //             Ok(w) => { println!("{:#?}", w); }
    //             Err(e) => { println!("{}",e); }
    //         }
    //     })
    // }
    //
    // #[test]
    // // get_mnemonic_context
    // // get_private_key_from_address
    // pub fn get_mnemonic_from_address_try() {
    //     let i = init_parameters();
    //     let c = create_wallet_parameters();
    //     let mut wallets = Wallets::default();
    //     block_on(async {
    //         // must init wallet before create wallet
    //         let ctx = wallets.init(&i).await;
    //         ctx.map_or_else(
    //             |e| {
    //                 println!("init failed {:?}", e);
    //             },
    //             |c| println!("init succeeded context {:?}", c),
    //         );
    //         let r = wallets.create_wallet(c).await;
    //         r.map_or_else(
    //             |e| println!("create failed {:?}", e),
    //             |w| {
    //                 let mnemonic = eee::Sr25519::get_mnemonic_context(&w.mnemonic, "".as_bytes());
    //                 println!(
    //                     "mnemonic {:#?}",
    //                     String::from_utf8(mnemonic.unwrap()).unwrap()
    //                 );
    //             },
    //         );
    //     })
    // }
    //
    // #[test]
    // pub fn contexts_try() {
    //     let ip = init_parameters();
    //     let cp = create_wallet_parameters();
    //     block_on(async {
    //         let lock = Contexts::collection().lock();
    //         let mut contexts = lock.borrow_mut();
    //         let new_ctx = Context::new(&ip.context_note);
    //         let wallets = contexts.new(new_ctx, NetType::Test);
    //         if let Some(wallets) = wallets {
    //             let _ = wallets.init(&ip).await.unwrap();
    //             let w = wallets.create_wallet(cp).await;
    //             w.map_or_else(
    //                 |e| println!("create failed {:?}", e),
    //                 |w| {
    //                     println!("contexts {:#?}", contexts.contexts());
    //                 },
    //             );
    //             // println!("{:#?}", w);
    //         }
    //     });
    // }
}