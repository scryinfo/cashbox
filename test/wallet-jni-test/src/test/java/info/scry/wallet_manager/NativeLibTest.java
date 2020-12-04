package info.scry.wallet_manager;

import com.googlecode.jsonrpc4j.JsonRpcHttpClient;
import org.json.JSONArray;
import org.junit.jupiter.api.Test;

import java.net.URL;
import java.util.*;

public class NativeLibTest {

    @Test
   public void updateWalletDbDataTest(){
        NativeLib.WalletState state = NativeLib.updateWalletDbData("1.1.0");
        System.out.println(state);
    }

    @Test
    public void cleanWalletsDataTest(){
        NativeLib.WalletState state = NativeLib.cleanWalletsDownloadData();
        System.out.println(state);
    }

    @Test
    public void saveWalletTest() {
        System.out.println(NativeLib.initWalletBasicData());
        NativeLib.Mnemonic mnemonic = NativeLib.mnemonicGenerate(15);
        NativeLib.Wallet wallet = NativeLib.saveWallet("wallet_hello3", "123456".getBytes(), mnemonic.mn, 0);
        System.out.println(wallet.toString());
    }

    @Test
    public void isContainWalletTest(){
        NativeLib.WalletState state = NativeLib.isContainWallet();
        System.out.println(state);
    }

    @Test
    public void loadAllWalletTest() {
        List<NativeLib.Wallet> wallets = NativeLib.loadAllWalletList();
        for (NativeLib.Wallet wallet : wallets) {
            System.out.println("***********************");
            System.out.println(wallet.toString());
        }
    }

    @Test
    public void updateDefaultDigitTest() {
       /* String json = "[\n" +
                "{\"contractAddress\":\"0x9f5f3cfd7a32700c93f971637407ff17b91c7342\",\"shortName\":\"DDD\",\"fullName\":\"DDD\",\"urlImg\":\"locale://ic_ddd.png\",\"id\":\"eth_token_pre_id_DDD\",\"decimal\":\"18\",\"chainType\":\"ETH\"},\n" +
                "{\"contractAddress\":\"0xaa638fca332190b63be1605baefde1df0b3b031e\",\"shortName\":\"DDD\",\"fullName\":\"DDD\",\"urlImg\":\"locale://ic_ddd.png\",\"id\":\"eth_test_token_pre_id_DDD\",\"decimal\":\"18\",\"chainType\":\"ETH_TEST\"}\n" +
                "]";*/
        String json = "[{\"contractAddress\":\"0x9f5f3cfd7a32700c93f971637407ff17b91c7342\",\"shortName\":\"DDD\",\"fullName\":\"DDD\",\"urlImg\":\"symbol=DDD\",\"id\":\"4ce05105-3540-4ef4-8d4b-c805e3b534f5\",\"decimal\":\"\",\"chainType\":\"ETH\"},{\"contractAddress\":\"0x00\",\"shortName\":\"TokenX\",\"fullName\":\"\",\"urlImg\":\"symbol=TokenX\",\"id\":\"f28cbc2e-f01d-4122-8e85-c0a8ef494623\",\"decimal\":\"15\",\"chainType\":\"EEE\"}]";
        System.out.println(json);
        NativeLib.WalletState state = NativeLib.updateDefaultDigitList(json);
        System.out.println(state);

    }

    @Test
    public void addNonAuthDigitTest() {
        String json = "[{\"contractAddress\":\"0xcc638fca332190b63be1605baefde1df0b3b026e\",\"shortName\":\"DDD\",\"fullName\":\"DDD\",\"urlImg\":\"locale://ic_ddd.png\",\"id\":\"eth_token_pre_id_AAA\",\"decimal\":\"\",\"chainType\":\"ETH\"}]";
        NativeLib.WalletState state = NativeLib.addNonAuthDigit(json);
        System.out.println(state);
    }

    @Test
    public void updateAuthListTest() {
        String json = "[{\"contractAddress\":\"0xaa638fca332190b63be1605baefde1df0b3b031e\",\"shortName\":\"DDD\",\"fullName\":\"DDD\",\"urlImg\":\"locale://ic_ddd.png\",\"id\":\"eth_test_token_pre_id_DDD\",\"decimal\":\"\",\"chainType\":\"ETH_TEST\"}]";
        NativeLib.WalletState state = NativeLib.updateAuthDigitList(json);
        System.out.println(state);
    }

    @Test
    public void getAuthDigitListTest() {
        NativeLib.DigitList list = NativeLib.getDigitList(3, false, 0, 50);
        System.out.println(list);
    }

    @Test
    public void queryDigitTest() {

        NativeLib.DigitList list = NativeLib.queryDigit(3, "DD", "");
        System.out.println(list);
    }

    @Test
    public void addDigitTest() {
        NativeLib.WalletState state = NativeLib.addDigit("fa85ced1-ec1b-4c2e-8e1f-e5cd4e1da4d2", 3, "eth_token_pre_id_AAA");
        System.out.println(state);
    }

    @Test
    public void updateBalance() {
        NativeLib.WalletState msg = NativeLib.updateDigitBalance("0x6be9fd93ecce9ade568b7eadf382635e109ce0d2", "3", "600");
        System.out.println(msg);
    }

    @Test
    public void delWalletTest() {
        System.out.println(NativeLib.deleteWallet("b7bcc633-8565-4611-a926-402668286c01", "123456".getBytes()));
    }

    @Test
    public void walletExportTest() {
        //wallet export
        List<NativeLib.Wallet> wallets = NativeLib.loadAllWalletList();
        for (NativeLib.Wallet wallet : wallets) {
            System.out.println("wallet detail " + wallet.toString());
            NativeLib.Mnemonic mnemonic1 = NativeLib.exportWallet(wallet.walletId, "123456".getBytes());
            System.out.println("wallet id:" + wallet.walletId + "mnemonic:" + new String(mnemonic1.mn) + ",eth address:" + wallet.ethChain.address + "");
            System.out.println("\n");
        }
    }

