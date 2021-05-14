#import "FlutterDuKcPlugin.h"
#import <du/DUEntry.h>

@interface FlutterDuKcPlugin ()
@property (nonatomic, strong) DUEntry *duEntry;
@property (nonatomic, copy) NSString *cdidStr;
@end

@implementation FlutterDuKcPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_du_kc"
            binaryMessenger:[registrar messenger]];
  FlutterDuKcPlugin* instance = [[FlutterDuKcPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"initWithCustomerID" isEqualToString:call.method]) {
      NSString *customerId = call.arguments[@"customerID"];
      _duEntry = [[DUEntry alloc] init];
      [_duEntry setCustomerId:customerId];
      result(nil);
  } else if ([@"getDeviceID" isEqualToString:call.method]) {
      if (_cdidStr.length > 0) {
          result(_cdidStr);
      }else {
          __weak typeof(FlutterDuKcPlugin) *ws = self;
          _duEntry.getDuDeviceIdBlock = ^(NSString *cdidStr) {
              ws.cdidStr = cdidStr;
              result(cdidStr);
          };
          [_duEntry run];
      }
  } else {
      result(FlutterMethodNotImplemented);
  }
}

@end
