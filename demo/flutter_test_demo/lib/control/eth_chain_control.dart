import 'package:wallets/chain_eth.dart';
import 'package:wallets/enums.dart';
import 'package:wallets/kits.dart';
import 'package:wallets/wallets.dart';
import 'package:wallets/wallets_c.dc.dart';

class EthChainControl {
  ChainEth chainEth;
  Wallet wallet;

  getTokenList(Wallet nowWallet) {
    List<EthChainToken> ethTokens = nowWallet.ethChain.tokens.data;
    // todo getTokenBalance(tokenName)
    // todo getTokenRate()
    // todo getTokenMoney()
    // token ---> Digit  todo rename
    // return tokenList;
  }

  String decodeAdditionData(String encodeData) {
    var dataObj = Wallets.mainIsolate().chainEth.decodeAdditionData(encodeData);
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  txSign(NetType netType, EthTransferPayload txPayload, NoCacheString password) {
    var dataObj = Wallets.mainIsolate().chainEth.txSign(netType, txPayload, password);
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  rawTxSign(NetType netType, EthRawTxPayload rawTxPayload, NoCacheString password) {
    var dataObj = Wallets.mainIsolate().chainEth.rawTxSign(netType, rawTxPayload, password);
    if (!dataObj.isSuccess()) {
      return null;
    }
    return dataObj.data1;
  }

  bool updateAuthTokenList(ArrayCEthChainTokenAuth authTokens) {
    var dataObj = Wallets.mainIsolate().chainEth.updateAuthTokenList(authTokens);
    if (!dataObj.isSuccess()) {
      return false;
    }
    return true;
  }

  updateDefaultTokenList(ArrayCEthChainTokenDefault defaultTokens) {
    var dataObj = Wallets.mainIsolate().chainEth.updateDefaultTokenList(defaultTokens);
    if (!dataObj.isSuccess()) {
      return false;
    }
    return true;
  }

  addNonAuthDigit(ArrayCEthChainTokenAuth tokens) {
    var dataObj = Wallets.mainIsolate().chainEth.addNonAuthDigit(tokens);
    if (!dataObj.isSuccess()) {
      return false;
    }
    return true;
  }
}
