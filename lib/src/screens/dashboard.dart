import 'dart:convert';

import 'package:dashboard/src/screens/dashboard_modal.dart';
import 'package:dashboard/src/screens/widgets/net_worth.dart';
import 'package:dashboard/src/screens/widgets/tabview_summary.dart';
import 'package:dashboard/src/widgets/custom_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  late final WebViewController webviewController;
  final jsChannel = "CUSTOM_JS_CHANNEL";

  int _index = 0;

  bool isWebviewVisible() {
    return _index == 1;
  }

  void showWebview() {
    setState(() {
      _index = 1;
    });
  }

  void hideWebview() {
    setState(() {
      _index = 0;
    });
  }

  Future<void> goback() async {
    if (await webviewController.canGoBack()) {
      webviewController.goBack();
    } else {
      hideWebview();
    }
  }

  void renderBaseapp(String url, Map<String, dynamic>? params) {
    if (!isWebviewVisible()) {
      showWebview();
    }
    try {
      webviewController
        ..setNavigationDelegate(
          NavigationDelegate(
            onWebResourceError: (error) {
              if (kDebugMode) {
                print("onWebResourceError");
                print(error);
              }
              promptToExit(error.description);
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
                print(url);
              }
              webviewController.runJavaScript("renderBaseapp($json)");
            },
            onNavigationRequest: (NavigationRequest request) {
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(url));
    } catch (e) {
      promptToExit(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    webviewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(jsChannel, onMessageReceived: (message) {
        showCustomDialog(
            context: context,
            title: "React sent to Flutter",
            content: message.message);
      });
  }

  @override
  void dispose() {
    super.dispose();
    webviewController.removeJavaScriptChannel(jsChannel);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DashboardModal(
          showWebview, hideWebview, renderBaseapp, isWebviewVisible),
      child: IndexedStack(index: _index, children: [
        MaterialApp(
            home: DefaultTabController(
          length: _tabs.length,
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 0,
              bottom: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: _tabs,
                indicatorColor: Colors.red,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3.0,
                padding: const EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            body: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TabBarView(children: _tabviews),
            ),
          ),
        )),
        _index == 0
            ? Container()
            : Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: goback,
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                ),
                body: WebViewWidget(
                  controller: webviewController,
                )),
      ]),
    );
  }

  void promptToExit(String error) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text("Error"),
              content: Text(error),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    hideWebview();
                    Navigator.of(context).pop();
                  },
                ),
              ]);
        });
  }
}

Widget _createTabItem(String text) {
  return SizedBox(
      height: 40,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ));
}

List<Widget> _tabs = [_createTabItem("Summary"), _createTabItem("Net worth")];

const List<Widget> _tabviews = [
  TabviewSummary(),
  NetWorth(),
];
