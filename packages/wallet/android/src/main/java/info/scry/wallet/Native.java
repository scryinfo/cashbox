package info.scry.wallet;

public class Native {
    //链类型
    private class ChainType {
        public static final int BTC = 1;
        public static final int BTC_TEST = 2;
        public static final int ETH = 3;
        public static final int ETH_TEST = 4;
        public static final int EEE = 5;
        public static final int EEE_TEST = 6;
    }

    //通信消息
    private class Message {
        public int err;         //StatusCode状态码
        public byte[] data;
    }

    //通信消息 状态码
    private class StatusCode {
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

    /*------------------------------------------助记词------------------------------------------*/
    //生成助记词（个数可选）
    //返回：String       "{ err:" + err +","+"data:"+ 助记词byte[]+" }"
    public static native String mnemonicGenerate(int count);

    //加密助记词 ， 根据助记词 + 密码，
    //返回：String       "{ err:" + err +","+"data:"+加密后的助记词 byte[]+" }"
    public static native String mnemonicEncode(byte[] mn, byte[] pwd);

    //解密助记词 ， 根据 加密后的助记词字串 + 密码
    //返回：String        "{ err:" + err +","+"data:"+ 助记词 byte[]+" }"
    public static native String mnemonicDecode(byte[] en, byte[] pwd);

    //重置密码， 根据 加密后的助记词字串 + 旧密码 + 新密码，
    //返回：String        "{ err:" + err +","+"data:"+ 助记词 byte[] +" }"
    public static native String mnemonicResetPwd(byte[] en, byte[] oldPwd, byte[] newPwd);

    /*------------------------------------------链相关------------------------------------------*/
    //获取链地址。区分链类型
    //返回：链地址String  "{ err:" + err +","+"data:"+ byte[]+" }"
    //data说明： "[{ chainType:0,address:0x123456789},{ chainType:1,address:0x987654321}]" 转成 byte[]
    public static native String[] chainGetAddress(byte[] mn, int[] chainType);

    /* //获取交易记录。 区分链类型， 指定地址 指定条数
    //返回：链交易记录。
    public static native String chainGetTxHistory(int chainType, String targetAddress, int fromNum, int toNum);*/

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

    //EEE nonce获取
    public static native String eeeGetTxNonce();

    public static native byte[] eeeTxMakeRawTx(String from, String to, String nonce, String value, String backupMsg);

    //获取签名后的交易信息，区分链类型
    //返回：签名后的交易 byte[]
    public static native byte[] ethTxSignTx(String rawTx, byte[] encodeMne, String pwd);

    public static native byte[] eeeTxSignTx(String rawTx, byte[] encodeMne, String pwd);

    public static native byte[] btcTxSignTx(String rawTx, byte[] encodeMne, String pwd);

    //广播交易，区分链类型
    //返回：广播成功1、 广播失败0
    public static native boolean ethTxBroascastTx([]byte signedTx);

    public static native boolean btcTxBroascastTx([]byte signedTx);

    public static native boolean eeeTxBroascastTx([]byte signedTx);

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