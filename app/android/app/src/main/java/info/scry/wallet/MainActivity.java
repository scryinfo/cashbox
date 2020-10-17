package info.scry.wallet;

import android.Manifest;
import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.content.Intent;
import android.Manifest.permission;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import com.allenliu.versionchecklib.v2.callback.CustomDownloadingDialogListener;

import android.util.Log;
import android.widget.ProgressBar;
import android.widget.RadioGroup;
import android.widget.TextView;

import info.scry.utils.ScryLog;
import info.scry.utils.Utils;
import info.scry.ui.BaseDialog;

import android.app.Dialog;

import info.scry.model.AppVersionModel;

import androidx.annotation.Nullable;

import com.allenliu.versionchecklib.v2.AllenVersionChecker;
import com.allenliu.versionchecklib.v2.builder.DownloadBuilder;
import com.allenliu.versionchecklib.v2.builder.UIData;
import com.allenliu.versionchecklib.v2.callback.RequestVersionListener;
import com.yzq.zxinglibrary.android.CaptureActivity;
import com.yzq.zxinglibrary.common.Constant;

import com.google.gson.Gson;

import androidx.core.app.ActivityCompat;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;

import android.content.pm.PackageManager;
import android.content.pm.PermissionInfo;
import android.widget.Toast;

import static android.content.pm.PackageManager.PERMISSION_GRANTED;
import static java.lang.System.out;

public class MainActivity extends FlutterActivity {

    private static final String QR_SCAN_CHANNEL = "qr_scan_channel";
    private static final String FILE_SYSTEM_CHANNEL = "file_system_channel";
    private static final int REQUEST_CODE_QR_SCAN = 0;
    private static final int REQUEST_CODE_FILE_SYSTEM = 1;
    private static final int CAMERA_AND_FILE_PERMISSION_REQ_CODE = 2;
    private Result mFlutterChannelResult = null;
    private final String QR_SCAN_METHOD = "qr_scan_method";
    private final String FILE_SYSTEM_METHOD = "file_system_method";
    private final String CHARGING_CHANNEL = "samples.flutter.io/charging";
    private final String FLUTTER_LOG_CHANNEL = "android_log_channel";
    private final String APP_INFO_CHANNEL = "app_info_channel";
    private final String UPGRADE_APP_METHOD = "upgrade_app_method";
    private final String APP_SIGNINFO_METHOD = "app_signinfo_method";
    Context context;
    private final String[] PERMISSION_LIST = new String[]{Manifest.permission.CAMERA, Manifest.permission.READ_EXTERNAL_STORAGE};

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {//API>21, Set the status bar color transparent
            getWindow().setStatusBarColor(0);
        }
        GeneratedPluginRegistrant.registerWith(this);

        new MethodChannel(getFlutterView(), QR_SCAN_CHANNEL)
                .setMethodCallHandler(
                        new MethodCallHandler() {
                            @Override
                            public void onMethodCall(MethodCall call, Result result) {
                                if (call.method.toString().equals(QR_SCAN_METHOD)) {
                                    mFlutterChannelResult = result;
                                    Intent intent = new Intent(MainActivity.this, CaptureActivity.class);
                                    startActivityForResult(intent, REQUEST_CODE_QR_SCAN);
                                }
                            }
                        }
                );
        //Log storage at flutter
        new MethodChannel(getFlutterView(), FLUTTER_LOG_CHANNEL)
                .setMethodCallHandler(
                        new MethodCallHandler() {
                            @Override
                            public void onMethodCall(MethodCall call, Result result) {
                                logPrint(call);
                            }
                        }
                );

        //Notification of version upgrade at flutter
        new MethodChannel(getFlutterView(), APP_INFO_CHANNEL)
                .setMethodCallHandler(
                        new MethodCallHandler() {
                            @Override
                            public void onMethodCall(MethodCall call, Result result) {
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
                        }
                );

        //  EventChannel test code
        //  native end, proactive notification to flutter
        new EventChannel(getFlutterView(), CHARGING_CHANNEL).setStreamHandler(
                new EventChannel.StreamHandler() {
                    @Override
                    public void onListen(Object o, EventChannel.EventSink eventSink) {
                        //todo something
                        eventSink.success(o);
                        eventSink.error("error", "something is error", o);
                        // Error parameters:
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

    private void logPrint(MethodCall call) {
        String tag = call.argument("tag");
        String message = call.argument("msg");
        switch (call.method) {
            case "logV":
                ScryLog.v(tag, message);
                break;
            case "logD":
                ScryLog.d(tag, message);
                break;
            case "logI":
                ScryLog.i(tag, message);
                break;
            case "logW":
                ScryLog.w(tag, message);
                break;
            case "logE":
                ScryLog.e(tag, message);
                break;
        }
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
