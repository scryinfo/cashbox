package info.scry.wallet_manager;

import java.util.List;
import java.util.Map;

public class NativeLib {

    //Chain type
    private interface ChainType {
        public static final int UNKNOWN = 0;
        public static final int BTC = 1;
        public static final int BTC_TEST = 2;
        public static final int ETH = 3;
        public static final int ETH_TEST = 4;   //Ropsten uses this test chain
        public static final int EEE = 5;
        public static final int EEE_TEST = 6;
    }

    public enum WalletType {
        TEST_WALLET,
        WALLET
    }

    //Communication message status code  （StatusCode It is only used to stipulate the status identification at both ends, not in the method parameter）
    private interface StatusCode {
        public static final int DYLIB_ERROR = -1;                   //Dynamic library execution error
        public static final int OK = 200;                           //normal
        public static final int FAIL_TO_GENERATE_MNEMONIC = 100;    //Failed to generate mnemonic
        public static final int PWD_IS_WRONG = 101;                 //wrong password
        public static final int FAIL_TO_RESET_PWD = 102;            //Password reset failed
        public static final int GAS_NOT_ENOUGH = 103;               //Insufficient GAS fee
        public static final int BROADCAST_OK = 104;                 //Successful broadcast on the chain
        public static final int BROADCAST_FAILURE = 105;            //Broadcasting failed
    }

    static {
        System.loadLibrary("wallet");
    }

    /*--------------------------------------------Mnemonic--------------------------------------------*/
    //Generate mnemonic words (optional number)
    public static class Mnemonic {
        public int status;
        public byte[] mn;
        public String mnId; //Todo mnID generation rules?uuid or hash
        public String message;  //Error message, detailed description
    }

    public static class Address {
        public int chainType;
        public String pubKey; //todo description specific format
        public String addr; //todo description specific format
        public byte[] priKey; //Except that Export has value, the rest have no value
    }

    // Create mnemonic words, to be verified correctly, the wallet is created by the bottom layer, and the application layer is saved
    // apiNo:MM00
    public static native Mnemonic mnemonicGenerate(int count);

    //Prove possession of private key
    public static class MnemonicProveOwn {
        public String content;
        public long ts;
        public String hash; //hash256
        public String signed; //
        public String pubKey;
        public String algorithm; //Signature algorithm used
    }

    public static native MnemonicProveOwn mnemonicProveOwn(String mnId);

    //Signature, this method will call the special code of the chain, generate a hash to sign, here is the original transaction information
    public static native Message mnemonicSign(String rawTx, String mnId, int chainType, byte[] pwd);

    /*------------------------------------------Wallet management related------------------------------------------*/
    public static class Wallet {
        public int status;  //status code
        public String walletId;
        public String walletName;
        public WalletType walletType;
        public EeeChain eeeChain;
        public EthChain ethChain;
        public BtcChain btcChain;
        public String nowChainId;   //Current chain id
        public boolean isNowWallet;    //Is it the current wallet?
        public String creationTime; //Wallet creation time, unit: second
        public String message;      //Error message, detailed description

    }

    public static class EeeChain {
        public int status;          //status code
        public String chainId;
        public String walletId;
        public String address;      //Chain address
        public String domain;       //Node domain IP
        public boolean isVisible;   //Whether the chain is displayed
        public List<EeeDigit> digitList;
        public int chainType;
    }

    public static class EeeDigit {
        public int status;  //status code
        public String digitId;
        public String chainId;
        public String contractAddress;
        public String shortName;
        public String fullName;
        public String balance;
        public boolean isVisible;
        public int decimal;
        public String imgUrl;
    }

    public static class EthChain {
        public int status;  //status code
        public String chainId;
        public String walletId;
        public String address;      //Chain address
        public String domain;       //Node domain IP
        public boolean isVisible;
        public List<EthDigit> digitList;
        public int chainType;
    }

    public static class EthDigit {
        public int status;  //status code
        public String digitId;
        public String chainId;
        public String contractAddress;
        public String shortName;
        public String fullName;
        public String balance;
        public boolean isVisible;
        public int decimal;
        public String imgUrl;
    }

    public static class BtcChain {
        public int status;          //status code
        public String chainId;
        public String walletId;
        public String address;      //chain address
        public String domain;       //Node domain IP
        public boolean isVisible;
        public List<BtcDigit> digitList;
        public int chainType;
    }

