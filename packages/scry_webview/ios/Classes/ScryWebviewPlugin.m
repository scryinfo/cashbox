#import "ScryWebviewPlugin.h"
#import <scry_webview/scry_webview-Swift.h>

@implementation ScryWebviewPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftScryWebviewPlugin registerWithRegistrar:registrar];
}
@end
