package info.scry.scry_webview;

import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugin.common.PluginRegistry;
import android.content.Intent;
import android.app.Activity;
import android.content.Context;
import info.scry.scry_webview.FlutterWebView;  //parker flutter ventor chagne 10/14
import android.content.Intent;
import android.net.Uri;

/** ScryWebviewPlugin */
public class ScryWebviewPlugin implements PluginRegistry.ActivityResultListener{
  /** Plugin registration. */
  private Activity activity;
  private Context context;

  //add for file
  // private ValueCallback<Uri> mUploadMessage;
  // private ValueCallback<Uri[]> mUploadMessageArray;
  private final static int FILECHOOSER_RESULTCODE=1;
  // private Uri fileUri;
  // private Uri videoUri;
  private static WebViewFactory factory;

  private WebViewFactory factory2;
  public static void registerWith(Registrar registrar) {
    factory = new WebViewFactory(registrar.messenger(), registrar.view());
    registrar
            .platformViewRegistry()
            .registerViewFactory(
                    "plugins.flutter.io/webview",
                    factory);

    final ScryWebviewPlugin instance = new ScryWebviewPlugin(registrar.activity(),registrar.activeContext());
    registrar.addActivityResultListener(instance);
    FlutterCookieManager.registerWith(registrar.messenger());
  }

  private ScryWebviewPlugin(Activity activity, Context context){
    this.activity = activity;
    this.context = context;
  }

  @Override
  public boolean onActivityResult(int i, int i1, Intent intent) {

    if(factory!=null){
      factory2 = factory;
      System.out.println(factory2.getFlutterWebView() != null);
      if (factory2.getFlutterWebView() != null) {
        return factory2.getFlutterWebView().resultHandler.handleResult(i, i1, intent);
      }
      return false;
    }else{
      WebViewFactory flutterWebViewFactory = new WebViewFactory(null,null);
      if(flutterWebViewFactory!=null){
        return flutterWebViewFactory.getFlutterWebView().resultHandler.handleResult(i, i1, intent);
      }
      return false;
    }

  }
}