    public static class BtcDigit {
        public int status;           //status code
        public String digitId;
        public String chainId;
        public String shortName;
        public String fullName;
        public String balance;
        public boolean isVisible;
        public int decimal;
        public String imgUrl;
    }

    public static class WalletState {
        public int status;                    //Communication message status code        200 message returned normally
        public boolean isContainWallet;       //Whether you already have a wallet          apiNo:WM01   Execution status: 1 success 0 failure
        public String walletId;               //Current wallet id            apiNo:WM05
        public boolean isSetNowWallet;        //Set the current wallet, whether it is successful  apiNo:WM06   Execution status: 1 success 0 failure
        public boolean isDeletWallet;         //Whether the wallet was deleted successfully       apiNo:WM07   Execution status: 1 success 0 failure
        public boolean isResetPwd;            //Whether reset the password successfully       apiNo:WM08   Execution status: 1 success 0 failure
        public boolean isRename;              //Was it successful to reset the wallet name     apiNo:WM09   Execution status: 1 success 0 failure
        public boolean isShowChain;           //Set the display chain, whether it is successful    apiNo:WM10   Execution status: 1 success 0 failure
        public boolean isHideChain;           //Set hidden chain, whether it is successful    apiNo:WM11   Execution status: 1 success 0 failure
        public int getNowChainType;           //Get current chain type        apiNo:WM12   int
        public boolean isSetNowChain;         //Set up the current chain, is it successful    apiNo:WM13   Execution status: 1 success 0 failure
        public boolean isShowDigit;           //Set to show whether the token is successful   apiNo:WM14   Execution status: 1 success 0 failure
        public boolean isHideDigit;           //Set up hidden tokens, whether it is successful   apiNo:WM15   Execution status: 1 success 0 failure
        public boolean isAddDigit;            //Add tokens, is it successful       apiNo:WM16   Execution status: 1 success 0 failure
        public boolean isUpdateDigitBalance;  //Is it a success to update the number of tokens owned   Execution status: 1 success 0 failure
        public boolean isInitWalletBasicData;  //Is it successful to initialize the basic data of the data  Execution status: 1 success 0 failure
        public boolean isUpdateAuthDigit;     //Update the authentication token, is it successful   Execution status: 1 success 0 failure
        public boolean isUpdateDefaultDigit;  //Was it successful to update the default token   Execution status: 1 success 0 failure
        public boolean isAddNonAuthDigit;     //Add custom tokens, whether it's useful  Execution status: 1 success 0 failure
        public String message;                //Error message, detailed description


    }

    public static class EthToken {
        public String id;
        public String symbol;
        public String name;
        public String publisher;
        public String project;
        public String logoUrl;
        public String logoBytes;
        public int decimal;
        public int gasLimit;
        public String contract;
        public String acceptId;
        public String chainType;
        public String mark;
        public int updateTime;
        public int createTime;
        public int version;
    }

    public static class DigitList {
        public int status;//Dynamic library call result
        public String message;      //Error message, detailed description
        public int count;//Total number
        public int startItem;//Starting number
        public List<EthToken> ethTokens;
    }

    /**
     * Initialize wallet data file, load basic data
     *
     * @return// Whether you already have a wallet
     */
    public static native WalletState initWalletBasicData();

    // apiNo:WM01 fixed - fixed
    public static native WalletState isContainWallet();

    // Export all wallets
    // apiNo:WM02 fixed
    public static native List<Wallet> loadAllWalletList();

    /**
     * 保存钱包 apiNo:WM03 fixed
     *
     * @param walletName
     * @param pwd
     * @param Mnemonic
     * @param walletType 1 Official wallet, 0 test wallet
     * @return
     */
    public static native Wallet saveWallet(String walletName, byte[] pwd, byte[] Mnemonic, int walletType);

    // Wallet export. Restore wallet mnemonic
    // apiNo:WM04
    public static native Mnemonic exportWallet(String walletId, byte[] pwd);

    // Get current wallet
    // apiNo:WM05 fixed -           //loadAllWallet Alternative
    public static native WalletState getNowWallet();

    // Set whether the current wallet bool is successful
    // apiNo:WM06 fixed - fixed
    public static native WalletState setNowWallet(String walletId);

    // Delete the wallet. The wallet settings can be deleted, and the chain settings are hidden.
    // apiNo:WM07
    public static native WalletState deleteWallet(String walletId, byte[] pwd);

    // Reset the wallet password.
    // apiNo:WM08 fixed
    public static native WalletState resetPwd(String walletId, byte[] newPwd, byte[] oldPwd);

