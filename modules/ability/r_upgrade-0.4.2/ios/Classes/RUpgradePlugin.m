#import "RUpgradePlugin.h"
#import <r_upgrade/r_upgrade-Swift.h>

@implementation RUpgradePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftRUpgradePlugin registerWithRegistrar:registrar];
}
@end
