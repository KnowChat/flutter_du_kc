import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_du_kc/flutter_du_kc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _deviceID = 'unknown';

  @override
  void initState() {
    super.initState();
    initDeviceIDState();
  }

  Future<void> initDeviceIDState() async {
    try {
      await FlutterDuKc.initWithCustomerID("zhiliao_shuzilm_cn");
    }on PlatformException {
      print("Failed to init du sdk");
    }
  }
  
  Future<void> getDeviceID() async {
    String deviceID;
    try {
      deviceID = await FlutterDuKc.getDuDeviceID("1", "2");
    } on PlatformException {
      deviceID = 'Failed to get deviceid.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    
    setState(() {
      _deviceID = deviceID;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('DeviceID: $_deviceID\n'),
            IconButton(icon: Icon(Icons.get_app), onPressed: getDeviceID),
          ],
        ),
      ),
    );
  }
}
