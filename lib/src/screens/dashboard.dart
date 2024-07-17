import 'package:dashboard/src/screens/widgets/tabview_summary.dart';
import 'package:dashboard/src/widgets/custom_webview.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  final webviewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  var webviewVisible = false;

  void setWebviewVisible(bool bl) {
    setState(() {
      webviewVisible = bl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomWwebview(
        child: MaterialApp(
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
    )));
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
  Icon(Icons.pending_sharp),
];