    NativeLib.Message saveSubChainBasicInfo(JsonRpcHttpClient client,String blackHash,boolean isDetault) throws Throwable{
        if (client ==null){
            return null;
        }
        String genesisHash = client.invoke("chain_getBlockHash", new Object[]{0}, String.class);
        System.out.println("genesis hash is:"+genesisHash);

        String queryBlackHash = null;
        if (blackHash!=null&&!blackHash.trim().isEmpty()){
            queryBlackHash = blackHash;
        }

        // get version info {"id":2,"jsonrpc":"2.0","method":"state_getRuntimeVersion","params":[]}
        Map version = client.invoke("state_getRuntimeVersion", queryBlackHash==null?new Object[]{}:new Object[]{queryBlackHash}, HashMap.class);
        System.out.println("version is:"+version);
        // get ss58Format,tokenSymbol,tokenDecimals  {"id":4,"jsonrpc":"2.0","method":"system_properties","params":[]}
        Map properties = client.invoke("system_properties",  new Object[]{}, HashMap.class);
        System.out.println("properties is:"+properties);
        // get metadata detail: {"id":7,"jsonrpc":"2.0","method":"state_getMetadata","params":[]}
        String metadata = client.invoke("state_getMetadata",  queryBlackHash==null?new Object[]{}:new Object[]{queryBlackHash}, String.class);
        //  System.out.println("metadata is:"+metadata);
        Integer runtime_version = (Integer) version.get("specVersion");
        Integer tx_version = (Integer) version.get("transactionVersion");
        NativeLib.SubChainBasicInfo info = new NativeLib.SubChainBasicInfo(genesisHash,metadata,runtime_version,tx_version);
        if (!properties.isEmpty()){
            Integer ss58Prefix = (Integer) properties.get("ss58Format");
            Integer decimals = (Integer) properties.get("tokenDecimals");
            String symbol = (String) properties.get("tokenSymbol");
            info.ss58Format = ss58Prefix;
            info.tokenSymbol =symbol;
            info.tokenDecimals = decimals;
        }

        return NativeLib.updateSubChainBasicInfo(info,isDetault);
    }

    @Test
    public void updateSubChainBasicInfoTest() throws Throwable{
        Map header = new HashMap<String, String>();
        header.put("Content-Type", "application/json");
        JsonRpcHttpClient client = new JsonRpcHttpClient(new URL("http://192.168.1.7:9937"), header);
        NativeLib.Message message = saveSubChainBasicInfo(client,null,true);
        System.out.println(message);
    }

    @Test
    public void getSubChainBasicInfoTest(){
        //0x7fa792d0aff5e5529e0125faf969f7adfd65894b962e24681f18eab116975a20
        NativeLib.Message msg= NativeLib.getSubChainBasicInfo("",null,null);
        System.out.println(msg);
    }

    @Test
    public void eeeTxsign() {
        String rawtx = "0x6501040902a39a014e7bceb3c2ff84bb6aba8d9e46c635257a2b9aa41969e70b0a8dd07b6c00070088526a74b8cc91625b766093d22a1f2be22b983cfcc89eb28cf89c8c849dc9a4688905d9ae300b465d146265616368e8030000080000002fc77f8d90e56afbc241f36efa4f9db28ae410c71b20fd960194ea9d1dabb9730200000001000000";
        NativeLib.Message msg = NativeLib.eeeTxSign(rawtx, "5a2571e5-90ff-4954-a6aa-c97c6a7aacdc", "123456".getBytes());
        System.out.println(msg.toString());
    }

    @Test
    public void eeeAccountInfoKeyTest() {
        // NativeLib.Message msg = NativeLib.eeeAccountInfoKey("5HNJXkYm2GBaVuBkHSwptdCgvaTFiP8zxEoEYjFCgugfEXjV");
        NativeLib.Message msg = NativeLib.eeeStorageKey("System","Account","5DxskoXeEEyTg3pqQVfkku43VcumqL3rfkQKAgvHmEh4c6tX");
        System.out.println(msg);
        String account_1 = "5DxskoXeEEyTg3pqQVfkku43VcumqL3rfkQKAgvHmEh4c6tX";
        NativeLib.Message key2 = NativeLib.eeeStorageKey("TokenX","Balances",account_1);
        System.out.println(key2);
    }

    @Test
    public void decodeAccountInfoTest() {
        NativeLib.Message msg = NativeLib.decodeAccountInfo("0x0400000000000000c3898cd73c8ac6020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");
        System.out.println(msg);
    }

    @Test
    public void eeeTransferTest() {
        String from = "5DPYtLY4vrCfxvYHFbMUtdXBCtwWPAjftJJPx61LFmiySkc7";// 5GubjQedXVKqZ3TGigy4y3Ez1HPYnajJVxNhF9gjzuQ6onzd
        String to = "5EjvCP7DL9mS8wNyqVgef3oygW8KtbzsRFoRguixFQkSuFNC";
        String value = "10";
        int index = 0;
        NativeLib.Message msg = NativeLib.eeeTransfer(from, to, value,index, "123456".getBytes());
        System.out.println(msg);
    }

    @Test
    public void tokenXTransferTest(){
        String from = "5CRq2XF4BVaAWT72q7NaQdVZTajD12yDTu6YegyWAAxpDHah";
        String to = "5DxskoXeEEyTg3pqQVfkku43VcumqL3rfkQKAgvHmEh4c6tX";
        String value = "10000000";
        int index = 3;
        NativeLib.Message msg = NativeLib.tokenXTransfer(from, to, value,"0x00",index, "123456".getBytes());
        System.out.println(msg);
    }

    @Test
    public void decodeTest() {
        NativeLib.Message msg = NativeLib.decodeAdditionData("0xa9059cbb000000000000000000000000c0c4824527ffb27a51034cea1e37840ed69a5f1e00000000000000000000000000000000000000000000000000000000000a2d77646464");
        System.out.println(msg.toString());
    }

    @Test
    public void getHeaderTest() throws Throwable {
        Map header = new HashMap<String, String>();
        String eventKeyPrefix = "0x26aa394eea5630e07c48ae0c9558cef780d41e5e16056765bc8461851072c9d7";
        header.put("Content-Type", "application/json");
        JsonRpcHttpClient client = new JsonRpcHttpClient(new URL("http://47.108.146.67:9933"), header);
        //Get the current latest block hash
        Header new_header = client.invoke("chain_getHeader", new Object[]{}, Header.class);
        Integer number = Integer.parseInt(new_header.number.substring(2), 16);
        System.out.println(number);
    }

    @Test
    public void getEeeSyncRecordTest() {
        System.out.println("java library path:"+System.getProperty("java.library.path"));
        System.out.println(NativeLib.getEeeSyncRecord());
    }

