package info.scry.wallet_manager;

import java.util.List;

public class NativeLib {

    //链类型
    private interface ChainType {
        public static final int UNKNOWN = 0;
        public static final int BTC = 1;
        public static final int BTC_TEST = 2;
        public static final int ETH = 3;
        public static final int ETH_TEST = 4;   //Ropsten 用这条测试链
        public static final int EEE = 5;
        public static final int EEE_TEST = 6;
    }

    public enum WalletType {
        TEST_WALLET,
        WALLET
    }

    //通信消息 状态码  （StatusCode 仅用来约定两端状态标识，不用在方法传参上）
    private interface StatusCode {
        public static final int DYLIB_ERROR = -1;                   //动态库执行出错
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

    /*--------------------------------------------助记词--------------------------------------------*/
    //生成助记词（个数可选）
    public static class Mnemonic {
        public int status;
        public byte[] mn;
        public String mnId; //todo mnID的生成规则？ uuid or hash
        public String message;  //错误信息，详细说明
    }

    public static class Address {
        public int chainType;
        public String pubKey; //todo 说明具体格式
        public String addr; //todo 说明具体格式
        public byte[] priKey; //除Export有值外，其余都没有值
    }

    // 创建助记词，待验证正确通过，由底层创建钱包完成，应用层做保存
    // apiNo:MM00
    public static native Mnemonic mnemonicGenerate(int count);

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
    public static native Message mnemonicSign(String rawTx, String mnId, int chainType, byte[] pwd);

    /*------------------------------------------钱包管理相关------------------------------------------*/
    public static class Wallet {
        public int status;  //状态码
        public String walletId;
        public String walletName;
        public WalletType walletType;
        public EeeChain eeeChain;
        public EthChain ethChain;
        public BtcChain btcChain;
        public String nowChainId;   //当前链id
        public boolean isNowWallet;    //标识 是不是当前钱包
        public String creationTime; //钱包创建时间,单位：秒
        public String message;      //错误信息，详细说明
    }

    public static class EeeChain {
        public int status;          //状态码
        public String chainId;
        public String walletId;
        public String address;      //链地址
        public String domain;       //节点域名IP
        public boolean isVisible;   //链是否显示
        public List<EeeDigit> digitList;
        public int chainType;
    }

    public static class EeeDigit {
        public int status;  //状态码
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
        public int status;  //状态码
        public String chainId;
        public String walletId;
        public String address;      //链地址
        public String domain;       //节点域名IP
        public boolean isVisible;
        public List<EthDigit> digitList;
        public int chainType;
    }

    public static class EthDigit {
        public int status;  //状态码
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
        public int status;          //状态码
        public String chainId;
        public String walletId;
        public String address;      //链地址
        public String domain;       //节点域名IP
        public boolean isVisible;
        public List<BtcDigit> digitList;
        public int chainType;
    }

    public static class BtcDigit {
        public int status;           //状态码
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
        public int status;                    //通信消息状态码         200消息正常返回
        public boolean isContainWallet;       //是否已有钱包          apiNo:WM01   执行状态：1成功 0失败
        public String walletId;               //当前钱包id            apiNo:WM05
        public boolean isSetNowWallet;        //设置当前钱包,是否成功  apiNo:WM06   执行状态：1成功 0失败
        public boolean isDeletWallet;         //删除钱包是否成功       apiNo:WM07   执行状态： 1成功 0失败
        public boolean isResetPwd;            //重置密码是否成功       apiNo:WM08   执行状态： 1成功 0失败
        public boolean isRename;              //重置钱包名是否成功     apiNo:WM09   执行状态： 1成功 0失败
        public boolean isShowChain;           //设置显示链,是否成功    apiNo:WM10   执行状态： 1成功 0失败
        public boolean isHideChain;           //设置隐藏链,是否成功    apiNo:WM11   执行状态： 1成功 0失败
        public int getNowChainType;           //获取当前链类型         apiNo:WM12   int
        public boolean isSetNowChain;         //设置当前链,是否成功     apiNo:WM13   执行状态： 1成功 0失败
        public boolean isShowDigit;           //设置显示代币,是否成功   apiNo:WM14   执行状态： 1成功 0失败
        public boolean isHideDigit;           //设置隐藏代币,是否成功   apiNo:WM15   执行状态： 1成功 0失败
        public boolean isAddDigit;            //添加代币,是否成功       apiNo:WM16   执行状态： 1成功 0失败
        public boolean isUpdateDigitBalance;  //更新拥有代币的数量,是否成功   执行状态： 1成功 0失败
        public boolean isInitWalletBasicData;  //初始化数据基础数据,是否成功   执行状态： 1成功 0失败
        public boolean isUpdateAuthDigit;  //初始化数据基础数据,是否成功   执行状态： 1成功 0失败
        public boolean isUpdateDefaultDigit;  //更新默认代币,是否成功   执行状态： 1成功 0失败
        public boolean isAddNonAuthDigit;     //添加自定义代币,是否成功   执行状态： 1成功 0失败

