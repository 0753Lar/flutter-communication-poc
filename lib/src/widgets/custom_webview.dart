import 'package:dashboard/src/widgets/custom_webview_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWwebview extends StatefulWidget {
  final Widget child;
  const CustomWwebview({super.key, required this.child});

  @override
  State<CustomWwebview> createState() => _CustomWwebview();
}

class _CustomWwebview extends State<CustomWwebview> {
  var webviewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  bool webviewVisible = false;
  void setWebviewVisible(bool visible) {
    setState(() {
      webviewVisible = visible;
    });
  }

  Future<void> goback() async {
    if (await webviewController.canGoBack()) {
      webviewController.goBack();
    } else {
      setWebviewVisible(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          CustomWebviewModal(webviewController, setWebviewVisible),
      child: !webviewVisible
          ? widget.child
          : Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: goback,
                  icon: const Icon(Icons.arrow_back_ios),
                ),
              ),
              body: WebViewWidget(controller: webviewController),
            ),
    );
  }
}
