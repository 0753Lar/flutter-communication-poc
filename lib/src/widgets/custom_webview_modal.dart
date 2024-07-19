import 'dart:convert';

import 'package:dashboard/src/widgets/showCustomDialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebviewModal extends ChangeNotifier {
  final WebViewController _webviewController;
  final Function _setWebviewVisible;
  final BuildContext _context;

  static const jsChannel = "CUSTOM_JS_CHANNEL";

  CustomWebviewModal(
    this._webviewController,
    this._setWebviewVisible,
    this._context,
  );

  void promptToExit() {
    showCustomDialog(
        context: _context,
        onPressed: () {
          _webviewController.removeJavaScriptChannel(jsChannel);
          _setWebviewVisible(false);
        });
  }

  void renderBaseapp(String url, Map<String, dynamic>? params) async {
    try {
      _setWebviewVisible(true);
      await _webviewController.setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (error) {
            if (kDebugMode) {
              print("onWebResourceError");
              print(error);
            }
            promptToExit();
          },
          onHttpError: (error) {
            if (kDebugMode) {
              print("onHttpError");
              print(error);
              print(error);
            }
          },
          onPageFinished: (String url) {
            String json = jsonEncode(params);
            if (kDebugMode) {
              print("renderBaseapp($json)");
            }
            _webviewController.runJavaScript("renderBaseapp($json)");
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      );
      await _webviewController.loadRequest(Uri.parse(url),);

      _webviewController.addJavaScriptChannel(jsChannel,
          onMessageReceived: (message) {
        showCustomDialog(
            context: _context,
            title: "React sent to Flutter",
            content: message.message);
      });
    } catch (e) {
      promptToExit();
    }
  }
}