    // Reset the wallet name
    // apiNo:WM09 fixed
    public static native WalletState rename(String walletId, String walletName);

    // Display chain
    // apiNo:WM10 fixed
    public static native WalletState showChain(String walletId, int chainType);

    // hidden chain 
    // apiNo:WM11 fixed
    public static native WalletState hideChain(String walletId, int chainType);

    // Get the current chain
    // apiNo:WM12
    public static native WalletState getNowChainType(String walletId);

    // set up the current chain
    // apiNo:WM13
    public static native WalletState setNowChainType(String walletId, int chainType);

    // display token
    // apiNo:WM14
    public static native WalletState showDigit(String walletId, int chainType, String digitId);

    // hidden token
    // apiNo:WM15
    public static native WalletState hideDigit(String walletId, int chainType, String digitId);

    /**
     * Add tokens, this interface is to add the tokens in the token library to the default list, provide wallet management token balance apiNo:WM16
     *
     * @param walletId  wallet ID
     * @param chainType chain type
     * @param digitId   token id
     * @return
     */
    public static native WalletState addDigit(String walletId, int chainType, String digitId);


    /**
     * Add non-certified tokens
     *
     * @param digitData The data format is the same as adding authentication tokens
     * @return
     */
    public static native WalletState addNonAuthDigit(String digitData);

    /**
     * Update trust token
     *
     * @param digitData List of authentication tokens obtained from the server, json format data
     * @return
     */
    public static native WalletState updateAuthDigitList(String digitData);

    /**
     * Update the default token
     *
     * @param digitData List of default tokens obtained from the server, json format data
     * @return
     */
    public static native WalletState updateDefaultDigitList(String digitData);

    /**
     * Query the list of certified tokens
     *
     * @param chain_type Use the number defined in ChainType
     * @param isAuth
     * @param startItem  Start number
     * @param pageSize   How many items are currently taken
     * @return
     */
    public static native DigitList getDigitList(int chainType, boolean isAuth, int startItem, int pageSize);

    /**
     * View token information
     *
     * @param chainType     chain type
     * @param name          Token name, either abbreviated or full name (this field provides fuzzy query)
     * @param contract_addr Contract address (the exact address must be entered in this field)
     * @return
     */
    public static native DigitList queryDigit(int chainType, String name, String contract_addr);


    /*------------------------------------------chain related ------------------------------------------*/


    /* //Get transaction records. Distinguish the chain type, specify the address, specify the number
    //Return: Chain transaction record.
    public static native String chainGetTxHistory(int chainType, String targetAddress, int fromNum, int toNum);*/


    /*--------------------------chain related   eee --------------------------*/
    //ipAddress: 127.0.0.1:66,  There can be multiple addresses here, this one will be used first
    public static class Handle {
        public int status;
        public long handle;
    }

    public static native Handle eeeOpen(String ipAddress, String chainId);

    public static native int eeeClose(long handle);

    public static class Message {
        public int status;                  //Communication message Status Code StatusCode 200 succeeded
        public String message;              //Detailed error information
        public String signedInfo;           //Post-signature information
        public String energyTransferInfo;   //Turn energy result hash
        public String ethSignedInfo;        //Sign eth transaction information
        public String inputInfo;            //extra information
        public String accountKeyInfo;       //Account storage key
        public AccountInfo accountInfo;     //account information 
    }

    //Define EEE chain account information
    public static class AccountInfo {
        public int nonce;                // The number of transactions this account has sent.
        public int refcount;             //The number of other modules that currently depend on this account's existence.
        public String free;              //Discretionary balance
        public String reserved;          //Remaining balance, the balance here means participation in required activities, and the related business has not
        // yet been designed on the chain
        public String misc_frozen;      // The amount that `free` may not drop below when withdrawing for *anything except transaction fee payment*.
        public String fee_frozen;       //The amount that `free` may not drop below when withdrawing specifically for transaction fee payment.
    }

    public static class SyncStatus {
        public int status;                  //Communication message Status Code StatusCode 200 succeeded
        public String message;              //Detailed error information
        public Map<String, AccountRecord> records;
    }

    public static class AccountRecord {
        public String account;
        public int chainType;
        public int blockNum;
        public String blockHash;
    }

