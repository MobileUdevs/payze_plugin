#import "PayzePlugin.h"
#if __has_include(<payze_plugin/payze_plugin-Swift.h>)
#import <payze_plugin/payze_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "payze_plugin-Swift.h"
#endif

@implementation PayzePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPayzePlugin registerWithRegistrar:registrar];
}
@end