    @Test
    public void storageQueryTest() throws Throwable {
        Map header = new HashMap<String, String>();
        //Notification Event Coding Constant
        String eventKeyPrefix = "0x26aa394eea5630e07c48ae0c9558cef780d41e5e16056765bc8461851072c9d7";
        //Need to query the target account of the transaction
        //  String account_1 = "5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY";
        String account_1 = "5DxskoXeEEyTg3pqQVfkku43VcumqL3rfkQKAgvHmEh4c6tX";
        String account_2 = "5HNJXkYm2GBaVuBkHSwptdCgvaTFiP8zxEoEYjFCgugfEXjV";

        header.put("Content-Type", "application/json");
        JsonRpcHttpClient client = new JsonRpcHttpClient(new URL("http://192.168.1.7:9937"), header);

        Header current_header = client.invoke("chain_getHeader", new Object[]{}, Header.class);
        //Get the current block number
        Integer number = Integer.parseInt(current_header.number.substring(2), 16);
        System.out.println("latest block number is:" + number);
        NativeLib.SyncStatus status = NativeLib.getEeeSyncRecord();

        NativeLib.AccountRecord accountRecord = status.records.get(account_1);

        int startBlockNumber = accountRecord == null ? 0 : accountRecord.blockNum;

        NativeLib.Message key1 = NativeLib.eeeStorageKey("System","Account",account_1);
        NativeLib.Message key2 = NativeLib.eeeStorageKey("TokenX","Balances",account_1);
        ////NativeLib.Message key2 = NativeLib.eeeStorageKey("System","Account","0xd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d");
         System.out.println("key1:"+key1.storageKeyInfo+",key2:"+key2.storageKeyInfo);
        //Query block interval
        int queryNumberInterval = 3000;
        //The number of queries currently required, rounded up
        int query_times = (number - startBlockNumber) / queryNumberInterval + 1;


        String endBlockHash = "";//Get the last blockhash
        int endBlockNumber = 0;
        String genesisHash = client.invoke("chain_getBlockHash", new Object[]{0}, String.class);
        for (int i = 0; i < query_times; i++) {
            //1-3000 3001-6000

            //The starting block number of the current query
            int currentStartBlockNum = startBlockNumber + i * queryNumberInterval + 1;

            String startBlockHash = client.invoke("chain_getBlockHash", new Object[]{currentStartBlockNum}, String.class);
            System.out.println("currentStartBlockNum:" + currentStartBlockNum + ",startBlockHash:" + startBlockHash);
            endBlockNumber = i == (query_times - 1) ? number : (i + 1) * queryNumberInterval + startBlockNumber;
            //Get the block hash of the current query storage status
            endBlockHash = client.invoke("chain_getBlockHash", new Object[]{endBlockNumber}, String.class);
            //Query the history of account status changes within the changed block ,key2.storageKeyInfo
            StorageChange[] storage = client.invoke("state_queryStorage", new Object[]{new String[]{key1.storageKeyInfo,key2.storageKeyInfo}, startBlockHash, endBlockHash}, StorageChange[].class);
            System.out.println("*********************StorageChange start**************");
            // System.out.println(storage.toString());
            System.out.println("*********************StorageChange end**************");
            for (StorageChange item : storage) {
                //check chain basic info exist
                Map version = client.invoke("state_getRuntimeVersion", new Object[]{item.block}, HashMap.class);

                NativeLib.Message targetBasicInfo= NativeLib.getSubChainBasicInfo(genesisHash,(Integer)version.get("specVersion"),(Integer)version.get("transactionVersion"));
                if (targetBasicInfo.status!=200){
                    //this version chain basic info not exist,should save into database!
                    NativeLib.Message save_ret = saveSubChainBasicInfo(client,item.block,false);
                    if (save_ret.status!=200){
                        return;
                    }
                    //
                    targetBasicInfo = save_ret;
                }
                //Read details of status changes
                System.out.println("block hash:" + item.block + ",changes:" + item.changes.toString());
                Block block_detail = client.invoke("chain_getBlock", new Object[]{item.block}, Block.class);
                List tx_list = Arrays.asList(block_detail.block.extrinsics);
                //todo Why are there blocks with only timestamps retrieved?
                if (tx_list.size() == 1) {
                    System.out.println("ignore this block:" + block_detail.toString());
                    continue;
                }
                String extrinsicsDetail = new JSONArray(tx_list).toString();
                System.out.println("block_detail:" + extrinsicsDetail);
                //JSONArray
                String event_detail = client.invoke("state_getStorage", new Object[]{eventKeyPrefix, item.block}, String.class);
                //Decode the obtained notification details and decode them. If there is a transfer transaction, store the transaction details in the database
                NativeLib.Message msg = NativeLib.saveExtrinsicDetail(targetBasicInfo.chainInfo.infoId,account_1, event_detail, item.block, extrinsicsDetail);
                if (msg.status != 200) {
                    System.out.println(msg.message);
                    return;
                }
            }
            System.out.println("start update sync record,endBlockNumber is:" + endBlockNumber + ",endBlockHash is:" + endBlockHash);
            //Update the number of currently queried blocks
            NativeLib.Message update_result = NativeLib.updateEeeSyncRecord(account_1, 5, endBlockNumber, endBlockHash);
            if (update_result.status != 200) {
                System.out.println("update message is:" + update_result.message);
            }
        }

    }

    @Test
    public void updateEeeSyncRecordTest() {
        String account_1 = "5FfBQ3kwXrbdyoqLPvcXRp7ikWydXawpNs2Ceu3WwFdhZ8W4";
        int number = 6000;
        String endBlockHash = "0x738c2f78b2ee8cde07a7591ec6bd25c56d13bd0f0b262a767888a70fc0933839";
        NativeLib.Message update_result = NativeLib.updateEeeSyncRecord(account_1, 5, number, endBlockHash);
        System.out.println(update_result);
    }

    @Test
    public void contract_test() throws Throwable {
        List<NativeLib.Wallet> wallets = NativeLib.loadAllWalletList();
        try {
            List wallet_test = new ArrayList<NativeLib.Wallet>();
            for (NativeLib.Wallet wallet:wallets){
                if (wallet.walletType== NativeLib.WalletType.TEST_WALLET){
                    System.out.println("wallet address:"+wallet.ethChain.address);
                    wallet_test.add(wallet);
                }
            }
            contract_exec(wallet_test);
        }catch (Exception e) {
            e.printStackTrace();
        }
    }

