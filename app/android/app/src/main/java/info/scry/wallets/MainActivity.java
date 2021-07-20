package info.scry.wallets;

import android.os.Build;
import android.os.Bundle;
import android.content.Intent;
import android.os.Environment;

import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugins.GeneratedPluginRegistrant;

import info.scry.utils.ScryLog;
import info.scry.utils.Utils;
import okhttp3.OkHttpClient;

import com.allenliu.versionchecklib.v2.AllenVersionChecker;
import com.allenliu.versionchecklib.v2.builder.UIData;
import com.squareup.moshi.Json;
import com.squareup.moshi.Moshi;
import com.yzq.zxinglibrary.android.CaptureActivity;
import com.yzq.zxinglibrary.common.Constant;

import org.jetbrains.annotations.NotNull;
import org.json.JSONArray;
import org.json.JSONObject;
import org.walletconnect.Session;
import org.walletconnect.impls.*;
import org.walletconnect.impls.WCSession;

import java.io.File;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

public class MainActivity extends FlutterActivity implements Session.Callback {
    private final int REQUEST_CODE_QR_SCAN = 0;
    private final String QR_SCAN_METHOD = "qr_scan_method";
    private final String UPGRADE_APP_METHOD = "upgrade_app_method";
    private final String APP_SIGNINFO_METHOD = "app_signinfo_method";
    private final String INIT_SESSION_METHOD = "initSession";
    private final String APPROVE_LOGIN_METHOD = "approveLogIn";
    private final String REJECT_LOGIN_METHOD = "rejectLogIn";
    private final String APPROVE_TX_METHOD = "approveTx";
    private MethodChannel.Result mFlutterChannelResult = null;
    private MethodChannel.Result wcStateChannelResult = null;
    private MethodChannel.Result wcApproveChannelResult = null;
    private MethodChannel.Result wcDisconnectChannelResult = null;
    private EventChannel.EventSink eventSink = null;
    private EventChannel.EventSink sessionEventSink = null;