        public String message;                //错误信息，详细说明
    }

    public static class EthToken{
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

    public static class AuthList{
        public int status;//动态库调用结果
        public String message;      //错误信息，详细说明
        public int count;//总条数
        public int startItem;//其实条数
        public List<EthToken> authDigit;
    }

    /**
     * 初始化钱包数据文件，加载基础数据
     * @return
     */
    public static native WalletState initWalletBasicData();
    // 是否已有钱包
    // apiNo:WM01 fixed - fixed
    public static native WalletState isContainWallet();

    // 导出所有钱包
    // apiNo:WM02 fixed
    public static native List<Wallet> loadAllWalletList();

    // 保存钱包
    // apiNo:WM03 fixed
    public static native Wallet saveWallet(String walletName, byte[] pwd, byte[] Mnemonic, int walletType);

    // 钱包导出。 恢复钱包助记词
    // apiNo:WM04
    public static native Mnemonic exportWallet(String walletId, byte[] pwd);

    // 获取当前钱包
    // apiNo:WM05 fixed -           //loadAllWallet可替代
    public static native WalletState getNowWallet();

    // 设置当前钱包 bool是否成功
    // apiNo:WM06 fixed - fixed
    public static native WalletState setNowWallet(String walletId);

    // 删除钱包。 钱包设置可删除，链设置隐藏。
    // apiNo:WM07
    public static native WalletState deleteWallet(String walletId, byte[] pwd);

    // 重置钱包密码。
    // apiNo:WM08 fixed
    public static native WalletState resetPwd(String walletId, byte[] newPwd, byte[] oldPwd);

    // 重置钱包名
    // apiNo:WM09 fixed
    public static native WalletState rename(String walletId, String walletName);

    // 显示链
    // apiNo:WM10 fixed
    public static native WalletState showChain(String walletId, int chainType);

    // 隐藏链
    // apiNo:WM11 fixed
    public static native WalletState hideChain(String walletId, int chainType);

    // 获取当前链
    // apiNo:WM12
    public static native WalletState getNowChainType(String walletId);

    // 设置当前链
    // apiNo:WM13
    public static native WalletState setNowChainType(String walletId, int chainType);

    // 显示代币
    // apiNo:WM14
    public static native WalletState showDigit(String walletId, String chainId, String digitId);

    // 隐藏代币
    // apiNo:WM15
    public static native WalletState hideDigit(String walletId, String chainId, String digitId);

    // 增加代币
    // apiNo:WM16
    public static native WalletState addDigit(String walletId, String chainId, String fullName, String shortName, String contractAddress, int decimal);
    // 0515 meeting
    // 1、addDigit区分处理
    // 2、digit数据结构增加字段 是否是自定义
    // 3、查询代币列表，分页
    // 4、检查更新的口子（parker）
    // 5、ip等配置文件，配置流程。（parker）

    /**
     * 添加非认证代币
     * @param digitData 数据格式同添加认证代币一致
     * @return
     */
    public static native WalletState addNonAuthDigit(String digitData);
    /**
     * 更新信任代币
     * @param digitData 从服务端获取的认证代币的列表，json格式数据
     * @return
     */
    public static native WalletState updateAuthDigitList(String digitData);

    /**
     * 更新默认代币
     * @param digitData 从服务端获取的认证代币的列表，json格式数据
     * @return
     */
    public static native WalletState updateDefaultDigitList(String digitData);