    void contract_exec(List<NativeLib.Wallet> wallets) throws Throwable {
        //Initializejsonrpc
        Map header = new HashMap<String, String>();
        header.put("Content-Type", "application/json");
        JsonRpcHttpClient client = new JsonRpcHttpClient(new URL("http://192.168.2.7:8545"), header);
        //Initialize wallet

        //Get the balance of eth in the first wallet
        String default_address = wallets.get(0).ethChain.address;
        //The second address in the wallet for receiving balance
        String target_address = wallets.get(1).ethChain.address;
        //Query the balance of the first address
        String balance = client.invoke("eth_getBalance", new Object[]{default_address}, String.class);
        System.out.println("balance:" + balance);
        //Query the balance of the second address
        String target_balance = client.invoke("eth_getBalance", new Object[]{target_address}, String.class);
        System.out.println("target_balance:" + target_balance);
        //Get the nonce of eth in the first wallet
        String nonce = client.invoke("eth_getTransactionCount", new Object[]{default_address}, String.class);
        System.out.println("nonce is:" + nonce);
        // erc20 contract for contract call testing
        String contract_str = "0x6080604052600436106101c15763ffffffff7c010000000000000000000000000000000000000000000000000000000060003504166302f652a381146101c657806305d2035b146101ee57806306fdde0314610217578063095ea7b3146102a157806318160ddd146102c55780631f3bec3b146102ec57806323b872dd1461031d57806329ff4f5314610347578063313ce5671461036857806340c10f191461039357806345977d03146103b75780635de4ccb0146103cf5780635f412d4f146103e4578063600440cb146103f9578063642b4a4d1461040e578063661884631461042357806370a0823114610447578063715018a6146104685780637d64bcb41461047d5780638444b39114610492578063867c2857146104cb5780638da5cb5b146104ec57806395d89b411461050157806396132521146105165780639738968c1461052b578063a9059cbb14610540578063adf403ad14610564578063ae1616b014610579578063c752ff621461058e578063d1f276d3146105a3578063d73dd623146105b8578063d7e7088a146105dc578063dd62ed3e146105fd578063dd681e5114610624578063f2fde38b14610639578063ffeb7d751461065a575b600080fd5b3480156101d257600080fd5b506101ec600160a060020a0360043516602435151561067b565b005b3480156101fa57600080fd5b50610203610770565b604080519115158252519081900360200190f35b34801561022357600080fd5b5061022c610779565b6040805160208082528351818301528351919283929083019185019080838360005b8381101561026657818101518382015260200161024e565b50505050905090810190601f1680156102935780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b3480156102ad57600080fd5b50610203600160a060020a0360043516602435610807565b3480156102d157600080fd5b506102da61086e565b60408051918252519081900360200190f35b3480156102f857600080fd5b506103016108b2565b60408051600160a060020a039092168252519081900360200190f35b34801561032957600080fd5b50610203600160a060020a03600435811690602435166044356108c6565b34801561035357600080fd5b506101ec600160a060020a03600435166109d7565b34801561037457600080fd5b5061037d610ad0565b6040805160ff9092168252519081900360200190f35b34801561039f57600080fd5b50610203600160a060020a0360043516602435610ad9565b3480156103c357600080fd5b506101ec600435610bdc565b3480156103db57600080fd5b50610301610e18565b3480156103f057600080fd5b506101ec610e27565b34801561040557600080fd5b50610301610eb4565b34801561041a57600080fd5b50610301610ec8565b34801561042f57600080fd5b50610203600160a060020a0360043516602435610ed7565b34801561045357600080fd5b506102da600160a060020a0360043516610fc6565b34801561047457600080fd5b506101ec610fe1565b34801561048957600080fd5b5061020361104f565b34801561049e57600080fd5b506104a76110b5565b604051808260038111156104b757fe5b60ff16815260200191505060405180910390f35b3480156104d757600080fd5b50610203600160a060020a03600435166110ef565b3480156104f857600080fd5b50610301611104565b34801561050d57600080fd5b5061022c611113565b34801561052257600080fd5b5061020361116e565b34801561053757600080fd5b5061020361117e565b34801561054c57600080fd5b50610203600160a060020a036004351660243561119d565b34801561057057600080fd5b506103016112ac565b34801561058557600080fd5b506103016112bb565b34801561059a57600080fd5b506102da6112ca565b3480156105af57600080fd5b506103016112d0565b3480156105c457600080fd5b50610203600160a060020a03600435166024356112df565b3480156105e857600080fd5b506101ec600160a060020a0360043516611378565b34801561060957600080fd5b506102da600160a060020a0360043581169060243516611941565b34801561063057600080fd5b5061030161196c565b34801561064557600080fd5b506101ec600160a060020a036004351661197b565b34801561066657600080fd5b506101ec600160a060020a036004351661199e565b600354600160a060020a0316331461069257600080fd5b60045460009060a060020a900460ff1615610744576040805160e560020a62461bcd028152602060048201526044602482018190527f4974277320726571756972656420746861742074686520737461746520746f20908201527f636865636b20616c69676e732077697468207468652072656c6561736564206660648201527f6c61672e00000000000000000000000000000000000000000000000000000000608482015290519081900360a40190fd5b50600160a060020a03919091166000908152600560205260409020805460ff1916911515919091179055565b60065460ff1681565b600a805460408051602060026001851615610100026000190190941693909304601f810184900484028201840190925281815292918301828280156107ff5780601f106107d4576101008083540402835291602001916107ff565b820191906000526020600020905b8154815290600101906020018083116107e257829003601f168201915b505050505081565b336000818152600260209081526040808320600160a060020a038716808552908352818420869055815186815291519394909390927f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925928290030190a35060015b92915050565b600080805260208190527fad3228b676f7d3cd4284a5443f17f1962b36e491b30a40b2405849e597ba5fb5546001546108ac9163ffffffff611b2016565b90505b90565b600c546101009004600160a060020a031681565b600454600090849060a060020a900460ff16806108fb5750600160a060020a03811660009081526005602052604090205460ff165b15156109c3576040805160e560020a62461bcd02815260206004820152607f60248201527f466f722074686520746f6b656e20746f2062652061626c6520746f207472616e60448201527f736665723a20697427732072657175697265642074686174207468652063726f60648201527f776473616c6520697320696e2072656c65617365642073746174653b206f722060848201527f7468652073656e6465722069732061207472616e73666572206167656e742e0060a482015290519081900360c40190fd5b6109ce858585611b32565b95945050505050565b600354600160a060020a031633146109ee57600080fd5b60045460009060a060020a900460ff1615610aa0576040805160e560020a62461bcd028152602060048201526044602482018190527f4974277320726571756972656420746861742074686520737461746520746f20908201527f636865636b20616c69676e732077697468207468652072656c6561736564206660648201527f6c61672e00000000000000000000000000000000000000000000000000000000608482015290519081900360a40190fd5b506004805473ffffffffffffffffffffffffffffffffffffffff1916600160a060020a0392909216919091179055565b600c5460ff1681565b600354600090600160a060020a03163314610af357600080fd5b60065460ff1615610b0357600080fd5b600154610b16908363ffffffff611ca716565b600155600160a060020a038316600090815260208190526040902054610b42908363ffffffff611ca716565b600160a060020a03841660008181526020818152604091829020939093558051858152905191927f0f6798a560793a54c3bcfe86a93cde1e73087d944c0ea20544137d412139688592918290030190a2604080518381529051600160a060020a038516916000917fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef9181900360200190a350600192915050565b6000610be66110b5565b90506003816003811115610bf657fe5b14610c71576040805160e560020a62461bcd02815260206004820152602e60248201527f497427732072657175697265642074686174207468652075706772616465207360448201527f746174652069732072656164792e000000000000000000000000000000000000606482015290519081900360840190fd5b60008211610cef576040805160e560020a62461bcd02815260206004820152602c60248201527f54686520757067726164652076616c756520697320726571756972656420746f60448201527f2062652061626f766520302e0000000000000000000000000000000000000000606482015290519081900360840190fd5b33600090815260208190526040902054610d0f908363ffffffff611b2016565b33600090815260208190526040902055600154610d32908363ffffffff611b2016565b600155600854610d48908363ffffffff611ca716565b600855600754604080517f753e88e5000000000000000000000000000000000000000000000000000000008152336004820152602481018590529051600160a060020a039092169163753e88e59160448082019260009290919082900301818387803b158015610db757600080fd5b505af1158015610dcb573d6000803e3d6000fd5b5050600754604080518681529051600160a060020a0390921693503392507f7e5c344a8141a805725cb476f76c6953b842222b967edd1f78ddb6e8b3f397ac919081900360200190a35050565b600754600160a060020a031681565b600454600160a060020a03163314610e9d576040805160e560020a62461bcd0281526020600482015260316024820152600080516020611f8583398151915260448201527f20612072656c65617365206167656e742e000000000000000000000000000000606482015290519081900360840190fd5b6006805460ff19166001179055610eb2611cb4565b565b6006546101009004600160a060020a031681565b600d54600160a060020a031681565b336000908152600260209081526040808320600160a060020a0386168452909152812054808310610f2b57336000908152600260209081526040808320600160a060020a0388168452909152812055610f60565b610f3b818463ffffffff611b2016565b336000908152600260209081526040808320600160a060020a03891684529091529020555b336000818152600260209081526040808320600160a060020a0389168085529083529281902054815190815290519293927f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925929181900390910190a35060019392505050565b600160a060020a031660009081526020819052604090205490565b600354600160a060020a03163314610ff857600080fd5b600354604051600160a060020a03909116907ff8df31144d9c2f0f6b59d69b8b98abd5459d07f2742c4df920b25aae33c6482090600090a26003805473ffffffffffffffffffffffffffffffffffffffff19169055565b600354600090600160a060020a0316331461106957600080fd5b60065460ff161561107957600080fd5b6006805460ff191660011790556040517fae5184fba832cb2b1f702aca6117b8d265eaf03ad33eb133f19dde0f5920fa0890600090a150600190565b60006110bf61117e565b15156110cd575060016108af565b600754600160a060020a031615156110e7575060026108af565b5060036108af565b60056020526000908152604090205460ff1681565b600354600160a060020a031681565b600b805460408051602060026001851615610100026000190190941693909304601f810184900484028201840190925281815292918301828280156107ff5780601f106107d4576101008083540402835291602001916107ff565b60045460a060020a900460ff1681565b60045460009060a060020a900460ff1680156108ac57506108ac611d50565b600454600090339060a060020a900460ff16806111d25750600160a060020a03811660009081526005602052604090205460ff165b151561129a576040805160e560020a62461bcd02815260206004820152607f60248201527f466f722074686520746f6b656e20746f2062652061626c6520746f207472616e60448201527f736665723a20697427732072657175697265642074686174207468652063726f60648201527f776473616c6520697320696e2072656c65617365642073746174653b206f722060848201527f7468652073656e6465722069732061207472616e73666572206167656e742e0060a482015290519081900360c40190fd5b6112a48484611d59565b949350505050565b600e54600160a060020a031681565b601054600160a060020a031681565b60085481565b600454600160a060020a031681565b336000908152600260209081526040808320600160a060020a0386168452909152812054611313908363ffffffff611ca716565b336000818152600260209081526040808320600160a060020a0389168085529083529281902085905580519485525191937f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b925929081900390910190a350600192915050565b61138061117e565b1515611422576040805160e560020a62461bcd02815260206004820152604960248201527f4974277320726571756972656420746f20626520696e2063616e55706772616460448201527f65282920636f6e646974696f6e207768656e2073657474696e6720757067726160648201527f6465206167656e742e0000000000000000000000000000000000000000000000608482015290519081900360a40190fd5b600160a060020a03811615156114ce576040805160e560020a62461bcd02815260206004820152604860248201527f4167656e7420697320726571756972656420746f20626520616e206e6f6e2d6560448201527f6d7074792061646472657373207768656e2073657474696e672075706772616460648201527f65206167656e742e000000000000000000000000000000000000000000000000608482015290519081900360a40190fd5b6006546101009004600160a060020a0316331461156f576040805160e560020a62461bcd02815260206004820152604e6024820152600080516020611f8583398151915260448201527f2074686520757067726164654d6173746572207768656e2073657474696e672060648201527f75706772616465206167656e742e000000000000000000000000000000000000608482015290519081900360a40190fd5b60036115796110b5565b600381111561158457fe5b1415611626576040805160e560020a62461bcd02815260206004820152604960248201527f5570677261646520737461746520697320726571756972656420746f206e6f7460448201527f20626520757067726164696e67207768656e2073657474696e6720757067726160648201527f6465206167656e742e0000000000000000000000000000000000000000000000608482015290519081900360a40190fd5b600754600160a060020a0316156116ad576040805160e560020a62461bcd02815260206004820152602660248201527f757067726164654167656e74206f6e6365207365742c2063616e6e6f7420626560448201527f2072657365740000000000000000000000000000000000000000000000000000606482015290519081900360840190fd5b6007805473ffffffffffffffffffffffffffffffffffffffff1916600160a060020a038381169190911791829055604080517f61d3d7a6000000000000000000000000000000000000000000000000000000008152905192909116916361d3d7a6916004808201926020929091908290030181600087803b15801561173157600080fd5b505af1158015611745573d6000803e3d6000fd5b505050506040513d602081101561175b57600080fd5b50511515611825576040805160e560020a62461bcd02815260206004820152607e60248201527f5468652070726f7669646564207570646174654167656e7420636f6e7472616360448201527f7420697320726571756972656420746f20626520636f6d706c69616e7420746f60648201527f2074686520557067726164654167656e7420696e74657266616365206d65746860848201527f6f64207768656e2073657474696e672075706772616465206167656e742e000060a482015290519081900360c40190fd5b600154600760009054906101000a9004600160a060020a0316600160a060020a0316634b2ba0dd6040518163ffffffff167c0100000000000000000000000000000000000000000000000000000000028152600401602060405180830381600087803b15801561189457600080fd5b505af11580156118a8573d6000803e3d6000fd5b505050506040513d60208110156118be57600080fd5b5051146118ff5760405160e560020a62461bcd028152600401808060200182810382526090815260200180611ef56090913960a00191505060405180910390fd5b60075460408051600160a060020a039092168252517f7845d5aa74cc410e35571258d954f23b82276e160fe8c188fa80566580f279cc9181900360200190a150565b600160a060020a03918216600090815260026020908152604080832093909416825291909152205490565b600f54600160a060020a031681565b600354600160a060020a0316331461199257600080fd5b61199b81611e38565b50565b600160a060020a0381161515611a4a576040805160e560020a62461bcd02815260206004820152605d60248201527f5468652070726f766964656420757067726164654d617374657220697320726560448201527f71756972656420746f2062652061206e6f6e2d656d707479206164647265737360648201527f207768656e2073657474696e672075706772616465206d61737465722e000000608482015290519081900360a40190fd5b6006546101009004600160a060020a03163314611aeb576040805160e560020a62461bcd02815260206004820152605e6024820152600080516020611f8583398151915260448201527f20746865206f726967696e616c20757067726164654d6173746572207768656e60648201527f2073657474696e6720286e6577292075706772616465206d61737465722e0000608482015290519081900360a40190fd5b60068054600160a060020a039092166101000274ffffffffffffffffffffffffffffffffffffffff0019909216919091179055565b600082821115611b2c57fe5b50900390565b600160a060020a038316600090815260208190526040812054821115611b5757600080fd5b600160a060020a0384166000908152600260209081526040808320338452909152902054821115611b8757600080fd5b600160a060020a0383161515611b9c57600080fd5b600160a060020a038416600090815260208190526040902054611bc5908363ffffffff611b2016565b600160a060020a038086166000908152602081905260408082209390935590851681522054611bfa908363ffffffff611ca716565b600160a060020a03808516600090815260208181526040808320949094559187168152600282528281203382529091522054611c3c908363ffffffff611b2016565b600160a060020a03808616600081815260026020908152604080832033845282529182902094909455805186815290519287169391927fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef929181900390910190a35060019392505050565b8181018281101561086857fe5b600454600160a060020a03163314611d2a576040805160e560020a62461bcd0281526020600482015260316024820152600080516020611f8583398151915260448201527f20612072656c65617365206167656e742e000000000000000000000000000000606482015290519081900360840190fd5b6004805474ff0000000000000000000000000000000000000000191660a060020a179055565b60095460ff1690565b33600090815260208190526040812054821115611d7557600080fd5b600160a060020a0383161515611d8a57600080fd5b33600090815260208190526040902054611daa908363ffffffff611b2016565b3360009081526020819052604080822092909255600160a060020a03851681522054611ddc908363ffffffff611ca716565b600160a060020a038416600081815260208181526040918290209390935580518581529051919233927fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef9281900390910190a350600192915050565b600160a060020a0381161515611e4d57600080fd5b600354604051600160a060020a038084169216907f8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e090600090a36003805473ffffffffffffffffffffffffffffffffffffffff1916600160a060020a0392909216919091179055565b6000821515611ec757506000610868565b50818102818382811515611ed757fe5b041461086857fe5b60008183811515611eec57fe5b04939250505056005468652070726f766964656420757067726164654167656e7420636f6e74726163742773206f726967696e616c537570706c7920697320726571756972656420746f206265206571756976616c656e7420746f206578697374696e6720636f6e7472616374277320746f74616c537570706c795f207768656e2073657474696e672075706772616465206167656e742e4d6573736167652073656e64657220697320726571756972656420746f206265a165627a7a72305820b1e04321bb9e830b1d8318c500afb2b83bdfb0cdeed898227da51bf1bbc414670029";
        //Get current chain_id
        String chainId = client.invoke("eth_chainId", new Object[]{}, String.class);
        int chain_id_dec = Integer.parseInt(chainId.substring(2), 16);
        System.out.println("chain id is:" + chain_id_dec);
        //Construct interface test parameters
        TxObj tx = new TxObj();
        int decimal = 18;
        tx.setMmId(wallets.get(0).walletId);
        tx.setChainType(chain_id_dec);
        tx.setFromAddress(default_address);
        tx.setToAddress(target_address);
        tx.setValue("1.6543");
        tx.setContractAddress("");//0xee35211c4d9126d520bbfeaf3cfee5fe7b86f221
        tx.setGasPrice("6");
        tx.setGasLimit("1560720");
        tx.setNonce(nonce);
        tx.setAdditional("hello");
        tx.setPsw("123456".getBytes());
        System.out.println("**************普通ETH交易测试******************");
        //Transaction signature
        NativeLib.Message msg = NativeLib.ethTxSign(tx.getMmId(), tx.getChainType(), tx.getFromAddress(), tx.getToAddress(), tx.getContractAddress(),
                tx.getValue(), tx.getAdditional(), tx.getPsw(), tx.getGasPrice(), tx.getGasLimit(), tx.getNonce(), 18);
        if (msg.status != 200) {
            System.out.println(msg.message);
            return;
        }
        System.out.println("eth raw signed data is:" + msg.ethSignedInfo);
        //The transaction is sent to the chain
        String hash = client.invoke("eth_sendRawTransaction", new Object[]{msg.ethSignedInfo}, String.class);
        System.out.println("tx result :" + hash);
        //Transaction details view
        TxDetail tx_detail = client.invoke("eth_getTransactionByHash", new Object[]{hash}, TxDetail.class);
        System.out.println("tx_detail:" + tx_detail.toString());

        //Query the balance of the second address
        String after_target_balance = client.invoke("eth_getBalance", new Object[]{target_address}, String.class);
        System.out.println("after_target_balance:" + after_target_balance);
        System.out.println("**************ETH ERC20合约发布测试******************");
        String updated_nonce = client.invoke("eth_getTransactionCount", new Object[]{default_address}, String.class);
        System.out.println("nonce is:" + updated_nonce);
        //Update tx parameters
        tx.setNonce(updated_nonce);
        //tx.setContractAddress();Contract address is empty
        tx.setToAddress("");//The destination address is empty for contract release
        tx.setAdditional(contract_str);//Additional data is contract bytes

        NativeLib.Message deploy_contract = NativeLib.ethTxSign(tx.getMmId(), tx.getChainType(), tx.getFromAddress(), tx.getToAddress(), tx.getContractAddress(),
                tx.getValue(), tx.getAdditional(), tx.getPsw(), tx.getGasPrice(), tx.getGasLimit(), tx.getNonce(), decimal);
        String deploy_contract_hash = client.invoke("eth_sendRawTransaction", new Object[]{deploy_contract.ethSignedInfo}, String.class);
        System.out.println("tx result :" + deploy_contract_hash);
        //Transaction details view
        TxDetail deploy_detail = client.invoke("eth_getTransactionByHash", new Object[]{deploy_contract_hash}, TxDetail.class);
        System.out.println("deploy_contract_address:" + deploy_detail.getCreates());

        //Contract call test
        System.out.println("**************ETH合约调用测试******************");
        String contract_invoke_nonce = client.invoke("eth_getTransactionCount", new Object[]{default_address}, String.class);
        System.out.println("contract_invoke_nonce is:" + contract_invoke_nonce);
        tx.setNonce(contract_invoke_nonce);
        tx.setContractAddress(deploy_detail.getCreates());
        tx.setToAddress(target_address);
        //Contract call signature
        NativeLib.Message contract_invoke_msg = NativeLib.ethTxSign(tx.getMmId(), tx.getChainType(), tx.getFromAddress(), tx.getToAddress(), tx.getContractAddress(),
                tx.getValue(), tx.getAdditional(), tx.getPsw(), tx.getGasPrice(), tx.getGasLimit(), tx.getNonce(), decimal);
        String contract_invoke_result_hash = client.invoke("eth_sendRawTransaction", new Object[]{contract_invoke_msg.ethSignedInfo}, String.class);
        System.out.println("contract_invoke_result_hash :" + contract_invoke_result_hash);

        TxDetail contract_invoke_result_detail = client.invoke("eth_getTransactionByHash", new Object[]{contract_invoke_result_hash}, TxDetail.class);
        System.out.println("tx_detail:" + contract_invoke_result_detail.toString());
    }

