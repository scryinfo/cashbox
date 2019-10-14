// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package info.scry.scry_webview;  // vendor change parker 10/14

import android.content.Context;
import android.view.View;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;
import java.util.Map;
import io.flutter.plugin.common.PluginRegistry;
import android.content.Intent;

public final class WebViewFactory extends PlatformViewFactory {
  private final BinaryMessenger messenger;
  private final View containerView;
  private FlutterWebView flutter;

  WebViewFactory(BinaryMessenger messenger, View containerView) {
    super(StandardMessageCodec.INSTANCE);
    this.messenger = messenger;
    this.containerView = containerView;
  }
  // WebViewFactory(){}

  @SuppressWarnings("unchecked")
  @Override
  public PlatformView create(Context context, int id, Object args) {
    Map<String, Object> params = (Map<String, Object>) args;
    flutter = new FlutterWebView(context, messenger, id, params, containerView);
    return flutter;
    // return new FlutterWebView(context, messenger, id, params, containerView);
  }

  public FlutterWebView getFlutterWebView(){
    return this.flutter;
  }
}
