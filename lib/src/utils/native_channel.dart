import 'dart:convert';

import 'package:flutter/services.dart';

class NativeChannel {
  static const channel = MethodChannel('samples.flutter.dev/ios');
  static Future<String> getBatteryLevel() async {
    String batteryLevel;
    try {
      final result = await channel.invokeMethod<int>('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
    return batteryLevel;
  }

  static Future<void> renderSection(Map<String, dynamic> map) async {
    var params = jsonEncode(map);
    try {
      await channel.invokeMethod('renderSection', params);
    } on PlatformException catch (e) {
      print("Failed to render section: '${e.message}'.");
    }
  }
}