    //The following types are used for testing, to facilitate data analysis
    public static class TxObj {
        private String mmId;
        private Integer chainType;
        private String fromAddress;
        private String toAddress;
        private String contractAddress;
        private String value;
        private String additional;
        private byte[] psw;
        private String gasPrice;
        private String gasLimit;
        private String nonce;

        public TxObj() {
            super();
        }

        public TxObj(String mmId, Integer chainType, String fromAddress, String toAddress, String contractAddress, String value, String additional, byte[] psq, String gasPrice, String gasLimit, String nonce) {
            this.mmId = mmId;
            this.chainType = chainType;
            this.fromAddress = fromAddress;
            this.toAddress = toAddress;
            this.contractAddress = contractAddress;
            this.value = value;
            this.additional = additional;
            this.psw = psq;
            this.gasPrice = gasPrice;
            this.gasLimit = gasLimit;
            this.nonce = nonce;
        }

        public String getMmId() {
            return mmId;
        }

        public void setMmId(String mmId) {
            this.mmId = mmId;
        }

        public Integer getChainType() {
            return chainType;
        }

        public void setChainType(Integer chainType) {
            this.chainType = chainType;
        }

        public String getFromAddress() {
            return fromAddress;
        }

        public void setFromAddress(String fromAddress) {
            this.fromAddress = fromAddress;
        }