    /**
     * 查询认证代币列表
     * @param startItem 开始条数
     * @param pageSize  当前最多取多少条
     * @return
     */
    public static native AuthList getAuthDigitList(int chain_type,int startItem,int pageSize);

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
        public int status;                  //通信消息 状态码StatusCode 200成功
        public String message;              //详细错误信息
        public String signedInfo;           //签名后信息
        public String energyTransferInfo;   //转能量结果hash
        public String ethSignedInfo;        //签名eth交易 所得信息
        public String inputInfo;            //附加信息
        public String accountKeyInfo;       //账户存储key
        public AccountInfo accountInfo;     //账户信息
    }

    //定义EEE 链账户信息
    public static class AccountInfo {
        public int nonce;                // The number of transactions this account has sent.
        public int refcount;             //The number of other modules that currently depend on this account's existence.
        public String free;              //可自由支配的余额
        public String reserved;          //保留的余额，这里面的余额 表示参加需要的活动，目前链上还未设计这相关业务
        public String misc_frozen;      // The amount that `free` may not drop below when withdrawing for *anything except transaction fee payment*.
        public String fee_frozen;       //The amount that `free` may not drop below when withdrawing specifically for transaction fee payment.
    }

    //获取拼装原始交易，区分链类型
    //返回：未签名的交易 String, 格式为json格式
    //第一个参数为 eeeOpen 的返回值
    //具体的参数格式，需要与Jermy一起确定
    //msg: 交易 
    // TODO: 2019/8/17  交易方式待确定，待确定：哪边来做监听交易状态。 目前链转账模块不支持备注填写，若后续需要支持备注功能，将会重新编写转账模块，
    //  增加新的接口，不会影响老版本APP的使用
    // 关于eee相关的数据获取，交易提取，全部由客户端来操作，底层不对网络进行操作；
    // 底层直接构造一个签名好的转账交易，通过Message字段中signedInfo属性传回可以直接提交的到链的信息
    //注意：vaule 在转账中使用默认单位: unit,精度为10^12， 即 1 unit =1000_000_000_000
    public static native Message eeeTransfer(String from, String to, String value, String genesisHash, int index, int runtime_version, byte[] pwd);

    //msg: 交易
    //TODO 该接口的使用还需要重新规划
    public static native Message eeeEnergyTransfer(String from, byte[] pwd, String to, String value, String extendMsg);

    // 签名结果是：交易类型
    public static native Message eeeTxSign(String rawTx, String mnId, byte[] pwd);

    // 只做信息签名，工具函数
    public static native Message eeeSign(String rawTx, String mnId, byte[] pwd);

    //广播交易，区分链类型
    //msg:交易ID
    public static native Message eeeTxBroadcast(long handle, String signedTx);

    //msg: balance
    public static native Message eeeBalance(long handle, String addr);

    //msg: energy balance
    public static native Message eeeEnergyBalance(long handle, String addr);

    //EEE 账号信息对应的key,输入待查询的地址，比如：5FfBQ3kwXrbdyoqLPvcXRp7ikWydXawpNs2Ceu3WwFdhZ8W4，
    // 返回编码后的key
    // :0x26aa394eea5630e07c48ae0c9558cef7b99d880ec681799c0cf30e8886371da9f2fb387cbda1c4133ab4fd78aadb38d89effc1668ca381c242885516ec9fa2b19c67b6684c02a8a3237b6862e5c8cd7e
    //构造jsonrpc 请求数据格式{"id":37,"jsonrpc":"2.0","method":"state_subscribeStorage","params":[["key"]]]}
    public static native Message eeeAccountInfoKey(String addr);

    /**
     * 解码从链上查询回来的账户信息
     *
     * @param encodeData 输入十六进制格式数据  ‘0x’
     * @return 若格式正确，返回status 200,Message中accountInfo字段包含详情，若格式错误，msg字段包含错误信息
     */
    public static native Message decodeAccountInfo(String encodeData);

    /*------------------------------------------交易相关------------------------------------------*/

