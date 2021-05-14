import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_du_kc/flutter_du_kc.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_du_kc');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

//   test('getPlatformVersion', () async {
//     expect(await FlutterDuKc.platformVersion, '42');
//   });
}