        public String getToAddress() {
            return toAddress;
        }

        public void setToAddress(String toAddress) {
            this.toAddress = toAddress;
        }

        public String getContractAddress() {
            return contractAddress;
        }

        public void setContractAddress(String contractAddress) {
            this.contractAddress = contractAddress;
        }

        public String getValue() {
            return value;
        }

        public void setValue(String value) {
            this.value = value;
        }

        public String getAdditional() {
            return additional;
        }

        public void setAdditional(String additional) {
            this.additional = additional;
        }

        public byte[] getPsw() {
            return psw;
        }

        public void setPsw(byte[] psw) {
            this.psw = psw;
        }

        public String getGasPrice() {
            return gasPrice;
        }

        public void setGasPrice(String gasPrice) {
            this.gasPrice = gasPrice;
        }

        public String getGasLimit() {
            return gasLimit;
        }

        public void setGasLimit(String gasLimit) {
            this.gasLimit = gasLimit;
        }

        public String getNonce() {
            return nonce;
        }

        public void setNonce(String nonce) {
            this.nonce = nonce;
        }
    }

    public static class TxDetail {
        private String blockHash;
        private String blockNumber;
        private String chainId;
        private String condition;
        private String creates;
        private String from;
        private String gas;
        private String gasPrice;
        private String hash;
        private String input;
        private String nonce;
        private String publicKey;
        private String r;
        private String raw;
        private String s;
        private String standardV;
        private String to;
        private String transactionIndex;
        private String v;
        private String value;

