package info.scry.flutter_test_demo;

import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity implements Session.Callback {
    private final String QR_SCAN_WC_PROTOCOL_CHECK_METHOD = "qr_scan_and_wc_protocol_check";
    private final String APPROVE_LOGIN = "approveLogIn";
    File sessionDir = null;
    File sessionFile = null;
    OkHttpClient client = new OkHttpClient.Builder().pingInterval(1000, TimeUnit.MILLISECONDS).build();
    Moshi moshi = new Moshi.Builder().build();
    WCSession session = null;

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
                ScryLog.d(MainActivity.this, "sessionFile" + sessionFile.getAbsolutePath(), "---> not exist || " + isOk);
            } else {
                FileWriter fw = new FileWriter(sessionFile);
                fw.write("");
                fw.flush();
                fw.close();
                ScryLog.d(MainActivity.this, "sessionFile  exist is ok--->", sessionFile.getAbsolutePath());
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


    @Override
    public void onStatus(@NotNull Session.Status status) {
        ScryLog.d(MainActivity.this, "MainActivity Session.Status--->", status.toString());
        if (Session.Status.Connected.INSTANCE.equals(status)) {
            // 控制显示界面，并且 选择是否同意连接
            ScryLog.d(MainActivity.this, "MainActivity Session.Status.Connected", status.toString());
            mFlutterChannelResult.success("choose option");
        }
        if (Session.Status.Approved.INSTANCE.equals(status)) {
            ScryLog.d(MainActivity.this, "MainActivity Session.Status.Approved", status.toString());
        }
        if (Session.Status.Closed.INSTANCE.equals(status)) {
            ScryLog.d(MainActivity.this, "MainActivity Session.Status.Closed", status.toString());
        }
        if (Session.Status.Disconnected.INSTANCE.equals(status)) {
            ScryLog.d(MainActivity.this, "MainActivity Session.Status.Disconnected", status.toString());
        }
    }

    @Override
    public void onMethodCall(@NotNull Session.MethodCall methodCall) {
        ScryLog.d(MainActivity.this, "onMethodCall enter--->", methodCall.toString());
        String methodClsName = methodCall.getClass().getName();
        String SessionRequestName = Session.MethodCall.SessionRequest.class.getName();
        String SendTransactionName = Session.MethodCall.SendTransaction.class.getName();
        if (methodClsName.equals(SessionRequestName)) {
            ScryLog.d(MainActivity.this, "MainActivity onMethodCall  SessionRequestName--->", SessionRequestName.toString());
            List<String> list = new ArrayList<String>();
            list.add("0x04668Ec2f57cC15c381b461B9fEDaB5D451c8F7F");
            session.approve(list, 1);
        }
        if (methodClsName.equals(SendTransactionName)) {
            ScryLog.d(MainActivity.this, "MainActivity onMethodCall  SendTransactionName--->", SendTransactionName.toString());
            ((Session.MethodCall.SendTransaction) methodCall).getData();
            ((Session.MethodCall.SendTransaction) methodCall).getFrom();
            // session.approveRequest(methodCall.id(), "approveRequest");
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        ScryLog.d(MainActivity.this, "MainActivity --->", "enter destroy");
        session.kill();
    }

}
