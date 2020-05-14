import 'net_util.dart';

class ScryXNetUtil{
    doSomething()async{
      var paramObj ={"method":"state_getStorage","params":["0x26aa394eea5630e07c48ae0c9558cef7b99d880ec681799c0cf30e8886371da9de1e86a9a8c739864cf3cc5ec2bea59fd43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d"],"id":1,"jsonrpc":"2.0"};
      var resultinfo = await request("http://40.73.75.224:9933",formData: paramObj);
    }

    loadRuntimeVersion(){

    }

    loadGenesisHash(){

    }
}