    //Get the assembled original transaction, distinguish the chain type
    //Return: Unsigned transaction String, the format is json format
    //The first parameter is the return value of eeeOpen
    //  Add a new interface that will not affect the use of old versions of
    // About eee related data acquisition, transaction extraction, all are operated by the client, the bottom layer does not operate the network;
    // The bottom layer directly constructs a signed transfer transaction, and returns the information that can be directly submitted to the chain through
    // the signedInfo attribute in the Message field.
    // Note: vaule uses the default unit in the transfer: unit, the precision is 10^12, that is, 1 unit =1000_000_000_000
    public static native Message eeeTransfer(String from, String to, String value, String genesisHash, int index, int runtime_version,int tx_version, byte[] pwd);

    //msg: transaction
    //TODO The use of this interface also needs to be re-planned
    public static native Message eeeEnergyTransfer(String from, byte[] pwd, String to, String value, String extendMsg);

    // The signature result is: transaction type
    public static native Message eeeTxSign(String rawTx, String mnId, byte[] pwd);

    // Only do information signature, tool function
    public static native Message eeeSign(String rawTx, String mnId, byte[] pwd);

    //Broadcast transaction, distinguish the chain type
    //msg: Transaction ID
    public static native Message eeeTxBroadcast(long handle, String signedTx);

    //msg: balance
    public static native Message eeeBalance(long handle, String addr);

    //msg: energy balance
    public static native Message eeeEnergyBalance(long handle, String addr);

    //For the key corresponding to the EEE account information, enter the address to be queried, for example: 5FfBQ3kwXrbdyoqLPvcXRp7ikWydXawpNs2Ceu3WwFdhZ8W4,
    //  return the encoded key
    // :0x26aa394eea5630e07c48ae0c9558cef7b99d880ec681799c0cf30e8886371da9f2fb387cbda1c4133ab4fd78aadb38d89effc1668ca381c242885516ec9fa2b19c67b6684c02a8a3237b6862e5c8cd7e
    //Construct jsonrpc request data format {"id":37,"jsonrpc":"2.0","method":"state_subscribeStorage","params":[["key"]]]}
    public static native Message eeeAccountInfoKey(String addr);

    /**
     * Decode account information queried back from the chain
     *
     * @param encodeData Enter data in hexadecimal format  ‘0x’
     * @return If the format is correct, return status 200, the accountInfo field in the Message contains details, if the format is incorrect, the msg
     * field contains error information
     */
    public static native Message decodeAccountInfo(String encodeData);

    /**
     * Transaction details saved on the specified block (currently only focused on transfer transactions)
     *
     * @param accountId   The account of the transaction (the target account)
     * @param eventDetail
     * @param blockHash
     * @param extrinsics  Transaction details included in the block
     * @return
     */

    public static native Message saveExtrinsicDetail(String accountId, String eventDetail, String blockHash, String extrinsics);

    /**
     * Record the currently synchronized block number, used for the starting position when the update is triggered next time
     *
     * @param account    Synchronized account
     * @param chain_type
     * @param block_num
     * @param block_hash
     * @return
     */
    public static native Message updateEeeSyncRecord(String account, int chain_type, int block_num, String block_hash);

    /**
     * Get the current synchronization status
     *
     * @return
     */
    public static native SyncStatus getEeeSyncRecord();

    /*------------------------------------------Transaction related------------------------------------------*/

    // Eth transaction signature. The signature result is: transaction type
    // Explanation: gasPrice unit: gwei gaslimit unit: gwei (1 ETH = 1e9 gwei (10 to the ninth power))
    //      When gasPrice and gasLimit pass values, pass integer type strings. For example: "1000", not "100.0"
    //     Chain type int: 3: formal chain 4: test chain (Ropsten), currently only these two test chains are used
    public static native Message ethTxSign(String mnId, int chainType, String fromAddress, String toAddress, String contractAddress, String value,
                                           String backup, byte[] pwd, String gasPrice, String gasLimit, String nonce, int decimal);

    //ETH transaction assembly. Returns: Unsigned transaction String.
    //
    public static native byte[] ethTxMakeETHRawTx(byte[] encodeMneByte, byte[] pwd, String fromAddress, String toAddress, String value,
                                                  String backupMsg, String gasLimit, String gasPrice);

    //ERC20 transaction assembly. Returns: unsigned transaction String
    //
    public static native byte[] ethTxMakeERC20RawTx(byte[] encodeMneByte, byte[] pwd, String fromAddress, String contractAddress, String toAddress,
                                                    String value, String backupMsg, String gasLimit, String gasPrice);

