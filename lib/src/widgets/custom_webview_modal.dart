import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebviewModal extends ChangeNotifier {
  final WebViewController _webviewController;
  final Function _setWebviewVisible;

  CustomWebviewModal(
    this._webviewController,
    this._setWebviewVisible,
  );

  void renderBaseapp(String url, Map<String, dynamic>? params) async {
    try {
      _setWebviewVisible(true);
      await _webviewController.setNavigationDelegate(
        NavigationDelegate(
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
      await _webviewController.loadRequest(Uri.parse(url));
    } catch (e) {
      rethrow;
    }
  }
}
