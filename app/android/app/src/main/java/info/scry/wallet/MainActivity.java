package info.scry.wallet;

import android.os.Build;
import android.os.Bundle;
import android.content.Intent;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.view.FlutterView;

import android.util.Log;

import com.yzq.zxinglibrary.android.CaptureActivity;
import com.yzq.zxinglibrary.common.Constant;

public class MainActivity extends FlutterActivity {

    private static final String QR_SCAN_CHANNEL = "qr_scan_channel";
    private static final int REQUEST_CODE_QR_SCAN = 0;
    private Result mQRScanResult = null;
    private final String QR_SCAN_METHOD = "qr_scan_method";
    private final String CHARGING_CHANNEL = "samples.flutter.io/charging";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {//API>21,设置状态栏颜色透明
            getWindow().setStatusBarColor(0);
        }
        GeneratedPluginRegistrant.registerWith(this);

        new MethodChannel(getFlutterView(), QR_SCAN_CHANNEL)
                .setMethodCallHandler(
                        new MethodCallHandler() {
                            @Override
                            public void onMethodCall(MethodCall call, Result result) {
                                if (call.method.toString().equals(QR_SCAN_METHOD)) {
                                    mQRScanResult = result;
                                    Intent intent = new Intent(MainActivity.this, CaptureActivity.class);
                                    startActivityForResult(intent, REQUEST_CODE_QR_SCAN);
                                }
                            }
                        }
                );

        // TODO: 2019/8/19 parker     EventChannel test code
        //  native端，主动通知到 flutter
        new EventChannel(getFlutterView(), CHARGING_CHANNEL).setStreamHandler(
                new EventChannel.StreamHandler() {
                    @Override
                    public void onListen(Object o, EventChannel.EventSink eventSink) {
                        //todo something
                        eventSink.success(o);
                        eventSink.error("error", "something is error", o);
                        // errors参数：
                        // this.code,
                        // this.message,
                        // this.details
                    }

                    @Override
                    public void onCancel(Object o) {

                    }
                }
        );
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        // 扫描二维码/条码回传
        if (requestCode == REQUEST_CODE_QR_SCAN) {
            if (data != null && resultCode == RESULT_OK) {
                String scanResultString = data.getStringExtra(Constant.CODED_CONTENT);
                mQRScanResult.success(scanResultString);
            } else {
                mQRScanResult.error("there is something wrong,data is ===>", data.toString(), "");
            }
        } else {
            Log.d("MainActivity", "unknown method result,requestCode is===>" + requestCode);
        }
    }
}
