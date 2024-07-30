import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class NativeChannel {
  static const _channel = MethodChannel('samples.flutter.dev/channel');

  static Future<void> renderSection(Map<String, dynamic> map) async {
    var params = jsonEncode(map);
    try {
      await _channel.invokeMethod('renderSection', params);
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to render section: '${e.message}'.");
      }
    }
  }

  static Future<String> getBatteryLevel() async {
    String batteryLevel;
    try {
      final result = await _channel.invokeMethod<int>('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
      if (kDebugMode) {
        print("Failed to getBatteryLevel: '${e.message}'.");
      }
    }
    return batteryLevel;
  }

  static Future<void> onReceiveDialogCallFromNative(
      Function(String) onDataReceived) async {
    _channel.setMethodCallHandler((call) async {
      if (call.method == "showDialog") {
        final String data = call.arguments;
        onDataReceived(data);
      }
    });
  }
}