    //Handling suggestions are given priority, and the repository that implements spv does it. It is more convenient to get utxo, as well as change address
    // selection, change amount.
    public static native byte[] btcTxMakeBTCRawTx(String[] from, String[] to, String value);

    // BTC api_01
    // sign transaction
    // result type: byte[]
    public static native byte[] btcTxSign(String from, String to, String value);

    // BTC api_02
    // sign transaction and broadcast
    // result type: boolean
    public static native boolean btcTxSignAndBroadcast(String from, String to, String value);

    // BTC api_03
    // load BTC balance
    // result type: String
    public static native String btcLoadBalance(String address);

    // BTC api_04
    // max_block_number
    // result type: String
    public static native String btcLoadMaxBlockNumber();

    // BTC api_05
    // now_block_number
    // result type: String
    public static native String btcLoadNowBlockNumber();

    // BTC api_06
    // is sync data ok
    // result type: boolean
    public static native boolean btcIsSyncDataOk();

    // BTC api_07
    // transaction history
    // param: startIndex：the start index of history list,   offset：the number of wanted tx history
    // result type:        todo
    public static native boolean btcLoadTxHistory(String address, int startIndex, String offset);


    //Broadcast transaction, distinguish the chain type
    //Return: broadcast success 1, broadcast failure 0
    public static native boolean ethTxBroascastTx(byte[] signedTx);

    public static native boolean btcTxBroascastTx(byte[] signedTx);

    /**
     * Update the balance of the token corresponding to the address
     *
     * @param address chain address
     * @param digitId token id
     * @param balance Number of tokens  How to determine the token unit passed in?
     * @return Update wallet token results, use isUpdateDigitBalance to identify operation results
     */
    public static native WalletState updateDigitBalance(String address, String digitId, String balance);

    //Decode additional transaction information
    public static native Message decodeAdditionData(String input);


}

/*
    fixd Mnemonic words are managed independently, one auxiliary word can generate multiple chain addresses（eth,btc,eee）

    fixd The signature is independent from the wallet

    fixd Chain function: get the address transaction related to the wallet,

    fixd Generate transaction (no signature), transaction on-chain and process
         Chain ui independent management

         The transaction record is stored locally, and the record position on the chain? 

           Source of wallet list loading?

             Local database: save local transaction records + wallet list (add, delete, wallet name, set current wallet, wallet chain address, chain token
             information)
            Save it in flutter and process
*/
//add
//0x210584ff0a146e76bbdc381bd77bb55ec45c8bef5f52e2909114d632967683ec1eb4ea3001106acdf7d07a12186542cc4679a4c8c298c2ed2ad39862c64a3b0016bdb04a10feddba01a849861bd81b4c86ae2a0ec42d4cefd1120944a053d2bf5d09b6e2880000001102ffc7f0c7f2cbe69ddcdf62b2384973dd0e54c2ec547157f87aa722feb46be7b2c5000220bcbee10217041815000000000480764285227a94f0915d24b5c8477c952693d43e1671be6bf591122115d0184dbdefabc3e85f37f061183685d7a14551e491a6fd1a6cee99dfda48a8275ece850a146e76bbdc381bd77bb55ec45c8bef5f52e2909114d632967683ec1eb4ea30000000000000000000000000000000000000000000000000000000105cf5eed286eb8a1ab48bd5fed1a307bcdc3f56d3a81e38d93cbade67ccfe6808746573744e616d6500000000000000e8030000
// delete
//0xd10484ff0a146e76bbdc381bd77bb55ec45c8bef5f52e2909114d632967683ec1eb4ea3001eee80fd8acfa5f3c2427a74c862c41fb11dcf1b04c262b6b1112c94f85bf614f31cc2a9a7ab7a67d793b54f7a4789a2772028f20d80ad6beb69701af5f8ab58a0004001102ffc7f0c7f2cbe69ddcdf62b2384973dd0e54c2ec547157f87aa722feb46be7b2c5000220bcbe9102591a0ac0010000000446586be0edb1e24e5c2cf9bd4f3f6a134cd83f7a5b1f94b1ac664304ef49775e2328d32c780cd168f35e9e0d5112f06294bf1dd88c94c4a9e36511a2068eb3820a146e76bbdc381bd77bb55ec45c8bef5f52e2909114d632967683ec1eb4ea3000000000000000000000000000000000000000000000000000000078c31562f5207d7796233f16214d17d272009f7a822d073e7417b5474ed6516b
