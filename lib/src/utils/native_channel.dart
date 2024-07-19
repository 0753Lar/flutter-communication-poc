import 'dart:convert';

import 'package:flutter/services.dart';

class NativeChannel {
  static const _channel = MethodChannel('samples.flutter.dev/channel');

  static Future<void> renderSection(Map<String, dynamic> map) async {
    var params = jsonEncode(map);
    try {
      await _channel.invokeMethod('renderSection', params);
    } on PlatformException catch (e) {
      print("Failed to render section: '${e.message}'.");
    }
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