        public String getGasPrice() {
            return gasPrice;
        }

        public void setGasPrice(String gasPrice) {
            this.gasPrice = gasPrice;
        }

        public String getBlockHash() {
            return blockHash;
        }

        public void setBlockHash(String blockHash) {
            this.blockHash = blockHash;
        }

        public String getBlockNumber() {
            return blockNumber;
        }

        public void setBlockNumber(String blockNumber) {
            this.blockNumber = blockNumber;
        }

        public String getChainId() {
            return chainId;
        }

        public void setChainId(String chainId) {
            this.chainId = chainId;
        }

        public String getCondition() {
            return condition;
        }

        public void setCondition(String condition) {
            this.condition = condition;
        }

        public String getCreates() {
            return creates;
        }

        public void setCreates(String creates) {
            this.creates = creates;
        }

        public String getFrom() {
            return from;
        }

        public void setFrom(String from) {
            this.from = from;
        }

        public String getGas() {
            return gas;
        }

        public void setGas(String gas) {
            this.gas = gas;
        }

        public String getHash() {
            return hash;
        }

        public void setHash(String hash) {
            this.hash = hash;
        }

        public String getInput() {
            return input;
        }

        public void setInput(String input) {
            this.input = input;
        }

        public String getNonce() {
            return nonce;
        }

