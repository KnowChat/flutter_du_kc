
import 'dart:async';

import 'package:flutter/services.dart';

class FlutterDuKc {
  static const MethodChannel _channel =
      const MethodChannel('flutter_du_kc');

  //初始化要尽早，用于上报设备相关信息进行匹配
  static Future<void> initWithCustomerID(String customerID) async {
    await _channel.invokeMethod('initWithCustomerID', {"customerID":customerID});
  }

  //异步获取数盟id，msg1和msg2可传渠道号和用户id等自定义信息
  static Future<String> getDuDeviceID(String msg1, String msg2) async {
    final String deviceID = await _channel.invokeMethod('getDeviceID', {"msg1":msg1 ?? "","msg2":msg2 ?? ""});
    return deviceID;
  }
}