    // Eth 交易签名。签名结果是：交易类型
    // 说明： gasPrice单位：gwei     gaslimit单位：gwei       （1 ETH = 1e9 gwei (10的九次方)）
    //       gasPrice 和 gasLimit 传值时， 传整数类型字符串。如：“1000”，非“100.0”
    //       链类型int: 3：正式链   4：测试链（Ropsten）,目前只使用这两种测试链
    public static native Message ethTxSign(String mnId, int chainType, String fromAddress, String toAddress, String contractAddress, String value,
                                           String backup, byte[] pwd, String gasPrice, String gasLimit, String nonce, int decimal);

    //ETH 交易拼装。   返回：未签名的交易 String。
    //nonce记录位置？？？
    public static native byte[] ethTxMakeETHRawTx(byte[] encodeMneByte, byte[] pwd, String fromAddress, String toAddress, String value,
                                                  String backupMsg, String gasLimit, String gasPrice);

    //ERC20 交易拼装。    返回：未签名的交易 String
    // nonce记录位置？？？
    public static native byte[] ethTxMakeERC20RawTx(byte[] encodeMneByte, byte[] pwd, String fromAddress, String contractAddress, String toAddress,
                                                    String value, String backupMsg, String gasLimit, String gasPrice);

    //处理建议优先考虑，实现spv的库处做。   能更方便获取utxo,还有找零地址选择,找零金额。
    public static native byte[] btcTxMakeBTCRawTx(String[] from, String[] to, String value);

    public static native byte[] btcTxSignTx(String rawTx, byte[] encodeMne, byte[] pwd);

    //广播交易，区分链类型
    //返回：广播成功1、 广播失败0
    public static native boolean ethTxBroascastTx(byte[] signedTx);

    public static native boolean btcTxBroascastTx(byte[] signedTx);

    /**
     * 更新地址对应代币的余额
     * @param address 链地址
     * @param digitId  代币id
     * @param balance 代币数量  传递进去的代币单位怎么来确定？
     * @return  更新钱包代币结果， 使用 isUpdateDigitBalance来标识操作结果
     */
    public static native WalletState updateDigitBalance(String address, String digitId, String balance);

    //解码交易附加信息
    public static native Message decodeAdditionData(String input);


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
//增加
//0x210584ff0a146e76bbdc381bd77bb55ec45c8bef5f52e2909114d632967683ec1eb4ea3001106acdf7d07a12186542cc4679a4c8c298c2ed2ad39862c64a3b0016bdb04a10feddba01a849861bd81b4c86ae2a0ec42d4cefd1120944a053d2bf5d09b6e2880000001102ffc7f0c7f2cbe69ddcdf62b2384973dd0e54c2ec547157f87aa722feb46be7b2c5000220bcbee10217041815000000000480764285227a94f0915d24b5c8477c952693d43e1671be6bf591122115d0184dbdefabc3e85f37f061183685d7a14551e491a6fd1a6cee99dfda48a8275ece850a146e76bbdc381bd77bb55ec45c8bef5f52e2909114d632967683ec1eb4ea30000000000000000000000000000000000000000000000000000000105cf5eed286eb8a1ab48bd5fed1a307bcdc3f56d3a81e38d93cbade67ccfe6808746573744e616d6500000000000000e8030000
// 删除
//0xd10484ff0a146e76bbdc381bd77bb55ec45c8bef5f52e2909114d632967683ec1eb4ea3001eee80fd8acfa5f3c2427a74c862c41fb11dcf1b04c262b6b1112c94f85bf614f31cc2a9a7ab7a67d793b54f7a4789a2772028f20d80ad6beb69701af5f8ab58a0004001102ffc7f0c7f2cbe69ddcdf62b2384973dd0e54c2ec547157f87aa722feb46be7b2c5000220bcbe9102591a0ac0010000000446586be0edb1e24e5c2cf9bd4f3f6a134cd83f7a5b1f94b1ac664304ef49775e2328d32c780cd168f35e9e0d5112f06294bf1dd88c94c4a9e36511a2068eb3820a146e76bbdc381bd77bb55ec45c8bef5f52e2909114d632967683ec1eb4ea3000000000000000000000000000000000000000000000000000000078c31562f5207d7796233f16214d17d272009f7a822d073e7417b5474ed6516b