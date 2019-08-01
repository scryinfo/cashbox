/* 链类型chaintType约定
    1-----BTC
    2-----BTC_TEST
    3-----ETH
    4-----ETH_TEST
    5-----EEE
    6-----EEE_TEST
    7-----EOS
    8-----EOS_TEST
* */

public class Native {

    static {
        System.loadLibrary("wallet");
    }

    /*--------------------------助记词--------------------------*/
    //生成助记词（个数可选）
    //返回：助记词String
    public static native boolean mnemonicGenerate(int count);

    //恢复出 助记词， 根据加密json文件字串 + 密码，
    //返回：助记词String
    public static native boolean mnemonicBackupMnemonic(String jsonStr, String pwd);

    //重置密码， 根据加密json文件字串 + 旧密码 + 新密码，
    //返回：成功1、失败0
    public static native boolean mnemonicResetPwd(String jsonStr, String oldPwd, String newPwd);

    //导入助记词,创建keystore加密文件
    //返回：成功1、失败0
    public static native boolean mnemonicImportMnemonic(String mnemonic);

    /*--------------------------链相关--------------------------*/
    //获取链地址。区分链类型
    //返回：链地址String
    public static native boolean chainGetAddress(int chainType);

/*    //获取交易记录。 区分链类型， 指定地址 指定条数
    //返回：链交易记录。
    public static native String chainGetTxHistory(int chainType, String targetAddress, int fromNum, int toNum);*/

    /*--------------------------交易相关--------------------------*/
    //获取拼装原始交易，区分链类型
    //返回：未签名的交易 String
    public static native String txMakeRawTx(int chainType, String from, String to, String value, String backupMsg);

    //获取签名后的交易信息，区分链类型
    //返回：签名后的交易 String
    public static native String txSignTx(int chainType, String rawTx);

    //广播交易，区分链类型
    //返回：广播成功1、 广播失败0
    public static native boolean txBroascastTx(int chainType, String signedTx);

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