    File sessionDir = null;
    File sessionFile = null;
    OkHttpClient client = new OkHttpClient.Builder().pingInterval(1000, TimeUnit.MILLISECONDS).build();
    Moshi moshi = new Moshi.Builder().build();
    WCSession session = null;
    MethodChannel wcChannel = null;
    EventChannel wcEventChannel = null;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {//API>21, Set the status bar color transparent
            getWindow().setStatusBarColor(0);
        }
        File dirPath = MainActivity.this.getExternalCacheDir();
        String WC_PROTOCOL_PATH = "wc_protocol/session";
        this.sessionDir = new File(dirPath + File.separator + WC_PROTOCOL_PATH);

    }

    private void doConnectProcedure(String qrUrlInfo) {
        ScryLog.d(MainActivity.this, "doConnectProcedure", qrUrlInfo);
        try {
            if (!sessionDir.exists()) {
                boolean isOk = sessionDir.mkdirs();
                ScryLog.d(MainActivity.this, "sessionDir", "not exist ||" + isOk);
            } else {
                ScryLog.d(MainActivity.this, "sessionDir exist is ok---> ", sessionDir.getAbsolutePath());
            }
            sessionFile = new File(sessionDir, "store.json");
            if (!sessionFile.exists()) {
                boolean isOk = sessionFile.createNewFile();
            } else {
                FileWriter fw = new FileWriter(sessionFile);
                fw.write("");
                fw.flush();
                fw.close();
            }
        } catch (Exception e) {
            ScryLog.d(MainActivity.this, "Exception", "err ||" + e);
        }
        FileWCSessionStore sessionStore = new FileWCSessionStore(sessionFile, moshi);
        Session.Config config = Session.Config.Companion.fromWCUri(qrUrlInfo);
        session = new WCSession(
                config,
                new MoshiPayloadAdapter(moshi),
                sessionStore,
                new OkHttpTransport.Builder(client, moshi),
                new WCSession.PeerMeta().copy(null, "ddd_topic", null, null), UUID.randomUUID().toString()
        );
        session.addCallback(this);
        session.init();
    }

    Session.Callback callback = null;

    String handleResponse(Session.MethodCall.Response resp) {
        return "";
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        String WC_PROTOCOL_CHANNEL = "wc_protocol_channel";
        wcChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), WC_PROTOCOL_CHANNEL);

        wcChannel.setMethodCallHandler(
                (call, result) -> {
                    if (call.method.toString().equals(INIT_SESSION_METHOD)) {
                        wcStateChannelResult = result;
                        doConnectProcedure(call.argument("qrInfo"));
                    }
                    if (call.method.toString().equals(APPROVE_LOGIN_METHOD)) {
                        ScryLog.d(this, "APPROVE_LOGIN_METHOD", call.argument("addr").toString());
                        wcApproveChannelResult = result;
                        List<String> addrList = new ArrayList<>();
                        addrList.add(call.argument("addr"));
                        if ("EthTest".equals(call.argument("chainType").toString())) {
                            session.approve(addrList, 3); //  3:rspton, 1:mainnet
                        } else {
                            session.approve(addrList, 1); //  3:rspton, 1:mainnet
                        }

                    }
                    if (call.method.toString().equals(REJECT_LOGIN_METHOD)) {
                        if (session == null) {
                            return;
                        }
                        ScryLog.d(this, "REJECT_LOGIN_METHOD--->", call.toString());
                        wcDisconnectChannelResult = result;
                        runOnUiThread(
                                new Runnable() {
                                    @Override
                                    public void run() {
                                        session.kill();
                                        session = null;
                                    }
                                }
                        );
                    }
                    if (call.method.toString().equals(APPROVE_TX_METHOD)) {
                        ScryLog.d(this, "call.method is ", APPROVE_TX_METHOD);
                        ScryLog.d(this, "long ID is ", Long.parseLong(call.argument("id")));
                        ScryLog.d(this, "data is ", call.argument("data"));
                        runOnUiThread(
                                new Runnable() {
                                    @Override
                                    public void run() {
                                        ScryLog.d(MainActivity.this, "approveRequest :", call.argument("data"));
                                        session.approveRequest(Long.parseLong(call.argument("id")), call.argument("data"));
                                    }
                                }
                        );
                    }
                }
        );
        String WC_EVENT_PROTOCOL_CHANNEL = "wc_event_protocol_channel";
        new EventChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), WC_EVENT_PROTOCOL_CHANNEL).setStreamHandler(new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object arguments, EventChannel.EventSink events) {
                eventSink = events;
            }

            @Override
            public void onCancel(Object arguments) {
            }
        });
        String WC_SESSION_INFO_CHANNEL = "wc_session_info_channel";
        new EventChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), WC_SESSION_INFO_CHANNEL).setStreamHandler(new EventChannel.StreamHandler() {
            @Override
            public void onListen(Object arguments, EventChannel.EventSink events) {
                sessionEventSink = events;
            }

            @Override
            public void onCancel(Object arguments) {
            }
        });
        String QR_SCAN_CHANNEL = "qr_scan_channel";
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

        // Notification of version upgrade at flutter
        String APP_INFO_CHANNEL = "app_info_channel";
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), APP_INFO_CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.toString().equals(APP_SIGNINFO_METHOD)) {
                                try {
                                    mFlutterChannelResult = result;
                                    String signInfo = Utils.md5(Utils.getSignature(MainActivity.this));
                                    mFlutterChannelResult.success(signInfo);
                                } catch (Exception e) {
                                    ScryLog.e(this, "APP_SIGNINFO_METHOD appear error", e.toString());
                                    mFlutterChannelResult.success("");
                                }
                            } else if (call.method.toString().equals(UPGRADE_APP_METHOD)) {
                                String downloadurl = call.argument("downloadurl");
                                String serverVersion = call.argument("serverVersion");
                                try {
                                    checkAndUpgradeVersion(downloadurl, serverVersion);
                                } catch (Exception e) {
                                    ScryLog.e(this, "checkApplicationVersion appear error", e.toString());
                                }
                            } else {
                                ScryLog.e(this, "APP_INFO_CHANNEL===>", "Unknown method");
                            }
                        }
                );
    }


    private void checkAndUpgradeVersion(String loadUrl, String serverVersion) {
        /*
            https://github.com/AlexLiuSheng/CheckVersionLib
            */
        String targetVersionUrl = loadUrl + "?apkVersion=" + serverVersion;
        ScryLog.v(this, "targetVersionUrl is ================>", targetVersionUrl);
        try {
            AllenVersionChecker
                    .getInstance()
                    .downloadOnly(
                            UIData.create().setTitle(getString(R.string.new_version_title)).setContent(getString(R.string.search_new_version) + serverVersion + getString(R.string.search_new_version_end)).setDownloadUrl(targetVersionUrl)
                    )
                    .setDownloadAPKPath(this.getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS).getPath() + "/")
                    .executeMission(MainActivity.this);
        } catch (Exception e) {
            ScryLog.e(this, "checkAndUpgradeVersion appear error", e.toString());
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
            ScryLog.e(this, "MainActivity", "unknown method result, requestCode is=========>" + requestCode);
        }
    }

    @Override
    public void onStatus(@NotNull Session.Status status) {
        ScryLog.d(MainActivity.this, "MainActivity Session.Status--->", status.toString());
        if (Session.Status.Connected.INSTANCE.equals(status)) {
            // 控制显示界面，并且 选择是否同意连接
            ScryLog.d(MainActivity.this, "MainActivity Session.Status.Connected", status.toString());
            runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    wcStateChannelResult.success("Connected");
                }
            });
        }
        if (Session.Status.Approved.INSTANCE.equals(status)) {
            ScryLog.d(MainActivity.this, "MainActivity Session.Status.Approved", status.toString());
            runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    wcApproveChannelResult.success("Approved");
                }
            });
        }
        if (Session.Status.Closed.INSTANCE.equals(status)) {
            ScryLog.d(MainActivity.this, "MainActivity Session.Status.Closed", status.toString());
        }
        if (Session.Status.Disconnected.INSTANCE.equals(status)) {
            ScryLog.d(MainActivity.this, "MainActivity Session.Status.Disconnected", status.toString());
            if (wcDisconnectChannelResult == null) {
                ScryLog.e(MainActivity.this, "wcDisconnectChannelResult is null ", "||");
            } else {
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        ScryLog.d(MainActivity.this, "wcDisconnectChannelResult is --> ", "Disconnected");
                        wcDisconnectChannelResult.success("Disconnected");
                    }
                });
            }
        }
        try {
            ScryLog.d(MainActivity.this, "wcDisconnectChannelResult unknown --> ", status.toString());
        } catch (Exception e) {
            ScryLog.d(MainActivity.this, "wcDisconnectChannelResult unknown is --> ", status.toString());
        }
    }

    @Override
    public void onMethodCall(@NotNull Session.MethodCall methodCall) {
        String methodClsName = methodCall.getClass().getName();
        String SessionRequestName = Session.MethodCall.SessionRequest.class.getName();
        String SendTransactionName = Session.MethodCall.SendTransaction.class.getName();
        if (methodClsName.equals(SessionRequestName)) {
            Map<String, Object> dataMap = new HashMap<>();
            Session.PeerMeta peerMeta = ((Session.MethodCall.SessionRequest) methodCall).component2().getMeta();
            if (peerMeta.getIcons().size() > 0) {
                dataMap.put("iconUrl", peerMeta.getIcons().get(0));
            }
            dataMap.put("name", peerMeta.getName());
            dataMap.put("url", peerMeta.getUrl());
            try {
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        sessionEventSink.success(dataMap);
                    }
                });
            } catch (Exception e) {
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        sessionEventSink.error("500", e.toString(), "");
                    }
                });
            }
        }
        if (methodClsName.equals(SendTransactionName)) {
            try {
                Map<String, Object> dataMap = new HashMap<>();
                dataMap.put("from", ((Session.MethodCall.SendTransaction) methodCall).getFrom());
                dataMap.put("to", ((Session.MethodCall.SendTransaction) methodCall).getTo());
                dataMap.put("id", ((Session.MethodCall.SendTransaction) methodCall).getId());
                dataMap.put("data", ((Session.MethodCall.SendTransaction) methodCall).getData());
                dataMap.put("value", ((Session.MethodCall.SendTransaction) methodCall).getValue());
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        eventSink.success(dataMap);
                    }
                });
            } catch (Exception e) {
                ScryLog.d(MainActivity.this, "Android SendTransaction error ", e.toString());
                mFlutterChannelResult.success("error");
            }
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        ScryLog.d(MainActivity.this, "MainActivity --->", "enter destroy!!!!!!");
        if (session != null) {
            session.kill();
        }
    }
}
