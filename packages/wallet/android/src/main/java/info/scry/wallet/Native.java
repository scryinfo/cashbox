package info.scry.wallet;

public class Native {
    //链类型
    private interface ChainType {
        public static final int BTC = 1;
        public static final int BTC_TEST = 2;
        public static final int ETH = 3;
        public static final int ETH_TEST = 4;
        public static final int EEE = 5;
        public static final int EEE_TEST = 6;
    }


    //通信消息 状态码
    private interface StatusCode {
        public static final int OK = 200;                           //正常
        public static final int FAIL_TO_GENERATE_MNEMONIC = 100;    //生成助记词失败
        public static final int PWD_IS_WRONG = 101;                 //密码错误
        public static final int FAIL_TO_RESET_PWD = 102;            //重置密码失败
        public static final int GAS_NOT_ENOUGH = 103;               //GAS费不足
        public static final int BROADCAST_OK = 104;                 //广播上链成功
        public static final int BROADCAST_FAILURE = 105;            //广播上链失败
    }

    static {
        System.loadLibrary("wallet");
    }
        //todo mnemonic byte[]
    //所有byte[]的字符串，编码为utf-8 ？
    //调用函数没有返回值时，返回 int 是error code
    //如果有返回值那么，使用 class返回， class中有一个字段为 error，表示error code,  如果返回class没有创建成功返回 null
    //所有的class都提供一个函数，设置所有值的功能（这是为了减少与jvm交互的次数）

    /*--------------------------助记词--------------------------*/
    //生成助记词（个数可选）
    public static class Mnemonic {
        public int status;
        public byte[] mn;
        public String mnId; //todo mnID的生成规则？ uuid or hash
    }

    public static class Address {
        public int chainType;
        public String pubKey; //todo 说明具体格式
        public String addr; //todo 说明具体格式
        public byte[] priKey; //除Export有值外，其余都没有值
    }

    public static native Mnemonic mnemonicGenerate(int count);

    public static native Mnemonic mnemonicSave(byte[] mn, byte[] pwd); //需要生成地址及公钥，并保存

    //重置密码, mmId不会变
    public static native int mnemonicResetPwd(String mnId, byte[] oldPwd, byte[] newPwd);

    public static class MnemonicExport {
        public int status;
        public byte[] mn;
        public String mnId;
        public Address[] addrs;
    }
    public static native MnemonicExport mnemonicExport(String mnId, byte[] pwd);

    public static class MnemonicAddresses {
        public int status;
        public Address[] addrs;
    }
    public static native MnemonicAddresses mnemonicAddresses(String mnId); //没有 private key

    //解密后，重新生成所有的 public key and address
    public static native MnemonicAddresses mnemonicDecodeAddresses(String mnId, byte[] pwd);


    public static class MnemonicAddress {
        public int status;
        public Address addrs;
    }
    public static native MnemonicAddress mnemonicAddress(String mnId, int chainType); //没有 private key

    //解密后，重新生成所有的 public key and address
    public static native MnemonicAddress mnemonicDecodeAddress(String mnId, int chainType, byte[] pwd);


    //证明拥有私钥
    public static class MnemonicProveOwn {
        public String content;
        public long ts;
        public String hash; //hash256
        public String signed; //
        public String pubKey;
        public String algorithm; //使用的签名算法
    }
    public static native MnemonicProveOwn mnemonicProveOwn(String mnId);


    //签名， 此方法会调用链的特别代码，生成hash进行签名， 这里传入的是原始的交易信息
    public static native Message mnemonicSign(String rawTx, String mnId, int chainType,  byte[] pwd);




    /*------------------------------------------链相关------------------------------------------*/


    /* //获取交易记录。 区分链类型， 指定地址 指定条数
    //返回：链交易记录。
    public static native String chainGetTxHistory(int chainType, String targetAddress, int fromNum, int toNum);*/
	
	
	
	/*--------------------------交易相关  eee --------------------------*/
    //ipAddress: 127.0.0.1:66,  这里有地址有可以是多个，这个暂时先使用一个
    public static class Handle {
        public int status;
        public long handle;
    }
    public static native Handle eeeOpen(String ipAddress, String chainId);
    public static native int eeeClose(long handle);

    public static class Message {
        public int status;
        public String msg;
    }
    //获取拼装原始交易，区分链类型
    //返回：未签名的交易 String, 格式为json格式
    //第一个参数为 eeeOpen 的返回值
    //具体的参数格式，需要与Jermy一起确定
    //msg: 交易
    public static native Message eeeTransfer(long handle, String from, String to, String value, String extendMsg);

    //msg: 交易
    public static native Message eeeEnergyTransfer(long handle, String from, String to, String value, String extendMsg);

    //获取签名后的交易信息，区分链类型
    //返回：签名后的交易 String
    //msg: 签名后的交易
    //此方法会直接调用到助记词的相关方法
    public static native Message eeeTxSign(String rawTx, String mnId, byte[] pwd);

    //广播交易，区分链类型
    //msg:交易ID
    public static native Message eeeTxBroadcast(long handle, String signedTx);

    //msg: balance
    public static native Message eeeBalance(long handle, String addr);
    //msg: energy balance
    public static native Message eeeEnergyBalance(long handle, String addr);
	
	//EEE nonce获取
    public static native String eeeGetTxNonce();


    /*------------------------------------------交易相关------------------------------------------*/
    //ETH 交易拼装。   返回：未签名的交易 String。
    //nonce记录位置？？？
    public static native byte[] ethTxMakeETHRawTx(byte[] encodeMneByte, String pwd, String fromAddress, String toAddress,
                                                  String value, String backupMsg, String gasLimit, String gasPrice);

    //ERC20 交易拼装。    返回：未签名的交易 String
    // nonce记录位置？？？
    public static native byte[] ethTxMakeERC20RawTx(byte[] encodeMneByte, String pwd, String fromAddress, String contractAddress,
                                                    String toAddress, String value, String backupMsg, String gasLimit, String gasPrice);

    //处理建议优先考虑，实现spv的库处做。   能更方便获取utxo,还有找零地址选择,找零金额。
    public static native byte[] btcTxMakeBTCRawTx(String[] from, String[] to, String value);


    //获取签名后的交易信息，区分链类型
    //返回：签名后的交易 byte[]
    public static native byte[] ethTxSignTx(String rawTx, byte[] encodeMne, String pwd);

    public static native byte[] btcTxSignTx(String rawTx, byte[] encodeMne, String pwd);

    //广播交易，区分链类型
    //返回：广播成功1、 广播失败0
    public static native boolean ethTxBroascastTx(byte[] signedTx);

    public static native boolean btcTxBroascastTx(byte[] signedTx);

}

/*
    fixd 助记词独立管理，一个助词可以生成多种链地址（eth,btc,eee）

    fixd 签名从钱包中独立出来

    fixd 链功能：取到与钱包相关的地址交易，

    fixd 生成交易（no签名），交易上链及过程

         链ui独立管理

         交易记录本地存放，跟链上记录位置？？

         钱包列表加载来源？

         本地数据库：    保存本地交易记录 + 钱包列表（新增、删除、钱包名、设当前钱包、钱包链地址、链上代币信息）
         放在flutter保存，处理
*/