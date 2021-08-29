#import "InstallPlugin.h"
#import <install_plugin/install_plugin-Swift.h>

@implementation InstallPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftInstallPlugin registerWithRegistrar:registrar];
}
@end
