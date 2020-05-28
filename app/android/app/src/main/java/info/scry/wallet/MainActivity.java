package info.scry.wallet;

import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.content.Intent;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import com.allenliu.versionchecklib.v2.callback.CustomDownloadingDialogListener;

import android.widget.ProgressBar;
import android.widget.RadioGroup;
import android.widget.TextView;

import info.scry.utils.ScryLog;
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

import static java.lang.System.out;

public class MainActivity extends FlutterActivity {

    private static final String QR_SCAN_CHANNEL = "qr_scan_channel";
    private static final String FILE_SYSTEM_CHANNEL = "file_system_channel";
    private static final int REQUEST_CODE_QR_SCAN = 0;
    private static final int REQUEST_CODE_FILE_SYSTEM = 1;
    private Result mFlutterChannelResult = null;
    private final String QR_SCAN_METHOD = "qr_scan_method";
    private final String FILE_SYSTEM_METHOD = "file_system_method";
    private final String CHARGING_CHANNEL = "samples.flutter.io/charging";
    private final String FLUTTER_LOG_CHANNEL = "android_log_channel";
    private final String UPGRADE_APP_CHANNEL = "upgrade_app_channel";
    private final String UPGRADE_APP_METHOD = "upgrade_app_method";
    Context context;

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
                                    mFlutterChannelResult = result;
                                    Intent intent = new Intent(MainActivity.this,
                                            CaptureActivity.class);
                                    startActivityForResult(intent, REQUEST_CODE_QR_SCAN);
                                }
                            }
                        }
                );
        //flutter处 log日志保存
        new MethodChannel(getFlutterView(), FLUTTER_LOG_CHANNEL)
                .setMethodCallHandler(
                        new MethodCallHandler() {
                            @Override
                            public void onMethodCall(MethodCall call, Result result) {
                                logPrint(call);
                            }
                        }
                );

        //flutter处 通知版本升级
        new MethodChannel(getFlutterView(), UPGRADE_APP_CHANNEL)
                .setMethodCallHandler(
                        new MethodCallHandler() {
                            @Override
                            public void onMethodCall(MethodCall call, Result result) {
                                String downloadurl = call.argument("downloadurl");
                                String serverVersion = call.argument("serverVersion");
                                if (call.method.toString().equals(UPGRADE_APP_METHOD)) {
                                    try {
                                        checkAndUpgradeVersion(downloadurl, serverVersion);  //todo 待验证，暂不放开
                                    } catch (Exception e) {
                                        ScryLog.e("checkApplicationVersion appear error", e.toString());
                                    }
                                } else {
                                    ScryLog.e("call.method.toString() not equal===>", call.method.toString());
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

    private void checkAndUpgradeVersion(String loadUrl, String serverVersion) {
        ScryLog.v("begin to checkAndUpgradeVersion================>", loadUrl);
        double nowVersion = getNowVersionCode(this);
        /*
            https://github.com/AlexLiuSheng/CheckVersionLib
            */
        AllenVersionChecker
                .getInstance()
                .downloadOnly(
                        UIData.create().setTitle(getString(R.string.new_version_title)).setContent(getString(R.string.search_new_version) + serverVersion + getString(R.string.search_new_version_end)).setDownloadUrl(loadUrl)
                )
                .executeMission(MainActivity.this);
        /*
        String versionUrl = "http://192.168.1.3:8080/checkVersion"; //todo
        String downloadUrl = "http://192.168.1.3:8080/downloadApk"; //todo
        AllenVersionChecker
                .getInstance()
                .requestVersion()
                .setRequestUrl(versionUrl)
                .request(new RequestVersionListener() {
                    @Nullable
                    @Override
                    public UIData onRequestVersionSuccess(DownloadBuilder downloadBuilder, String result) {
                        downloadBuilder.setCustomDownloadingDialogListener(new CustomDownloadingDialogListener() {
                            @Override
                            public Dialog getCustomDownloadingDialog(Context context, int progress, UIData versionBundle) {
                                BaseDialog baseDialog = new BaseDialog(context, R.style.BaseDialog, R.layout.custom_download_layout);
                                return baseDialog;
                            }

                            @Override
                            public void updateUI(Dialog dialog, int progress, UIData versionBundle) {
                                TextView tvProgress = dialog.findViewById(R.id.tv_progress);
                                ProgressBar progressBar = dialog.findViewById(R.id.pb);
                                progressBar.setProgress(progress);
                                tvProgress.setText(getString(R.string.versionchecklib_progress, progress));
                            }
                        });
                        try {
                            Gson gs = new Gson();
                            AppVersionModel jsonObject = gs.fromJson(result, AppVersionModel.class);
                            int statusCode = jsonObject.getCode(); //todo
                            double serverVersion = jsonObject.getVersion();
                            if (statusCode == AppVersionModel.Success) {
                                if (serverVersion > nowVersion) {
                                    //执行下载更新
                                    ScryLog.v("begin to setDownloadUrl================>", downloadUrl);
                                    return UIData.create().setTitle("新版本升级提示").setContent("检测到新版本：" + serverVersion + "，点击确认即可更新体验新版本特性")
                                            .setDownloadUrl(downloadUrl);
                                }
                            } else {
                                //todo 服务器没有正常返回 提示
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                            ScryLog.v("JSONException e================>", e.toString());
                        }
                        return null;
                    }

                    @Override
                    public void onRequestVersionFailure(String message) {
                        ScryLog.v("onRequestVersionFailure message================>", message.toString());
                    }
                })
                .executeMission(MainActivity.this);*/
    }

    private double getNowVersionCode(Context context) {
        double nowVersion = 0;
        try {
            PackageManager packageManager = context.getPackageManager();
            PackageInfo packInfo = packageManager.getPackageInfo(context.getPackageName(), 0);
            nowVersion = packInfo.versionCode;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return nowVersion;
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
        // 扫描二维码/条码回传
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
