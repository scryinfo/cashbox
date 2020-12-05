package info.scry.wallets;

import android.Manifest;
import android.content.Context;
import android.os.Build;
import android.os.Bundle;
import android.content.Intent;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodCall;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

import info.scry.utils.ScryLog;
import info.scry.utils.Utils;

import com.allenliu.versionchecklib.v2.AllenVersionChecker;
import com.allenliu.versionchecklib.v2.builder.UIData;
import com.yzq.zxinglibrary.android.CaptureActivity;
import com.yzq.zxinglibrary.common.Constant;

public class MainActivity extends FlutterActivity {

    private static final String QR_SCAN_CHANNEL = "qr_scan_channel";
    private static final int REQUEST_CODE_QR_SCAN = 0;
    private MethodChannel.Result mFlutterChannelResult = null;
    private final String QR_SCAN_METHOD = "qr_scan_method";
    private final String APP_INFO_CHANNEL = "app_info_channel";
    private final String UPGRADE_APP_METHOD = "upgrade_app_method";
    private final String APP_SIGNINFO_METHOD = "app_signinfo_method";


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {//API>21, Set the status bar color transparent
            getWindow().setStatusBarColor(0);
        }
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), QR_SCAN_CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            // Your existing code
                            if (call.method.toString().equals(QR_SCAN_METHOD)) {
                                mFlutterChannelResult = result;
                                Intent intent = new Intent(MainActivity.this, CaptureActivity.class);
                                startActivityForResult(intent, REQUEST_CODE_QR_SCAN);
                            }
                        }
                );


        //Notification of version upgrade at flutter
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), APP_INFO_CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.toString().equals(APP_SIGNINFO_METHOD)) {
                                try {
                                    mFlutterChannelResult = result;
                                    String signInfo = Utils.md5(Utils.getSignature(MainActivity.this));
                                    mFlutterChannelResult.success(signInfo);
                                } catch (Exception e) {
                                    ScryLog.e("APP_SIGNINFO_METHOD appear error", e.toString());
                                    mFlutterChannelResult.success("");
                                }
                            } else if (call.method.toString().equals(UPGRADE_APP_METHOD)) {
                                String downloadurl = call.argument("downloadurl");
                                String serverVersion = call.argument("serverVersion");
                                try {
                                    checkAndUpgradeVersion(downloadurl, serverVersion);
                                } catch (Exception e) {
                                    ScryLog.e("checkApplicationVersion appear error", e.toString());
                                }
                            } else {
                                ScryLog.e("APP_INFO_CHANNEL===>", "Unknown method");
                            }
                        }
                );
    }


    private void checkAndUpgradeVersion(String loadUrl, String serverVersion) {
        ScryLog.v("begin to checkAndUpgradeVersion================>", loadUrl);
        /*
            https://github.com/AlexLiuSheng/CheckVersionLib
            */
        AllenVersionChecker
                .getInstance()
                .downloadOnly(
                        UIData.create().setTitle(getString(R.string.new_version_title)).setContent(getString(R.string.search_new_version) + serverVersion + getString(R.string.search_new_version_end)).setDownloadUrl(loadUrl)
                )
                .executeMission(MainActivity.this);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        // Scan QR code/Barcode return
        if (requestCode == REQUEST_CODE_QR_SCAN) {
            if (data != null && resultCode == RESULT_OK) {
                String scanResultString = data.getStringExtra(Constant.CODED_CONTENT);
                if (scanResultString == null) {
                    scanResultString = "";
                }
                mFlutterChannelResult.success(scanResultString);
            } else {
                mFlutterChannelResult.error("resultCode is ===>", "" + resultCode, "");
            }
        } else {
            ScryLog.e("MainActivity", "unknown method result, requestCode is=========>" + requestCode);
        }
    }
}
