package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import info.scry.scry_webview.ScryWebviewPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    ScryWebviewPlugin.registerWith(registry.registrarFor("info.scry.scry_webview.ScryWebviewPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