        public void setNonce(String nonce) {
            this.nonce = nonce;
        }

        public String getPublicKey() {
            return publicKey;
        }

        public void setPublicKey(String publicKey) {
            this.publicKey = publicKey;
        }

        public String getR() {
            return r;
        }

        public void setR(String r) {
            this.r = r;
        }

        public String getRaw() {
            return raw;
        }

        public void setRaw(String raw) {
            this.raw = raw;
        }

        public String getS() {
            return s;
        }

        public void setS(String s) {
            this.s = s;
        }

        public String getStandardV() {
            return standardV;
        }

        public void setStandardV(String standardV) {
            this.standardV = standardV;
        }

        public String getTo() {
            return to;
        }

        public void setTo(String to) {
            this.to = to;
        }

        public String getTransactionIndex() {
            return transactionIndex;
        }

        public void setTransactionIndex(String transactionIndex) {
            this.transactionIndex = transactionIndex;
        }

        public String getV() {
            return v;
        }

        public void setV(String v) {
            this.v = v;
        }

        public String getValue() {
            return value;
        }

        public void setValue(String value) {
            this.value = value;
        }

        @Override
        public String toString() {
            return "TxDetail{" +
                    "blockHash='" + blockHash + '\'' +
                    ", blockNumber='" + blockNumber + '\'' +
                    ", chainId='" + chainId + '\'' +
                    ", condition='" + condition + '\'' +
                    ", creates='" + creates + '\'' +
                    ", from='" + from + '\'' +
                    ", gas='" + gas + '\'' +
                    ", hash='" + hash + '\'' +
                    ", input='" + input + '\'' +
                    ", nonce='" + nonce + '\'' +
                    ", publicKey='" + publicKey + '\'' +
                    ", r='" + r + '\'' +
                    ", raw='" + raw + '\'' +
                    ", s='" + s + '\'' +
                    ", standardV='" + standardV + '\'' +
                    ", to='" + to + '\'' +
                    ", transactionIndex='" + transactionIndex + '\'' +
                    ", v='" + v + '\'' +
                    ", value='" + value + '\'' +
                    '}';
        }
    }


    public static class StorageChange {
        private String block;
        private List<List<String>> changes;

        public String getBlock() {
            return block;
        }

        public void setBlock(String block) {
            this.block = block;
        }

        public List<List<String>> getChanges() {
            return changes;
        }

        public void setChanges(List<List<String>> changes) {
            this.changes = changes;
        }

        @Override
        public String toString() {
            return "StorageChange{" +
                    "block='" + block + '\'' +
                    ", changes=" + changes +
                    '}';
        }

    }

    public static class DigestItem {
        private String[] logs;

        public String[] getLogs() {
            return logs;
        }

        public void setLogs(String[] logs) {
            this.logs = logs;
        }

        @Override
        public String toString() {
            return "DigestItem{" +
                    "logs=" + Arrays.toString(logs) +
                    '}';
        }
    }

    public static class BlockDetail {
        private Header header;
        private String[] extrinsics;

        public Header getHeader() {
            return header;
        }

        public void setHeader(Header header) {
            this.header = header;
        }

        public String[] getExtrinsics() {
            return extrinsics;
        }

        public void setExtrinsics(String[] extrinsics) {
            this.extrinsics = extrinsics;
        }

        @Override
        public String toString() {
            return "BlockDetail{" +
                    "header=" + header +
                    ", extrinsics=" + Arrays.toString(extrinsics) +
                    '}';
        }
    }

    public static class Block {
        private BlockDetail block;
        private  byte[] justification;


        public BlockDetail getBlock() {
            return block;
        }

        public void setBlock(BlockDetail block) {
            this.block = block;
        }

        public byte[] getJustification() {
            return justification;
        }

        public void setJustification(byte[] justification) {
            this.justification = justification;
        }

        @Override
        public String toString() {
            return "Block{" +
                    "block=" + block +
                    ", justification=" + Arrays.toString(justification) +
                    '}';
        }
    }

    public static class Header {
        private DigestItem digest;
        private String extrinsicsRoot;
        private String number;
        private String parentHash;
        private String stateRoot;

        public DigestItem getDigest() {
            return digest;
        }

        public void setDigest(DigestItem digest) {
            this.digest = digest;
        }

        public String getExtrinsicsRoot() {
            return extrinsicsRoot;
        }

        public void setExtrinsicsRoot(String extrinsicsRoot) {
            this.extrinsicsRoot = extrinsicsRoot;
        }

        public String getNumber() {
            return number;
        }

        public void setNumber(String number) {
            this.number = number;
        }

        public String getParentHash() {
            return parentHash;
        }

        public void setParentHash(String parentHash) {
            this.parentHash = parentHash;
        }

        public String getStateRoot() {
            return stateRoot;
        }

        public void setStateRoot(String stateRoot) {
            this.stateRoot = stateRoot;
        }

        @Override
        public String toString() {
            return "Header{" +
                    "digest=" + digest +
                    ", extrinsicsRoot='" + extrinsicsRoot + '\'' +
                    ", number='" + number + '\'' +
                    ", parentHash='" + parentHash + '\'' +
                    ", stateRoot='" + stateRoot + '\'' +
                    '}';
        }
    }

}
